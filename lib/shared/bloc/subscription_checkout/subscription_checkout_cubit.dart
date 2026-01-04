import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veteranam/shared/services/subscription_service.dart';

part 'subscription_checkout_state.dart';

@injectable
class SubscriptionCheckoutCubit extends Cubit<SubscriptionCheckoutState> {
  SubscriptionCheckoutCubit({
    required SubscriptionService subscriptionService,
  })  : _subscriptionService = subscriptionService,
        super(
          const SubscriptionCheckoutState(
            status: SubscriptionCheckoutStatus.initial,
          ),
        );

  final SubscriptionService _subscriptionService;

  Future<void> openCheckout({
    required String companyId,
  }) async {
    if (!isClosed) {
      emit(
        const SubscriptionCheckoutState(
          status: SubscriptionCheckoutStatus.loading,
        ),
      );
    }

    try {
      final checkoutUrl = await _subscriptionService.createCheckoutSession(
        companyId: companyId,
        successUrl: _getSuccessUrl(),
        cancelUrl: _getCancelUrl(),
      );

      if (checkoutUrl == null) {
        if (!isClosed) {
          emit(
            const SubscriptionCheckoutState(
              status: SubscriptionCheckoutStatus.failure,
              errorMessage: 'Failed to create checkout session',
            ),
          );
        }
        return;
      }

      final uri = Uri.parse(checkoutUrl);
      final launched = await launchUrl(
        uri,
        mode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );

      if (!launched) {
        if (!isClosed) {
          emit(
            const SubscriptionCheckoutState(
              status: SubscriptionCheckoutStatus.failure,
              errorMessage:
                  'Failed to open Stripe Checkout. Please check your browser settings.',
            ),
          );
        }
        return;
      }

      if (!isClosed) {
        emit(
          const SubscriptionCheckoutState(
            status: SubscriptionCheckoutStatus.success,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          SubscriptionCheckoutState(
            status: SubscriptionCheckoutStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  String _getSuccessUrl() {
    if (kIsWeb) {
      return '${Uri.base.origin}/discounts/manage/subscription-success';
    }
    return 'veteranam://discounts/manage/subscription-success';
  }

  String _getCancelUrl() {
    if (kIsWeb) {
      return '${Uri.base.origin}/discounts/manage/subscription-canceled';
    }
    return 'veteranam://discounts/manage/subscription-canceled';
  }

  void reset() {
    if (!isClosed) {
      emit(
        const SubscriptionCheckoutState(
          status: SubscriptionCheckoutStatus.initial,
        ),
      );
    }
  }
}
