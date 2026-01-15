import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veteranam/shared/constants/failure_enum.dart';
import 'package:veteranam/shared/services/subscription_service.dart';

part 'subscription_portal_state.dart';

@injectable
class SubscriptionPortalCubit extends Cubit<SubscriptionPortalState> {
  SubscriptionPortalCubit({
    required SubscriptionService subscriptionService,
  })  : _subscriptionService = subscriptionService,
        super(
          const SubscriptionPortalState(
            status: SubscriptionPortalStatus.initial,
          ),
        );

  final SubscriptionService _subscriptionService;

  Future<void> openPortal({
    required String companyId,
    required String returnUrl,
  }) async {
    if (!isClosed) {
      emit(
        const SubscriptionPortalState(
          status: SubscriptionPortalStatus.loading,
        ),
      );
    }

    try {
      final portalUrl = await _subscriptionService.createPortalSession(
        companyId: companyId,
        returnUrl: returnUrl,
      );

      if (portalUrl == null) {
        if (!isClosed) {
          emit(
            const SubscriptionPortalState(
              status: SubscriptionPortalStatus.failure,
              error: SubscriptionPortalError.createSessionFailed,
            ),
          );
        }
        return;
      }

      // Redirect in the same tab to avoid popup blockers on mobile web
      final uri = Uri.parse(portalUrl);
      final launched = await launchUrl(
        uri,
        webOnlyWindowName: '_self',
      );

      if (!launched) {
        if (!isClosed) {
          emit(
            const SubscriptionPortalState(
              status: SubscriptionPortalStatus.failure,
              error: SubscriptionPortalError.launchUrlFailed,
            ),
          );
        }
        return;
      }

      if (!isClosed) {
        emit(
          const SubscriptionPortalState(
            status: SubscriptionPortalStatus.success,
          ),
        );
      }
    } on SubscriptionException catch (e) {
      // Log the detailed error for debugging
      debugPrint('SubscriptionException in openPortal: ${e.message}');

      if (!isClosed) {
        emit(
          const SubscriptionPortalState(
            status: SubscriptionPortalStatus.failure,
            error: SubscriptionPortalError.createSessionFailed,
          ),
        );
      }
    } catch (e) {
      // Log unexpected errors for debugging
      debugPrint('Unexpected error in openPortal: $e');

      if (!isClosed) {
        emit(
          const SubscriptionPortalState(
            status: SubscriptionPortalStatus.failure,
            error: SubscriptionPortalError.unknown,
          ),
        );
      }
    }
  }

  void reset() {
    if (!isClosed) {
      emit(
        const SubscriptionPortalState(
          status: SubscriptionPortalStatus.initial,
        ),
      );
    }
  }
}
