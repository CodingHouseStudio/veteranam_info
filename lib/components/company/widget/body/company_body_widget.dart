import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/company/company.dart';
import 'package:veteranam/shared/shared.dart';

class CompanyBodyWidget extends StatelessWidget {
  const CompanyBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyFormBloc, CompanyFormState>(
      listener: (context, state) {
        if (state.formState == CompanyFormEnum.delete) {
          context.goNamed(KRoute.myDiscounts.name);
        }
      },
      buildWhen: (previous, current) =>
          previous.formState != current.formState ||
          previous.image != current.image,
      builder: (context, state) {
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
              titleKey: KWidgetkeys.screen.profile.title,
              isDesk: isDesk,
              icon: KIcon.arrowDownRight,
              firstIcon: !isDesk,
            ),
            if (isDesk) ...[
              KSizedBox.kHeightSizedBox32,
              const Divider(
                color: AppColors.materialThemeKeyColorsNeutral,
              ),
            ] else ...[
              KSizedBox.kHeightSizedBox24,
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
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
              const Divider(
                color: AppColors.materialThemeKeyColorsNeutral,
              ),
            ],
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
      },
    );
  }

  Widget _form({
    required bool isDesk,
    required BuildContext context,
  }) =>
      CompanyFormWidget(
        isDesk: isDesk,
        photoURL: context
            .read<CompanyWatcherBloc>()
            .state
            .company
            .image
            ?.downloadURL
            .getImageUrl,
        imageBytes: context.read<CompanyFormBloc>().state.image.value?.bytes,
        initialCompanyName:
            context.read<CompanyWatcherBloc>().state.company.companyName,
        initialEmail: context.read<AuthenticationBloc>().state.user.email,
        initialCode: context.read<CompanyWatcherBloc>().state.company.code,
        initialLink: context.read<CompanyWatcherBloc>().state.company.link,
      );

  void myDiscountTap(
    BuildContext context,
  ) =>
      context.goNamed(KRoute.myDiscounts.name);
}