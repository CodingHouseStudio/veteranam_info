import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/bloc/subscription_checkout/subscription_checkout_cubit.dart';
import 'package:veteranam/shared/constants/failure_enum.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class StartFreeTrialButton extends StatelessWidget {
  const StartFreeTrialButton({
    required this.companyId,
    required this.isDesk,
    super.key,
  });

  final String companyId;
  final bool isDesk;

  String _getErrorMessage(
    BuildContext context,
    SubscriptionCheckoutError? error,
  ) {
    if (error == null) {
      return context.l10n.subscriptionCheckoutErrorUnknown;
    }

    switch (error) {
      case SubscriptionCheckoutError.createSessionFailed:
        return context.l10n.subscriptionCheckoutErrorCreateSessionFailed;
      case SubscriptionCheckoutError.launchUrlFailed:
        return context.l10n.subscriptionCheckoutErrorLaunchUrlFailed;
      case SubscriptionCheckoutError.unknown:
        return context.l10n.subscriptionCheckoutErrorUnknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<SubscriptionCheckoutCubit>(),
      child: BlocConsumer<SubscriptionCheckoutCubit, SubscriptionCheckoutState>(
        listener: (context, state) {
          if (state.status == SubscriptionCheckoutStatus.failure) {
            final errorMessage = _getErrorMessage(context, state.error);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: AppColors.materialThemeRefErrorError40,
              ),
            );

            // Reset state after showing error
            context.read<SubscriptionCheckoutCubit>().reset();
          }
        },
        builder: (context, state) {
          final isLoading = state.status == SubscriptionCheckoutStatus.loading;

          return SkeletonizerWidget(
            isLoading: isLoading,
            child: BoxWidget(
              text: context.l10n.startFreeTrial,
              iconText: context.l10n.unlockDiscountFeatures,
              onTap: isLoading
                  ? null
                  : () {
                      context.read<SubscriptionCheckoutCubit>().openCheckout(
                            companyId: companyId,
                          );
                    },
              isDesk: isDesk,
              icon: const Icon(
                Icons.rocket_launch,
                color: AppColors.materialThemeRefPrimaryPrimary40,
              ),
            ),
          );
        },
      ),
    );
  }
}
