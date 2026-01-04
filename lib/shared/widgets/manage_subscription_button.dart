import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/bloc/subscription_portal/subscription_portal_cubit.dart';
import 'package:veteranam/shared/shared_flutter.dart';

/// Button that opens the Stripe Customer Portal
/// Allows users to manage their subscription, payment methods, and invoices
/// Styled to match BoxWidget
class ManageSubscriptionButton extends StatelessWidget {
  const ManageSubscriptionButton({
    required this.companyId,
    required this.isDesk,
    this.onError,
    super.key,
  });

  final String companyId;
  final bool isDesk;
  final void Function(String error)? onError;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<SubscriptionPortalCubit>(),
      child: BlocConsumer<SubscriptionPortalCubit, SubscriptionPortalState>(
        listener: (context, state) {
          if (state.status == SubscriptionPortalStatus.failure) {
            final errorMessage = state.errorMessage ?? 'Unknown error';
            onError?.call(errorMessage);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: $errorMessage'),
                backgroundColor: AppColors.materialThemeRefErrorError40,
              ),
            );

            // Reset state after showing error
            context.read<SubscriptionPortalCubit>().reset();
          }
        },
        builder: (context, state) {
          final isLoading = state.status == SubscriptionPortalStatus.loading;

          return SkeletonizerWidget(
            isLoading: isLoading,
            child: BoxWidget(
              text: context.l10n.manageSubscription,
              onTap: isLoading
                  ? null
                  : () {
                      final returnUrl = kIsWeb
                          ? '${Uri.base.origin}/discounts/manage'
                          : 'veteranam://discounts/manage';

                      context.read<SubscriptionPortalCubit>().openPortal(
                            companyId: companyId,
                            returnUrl: returnUrl,
                          );
                    },
              isDesk: isDesk,
              icon: const Icon(
                Icons.settings,
                color: AppColors.materialThemeRefPrimaryPrimary40,
              ),
            ),
          );
        },
      ),
    );
  }
}
