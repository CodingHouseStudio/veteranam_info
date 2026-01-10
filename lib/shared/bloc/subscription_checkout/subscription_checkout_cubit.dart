import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veteranam/shared/constants/failure_enum.dart';
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
              error: SubscriptionCheckoutError.createSessionFailed,
            ),
          );
        }
        return;
      }

      final uri = Uri.parse(checkoutUrl);
      final launched = await launchUrl(
        uri,
        webOnlyWindowName: '_self',
      );

      if (!launched) {
        if (!isClosed) {
          emit(
            const SubscriptionCheckoutState(
              status: SubscriptionCheckoutStatus.failure,
              error: SubscriptionCheckoutError.launchUrlFailed,
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
          const SubscriptionCheckoutState(
            status: SubscriptionCheckoutStatus.failure,
            error: SubscriptionCheckoutError.unknown,
          ),
        );
      }
    }
  }

  String _getSuccessUrl() {
    return '${Uri.base.origin}/discounts/manage/company/subscription/success';
  }

  String _getCancelUrl() {
    return '${Uri.base.origin}/discounts/manage/company/subscription/canceled';
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
