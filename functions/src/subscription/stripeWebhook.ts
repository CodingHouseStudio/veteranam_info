import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { stripe, getStripeConfig } from "../config/stripe";
import Stripe from "stripe";

export const handleStripeWebhook = functions.https.onRequest(
  async (req, res) => {
    const sig = req.headers["stripe-signature"] as string;

    if (!sig) {
      console.error("No Stripe signature found");
      res.status(400).send("No signature found");
      return;
    }

    let event: Stripe.Event;

    try {
      const config = getStripeConfig();
      event = stripe.webhooks.constructEvent(
        req.rawBody,
        sig,
        config.webhookSecret
      );
    } catch (err: any) {
      console.error("Webhook signature verification failed:", err.message);
      res.status(400).send(`Webhook Error: ${err.message}`);
      return;
    }

    console.log("Received Stripe webhook event:", event.type);

    try {
      switch (event.type) {
        case "checkout.session.completed":
          await handleCheckoutSessionCompleted(
            event.data.object as Stripe.Checkout.Session
          );
          break;

        case "customer.subscription.created":
          await handleSubscriptionCreated(
            event.data.object as Stripe.Subscription
          );
          break;

        case "customer.subscription.updated":
          await handleSubscriptionUpdated(
            event.data.object as Stripe.Subscription
          );
          break;

        case "customer.subscription.deleted":
          await handleSubscriptionDeleted(
            event.data.object as Stripe.Subscription
          );
          break;

        case "invoice.payment_succeeded":
          await handleInvoicePaymentSucceeded(
            event.data.object as Stripe.Invoice
          );
          break;

        case "invoice.payment_failed":
          await handleInvoicePaymentFailed(
            event.data.object as Stripe.Invoice
          );
          break;

        default:
          console.log(`Unhandled event type: ${event.type}`);
      }

      res.json({ received: true });
    } catch (error: any) {
      console.error("Error processing webhook:", error);
      res.status(500).send("Webhook processing failed: " + error.message);
    }
  }
);

