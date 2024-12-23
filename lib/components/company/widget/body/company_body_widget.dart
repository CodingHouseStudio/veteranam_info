import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/company/company.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
          titleKey: KWidgetkeys.screen.company.title,
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
              key: KWidgetkeys.screen.company.boxMyDiscounts,
              onPressed: () => myDiscountTap(context),
              child: Column(
                children: [
                  const IconWidget(
                    icon: KIcon.tag,
                    background: AppColors.materialThemeKeyColorsNeutral,
                  ),
                  KSizedBox.kHeightSizedBox4,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _form(isDesk: isDesk, context: context),
              ),
              KSizedBox.kWidthSizedBox32,
              Expanded(
                flex: 2,
                child: BoxWidget(
                  key: KWidgetkeys.screen.company.boxMyDiscounts,
                  text: context.l10n.myDiscounts,
                  onTap: () => myDiscountTap(context),
                  isDesk: isDesk,
                ),
              ),
            ],
          )
        else
          _form(isDesk: isDesk, context: context),
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
}
