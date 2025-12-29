import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/company/company.dart';
import 'package:veteranam/shared/shared_flutter.dart';
import 'package:veteranam/shared/widgets/manage_subscription_button.dart';
import 'package:veteranam/shared/widgets/subscription_info_widget.dart';

class CompanyBodyWidget extends StatelessWidget {
  const CompanyBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainDeskPadding: ({required maxWidth}) => maxWidth.screenPadding(
        precent: KDimensions.tenPercent,
      ),
      titleChildWidgetsFunction: ({required isDesk}) => [
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox24,
        ShortTitleIconWidget(
          title: context.l10n.myCompany,
          titleKey: CompanyKeys.title,
          isDesk: isDesk,
          icon: KIcon.arrowDownRight,
          firstIcon: !isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else ...[
          KSizedBox.kHeightSizedBox24,
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              key: CompanyKeys.boxMyDiscounts,
              onPressed: () => myDiscountTap(context),
              child: Column(
                spacing: KPadding.kPaddingSize4,
                children: [
                  const IconWidget(
                    icon: KIcon.tag,
                    background: AppColors.materialThemeKeyColorsNeutral,
                  ),
                  Text(
                    context.l10n.myDiscounts,
                    style: AppTextStyle.materialThemeLabelSmall,
                  ),
                ],
              ),
            ),
          ),
          KSizedBox.kHeightSizedBox24,
        ],
        const Divider(
          color: AppColors.materialThemeRefNeutralNeutral90,
        ),
      ],
      isForm: true,
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        KSizedBox.kHeightSizedBox48,
        if (isDesk)
          Row(
            spacing: KPadding.kPaddingSize32,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _form(isDesk: isDesk, context: context),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  spacing: KPadding.kPaddingSize16,
                  children: [
                    BoxWidget(
                      key: CompanyKeys.boxMyDiscounts,
                      text: context.l10n.myDiscounts,
                      onTap: () => myDiscountTap(context),
                      isDesk: isDesk,
                    ),
                    _buildManageSubscriptionBox(context, isDesk),
                  ],
                ),
              ),
            ],
          )
        else
          Column(
            children: [
              _form(isDesk: isDesk, context: context),
              KSizedBox.kHeightSizedBox16,
              _buildManageSubscriptionBox(context, isDesk),
            ],
          ),
        if (isDesk)
          KSizedBox.kHeightSizedBox48
        else
          KSizedBox.kHeightSizedBox16,
      ],
    );
  }

  Widget _form({
    required bool isDesk,
    required BuildContext context,
  }) =>
      CompanyFormWidget(
        isDesk: isDesk,
        initialCompanyName:
            context.read<CompanyWatcherBloc>().state.company.companyName,
        initialEmail: context.read<UserWatcherBloc>().state.user.email,
        initialCode: context.read<CompanyWatcherBloc>().state.company.code,
        initialLink: context.read<CompanyWatcherBloc>().state.company.link,
        initialPublicName:
            context.read<CompanyWatcherBloc>().state.company.publicName,
      );

  void myDiscountTap(
    BuildContext context,
  ) =>
      context.goNamed(KRoute.myDiscounts.name);

  Widget _buildManageSubscriptionBox(BuildContext context, bool isDesk) {
    return BlocBuilder<CompanyWatcherBloc, CompanyWatcherState>(
      builder: (context, companyState) {
        final company = companyState.company;
        final companyId = company.id;
        final customerId = company.stripeCustomerId;

        if (companyId.isEmpty ||
            companyId == '__company_cache_id__' ||
            companyId == '__compnay_cache_id__') {
          return const SizedBox.shrink();
        }

        final hasSubscription = customerId != null && customerId.isNotEmpty;

        if (!hasSubscription) {
          return const SizedBox.shrink();
        }

        return Column(
          spacing: KPadding.kPaddingSize16,
          children: [
            // Subscription Information Card
            SubscriptionInfoWidget(
              company: company,
              isDesk: isDesk,
            ),
            // Manage Subscription Button styled as BoxWidget
            ManageSubscriptionButton(
              companyId: companyId,
              isDesk: isDesk,
            ),
          ],
        );
      },
    );
  }
}