async function handleCheckoutSessionCompleted(
  session: Stripe.Checkout.Session
) {
  const companyId = session.client_reference_id || session.metadata?.companyId;

  if (!companyId) {
    console.error("No company ID found in checkout session");
    return;
  }

  console.log(`Processing checkout session for company: ${companyId}`);
  console.log(`Session customer ID: ${session.customer}`);
  console.log(`Session subscription ID: ${session.subscription}`);

  const trialEnd = new Date();
  trialEnd.setDate(trialEnd.getDate() + 30);

  // Get existing company data to check for existing customer
  const companyRef = admin.firestore().collection("companies").doc(companyId);
  const companyDoc = await companyRef.get();
  const existingCustomerId = companyDoc.data()?.stripeCustomerId;

  console.log(`Existing customer ID in Firestore: ${existingCustomerId}`);
  console.log(`Customer ID from session: ${session.customer}`);

  // Warn if customer IDs don't match
  if (existingCustomerId && existingCustomerId !== session.customer) {
    console.warn(
      `WARNING: Customer ID mismatch! ` +
      `Firestore has ${existingCustomerId}, ` +
      `session has ${session.customer}. ` +
      `This indicates a duplicate customer was created.`
    );
  }

  // Update company document
  // Only update stripeCustomerId if it doesn't exist yet
  const updateData: any = {
    stripeSubscriptionId: session.subscription,
    subscriptionStatus: "trialing",
    subscriptionPlan: "basic",
    trialStartedAt: admin.firestore.FieldValue.serverTimestamp(),
    trialExpiresAt: admin.firestore.Timestamp.fromDate(trialEnd),
  };

  // Only set customer ID if not already set
  if (!existingCustomerId) {
    updateData.stripeCustomerId = session.customer;
  }

  await companyRef.update(updateData);

  // Create subscription record
  if (session.subscription) {
    const subscriptionId = session.subscription as string;
    // Use existing customer ID if available, otherwise use session customer
    const finalCustomerId = existingCustomerId || (session.customer as string);

    await admin.firestore()
      .collection("subscriptions")
      .doc(subscriptionId)
      .set({
        id: subscriptionId,
        companyId,
        stripeSubscriptionId: subscriptionId,
        stripeCustomerId: finalCustomerId,
        status: "trialing",
        plan: "basic",
        priceId: session.line_items?.data[0]?.price?.id || "",
        amount: (session.amount_total || 0) / 100,
        currency: session.currency || "usd",
        trialStartedAt: admin.firestore.FieldValue.serverTimestamp(),
        trialExpiresAt: admin.firestore.Timestamp.fromDate(trialEnd),
        cancelAtPeriodEnd: false,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
  }

  console.log(`Trial activated for company: ${companyId}`);
}

async function handleSubscriptionCreated(subscription: Stripe.Subscription) {
  const companyId = subscription.metadata?.companyId;

  if (!companyId) {
    console.error("No company ID found in subscription metadata");
    return;
  }

  console.log(`Subscription created for company: ${companyId}`);
}

async function handleSubscriptionUpdated(subscription: Stripe.Subscription) {
  const companyId = subscription.metadata?.companyId;

  if (!companyId) {
    console.error("No company ID found in subscription metadata");
    return;
  }

  console.log(
    `Subscription updated for company ${companyId}: ${subscription.status}`
  );

  const updateData: any = {
    subscriptionStatus: subscription.status,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  };

  // Handle trial to active conversion
  if (subscription.status === "active" && subscription.trial_end) {
    const trialEndDate = new Date(subscription.trial_end * 1000);
    if (new Date() >= trialEndDate) {
      updateData.subscriptionStartedAt =
        admin.firestore.FieldValue.serverTimestamp();
    }
  }

  // Handle subscription expiry
  if (subscription.current_period_end) {
    updateData.subscriptionExpiresAt = admin.firestore.Timestamp.fromDate(
      new Date(subscription.current_period_end * 1000)
    );
  }

  // Handle cancellation
  if (subscription.cancel_at_period_end) {
    updateData.canceledBy = "customer";
    updateData.canceledAt = admin.firestore.FieldValue.serverTimestamp();
  }

  // Update company document
  await admin.firestore()
    .collection("companies")
    .doc(companyId)
    .update(updateData);

  // Update subscription document
  await admin.firestore()
    .collection("subscriptions")
    .doc(subscription.id)
    .update({
      status: subscription.status,
      currentPeriodStart: subscription.current_period_start ?
        admin.firestore.Timestamp.fromDate(
          new Date(subscription.current_period_start * 1000)
        ) : null,
      currentPeriodEnd: subscription.current_period_end ?
        admin.firestore.Timestamp.fromDate(
          new Date(subscription.current_period_end * 1000)
        ) : null,
      cancelAtPeriodEnd: subscription.cancel_at_period_end,
      canceledAt: subscription.canceled_at ?
        admin.firestore.Timestamp.fromDate(
          new Date(subscription.canceled_at * 1000)
        ) : null,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
}

async function handleSubscriptionDeleted(subscription: Stripe.Subscription) {
  const companyId = subscription.metadata?.companyId;

  if (!companyId) {
    console.error("No company ID found in subscription metadata");
    return;
  }

  console.log(`Subscription deleted for company: ${companyId}`);

  // Update company document
  await admin.firestore().collection("companies").doc(companyId).update({
    subscriptionStatus: "canceled",
    canceledAt: admin.firestore.FieldValue.serverTimestamp(),
    canceledBy: "stripe",
  });

  // Update subscription document
  await admin.firestore()
    .collection("subscriptions")
    .doc(subscription.id)
    .update({
      status: "canceled",
      canceledAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
}

async function handleInvoicePaymentSucceeded(invoice: Stripe.Invoice) {
  const companyId = invoice.subscription_details?.metadata?.companyId;

  if (!companyId) {
    console.error("No company ID found in invoice");
    return;
  }

  console.log(`Payment succeeded for company: ${companyId}`);

  // Create payment history record
  await admin.firestore().collection("payment_history").add({
    companyId,
    subscriptionId: invoice.subscription as string,
    stripePaymentIntentId: invoice.payment_intent as string,
    stripeInvoiceId: invoice.id,
    amount: invoice.amount_paid / 100,
    currency: invoice.currency,
    status: "succeeded",
    type: "subscription",
    receiptUrl: invoice.hosted_invoice_url,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    paidAt: admin.firestore.FieldValue.serverTimestamp(),
  });
}

async function handleInvoicePaymentFailed(invoice: Stripe.Invoice) {
  const companyId = invoice.subscription_details?.metadata?.companyId;

  if (!companyId) {
    console.error("No company ID found in invoice");
    return;
  }

  console.log(`Payment failed for company: ${companyId}`);

  // Create payment history record
  await admin.firestore().collection("payment_history").add({
    companyId,
    subscriptionId: invoice.subscription as string,
    stripePaymentIntentId: invoice.payment_intent as string,
    stripeInvoiceId: invoice.id,
    amount: invoice.amount_due / 100,
    currency: invoice.currency,
    status: "failed",
    type: "subscription",
    failureReason: "Payment failed",
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Update company subscription status
  await admin.firestore().collection("companies").doc(companyId).update({
    subscriptionStatus: "past_due",
  });
}
