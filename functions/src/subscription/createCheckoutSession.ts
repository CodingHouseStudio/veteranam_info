import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { stripe, getStripeConfig, STRIPE_CONFIG } from "../config/stripe";

interface CreateCheckoutSessionData {
  companyId: string;
  successUrl?: string;
  cancelUrl?: string;
}

export const createStripeCheckoutSession = functions.https.onCall(
  async (data: CreateCheckoutSessionData, context) => {
    // Verify authentication
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated to create checkout session"
      );
    }

    const { companyId, successUrl, cancelUrl } = data;

    if (!companyId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Company ID is required"
      );
    }

    try {
      // Get company document
      const companyRef = admin.firestore().collection("companies").doc(companyId);
      const companyDoc = await companyRef.get();

      if (!companyDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Company not found"
        );
      }

      const companyData = companyDoc.data();

      // Verify user owns this company
      const userEmail = context.auth.token.email;
      if (!companyData?.userEmails?.includes(userEmail)) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "You do not have permission to manage this company"
        );
      }

      // Check if company already has an active subscription
      if (companyData?.subscriptionStatus === "active" ||
          companyData?.subscriptionStatus === "trialing") {
        throw new functions.https.HttpsError(
          "already-exists",
          "Company already has an active subscription"
        );
      }

      // Get or create Stripe customer
      let customerId = companyData?.stripeCustomerId;

      console.log(`Creating checkout for company ${companyId}`);
      console.log(`Existing customer ID: ${customerId}`);

      if (!customerId) {
        console.log(`No existing customer, creating new customer for ${userEmail}`);
        const customer = await stripe.customers.create({
          email: userEmail,
          metadata: {
            companyId,
            companyName: companyData?.companyName || "",
          },
        });
        customerId = customer.id;
        console.log(`Created new customer: ${customerId}`);

        // Save customer ID to company document
        await companyRef.update({
          stripeCustomerId: customerId,
        });
        console.log(`Saved customer ID to Firestore`);
      } else {
        console.log(`Reusing existing customer: ${customerId}`);
      }

      const config = getStripeConfig();

      console.log(`Creating checkout session with customer: ${customerId}`);

      // Create Stripe Checkout Session
      const session = await stripe.checkout.sessions.create({
        customer: customerId,
        client_reference_id: companyId,
        mode: "subscription",
        payment_method_types: ["card"],
        line_items: [
          {
            price: config.priceId,
            quantity: 1,
          },
        ],
        subscription_data: {
          trial_period_days: STRIPE_CONFIG.TRIAL_PERIOD_DAYS,
          trial_settings: {
            end_behavior: {
              missing_payment_method: "cancel",
            },
          },
          metadata: {
            companyId,
          },
        },
        success_url: successUrl ||
          `${functions.config().app?.url}/subscription/success?session_id={CHECKOUT_SESSION_ID}`,
        cancel_url: cancelUrl ||
          `${functions.config().app?.url}/subscription/canceled`,
        metadata: {
          companyId,
        },
      });

      console.log(`Checkout session created: ${session.id}`);
      console.log(`Session URL: ${session.url}`);
      console.log(`Session customer: ${session.customer}`);

      return {
        sessionId: session.id,
        sessionUrl: session.url,
      };
    } catch (error: any) {
      console.error("Error creating checkout session:", error);

      if (error instanceof functions.https.HttpsError) {
        throw error;
      }

      throw new functions.https.HttpsError(
        "internal",
        "Failed to create checkout session: " + error.message
      );
    }
  }
);
