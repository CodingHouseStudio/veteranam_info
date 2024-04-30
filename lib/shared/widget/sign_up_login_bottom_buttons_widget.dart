import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class SignUpLoginBottomButtonsWidget extends StatelessWidget {
  const SignUpLoginBottomButtonsWidget({
    required this.isDesk,
    required this.title,
    super.key,
  });
  final bool isDesk;
  final String title;
  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return Column(
        crossAxisAlignment:
            isDesk ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        key: KWidgetkeys.widget.signUpBottomButtons.desk,
        children: [
          Row(
            children: [
              Expanded(
                child: Divider(
                  key: KWidgetkeys.widget.signUpBottomButtons.divider,
                ),
              ),
              KSizedBox.kWidthSizedBox32,
              Text(
                context.l10n.or,
                key: KWidgetkeys.widget.signUpBottomButtons.or,
                style: AppTextStyle.hint24,
              ),
              KSizedBox.kWidthSizedBox32,
              Expanded(
                child: Divider(
                  key: KWidgetkeys.widget.signUpBottomButtons.divider,
                ),
              ),
            ],
          ),
          KSizedBox.kHeightSizedBox40,
          Text(
            title,
            key: KWidgetkeys.widget.signUpBottomButtons.title,
            style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
          ),
          KSizedBox.kHeightSizedBox16,
          Row(
            children: [
              Expanded(
                child: buildBottomButton(
                  key: KWidgetkeys.widget.signUpBottomButtons.google,
                  isDesk: true,
                  text: context.l10n.google,
                  onPressed: () => context
                      .read<AuthenticationServicesCubit>()
                      .authenticationUseGoogle(),
                  icon: KIcon.google,
                ),
              ),
              KSizedBox.kWidthSizedBox16,
              Expanded(
                child: buildBottomButton(
                  key: KWidgetkeys.widget.signUpBottomButtons.facebook,
                  isDesk: true,
                  text: context.l10n.facebook,
                  onPressed: () => {},
                  icon: KIcon.facebook,
                ),
              ),
              KSizedBox.kWidthSizedBox16,
              Expanded(
                child: buildBottomButton(
                  key: KWidgetkeys.widget.signUpBottomButtons.apple,
                  isDesk: true,
                  text: context.l10n.apple,
                  onPressed: () {},
                  icon: KIcon.apple,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        key: KWidgetkeys.widget.signUpBottomButtons.mob,
        children: [
          Text(
            context.l10n.or,
            key: KWidgetkeys.widget.signUpBottomButtons.or,
            style: isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
          ),
          KSizedBox.kHeightSizedBox16,
          Text(
            context.l10n.signUpWith,
            key: KWidgetkeys.widget.signUpBottomButtons.title,
            style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
          ),
          KSizedBox.kHeightSizedBox16,
          buildBottomButton(
            key: KWidgetkeys.widget.signUpBottomButtons.google,
            isDesk: false,
            text: context.l10n.google,
            onPressed: () => context
                .read<AuthenticationServicesCubit>()
                .authenticationUseGoogle(),
            icon: KIcon.google,
          ),
          KSizedBox.kHeightSizedBox16,
          buildBottomButton(
            key: KWidgetkeys.widget.signUpBottomButtons.facebook,
            isDesk: false,
            text: context.l10n.facebook,
            onPressed: () {},
            icon: KIcon.facebook,
          ),
          KSizedBox.kHeightSizedBox16,
          buildBottomButton(
            key: KWidgetkeys.widget.signUpBottomButtons.apple,
            isDesk: false,
            text: context.l10n.apple,
            onPressed: () {},
            icon: KIcon.apple,
          ),
        ],
      );
    }
  }

  Widget buildBottomButton({
    required bool isDesk,
    required String text,
    required void Function() onPressed,
    required Icon icon,
    required Key key,
  }) {
    return ButtonWidget(
      key: key,
      onPressed: onPressed,
      icon: Padding(
        padding: const EdgeInsets.only(right: KPadding.kPaddingSize4),
        child: icon,
      ),
      padding: isDesk
          ? const EdgeInsets.only(
              left: KPadding.kPaddingSize16,
              right: KPadding.kPaddingSize24,
              top: KPadding.kPaddingSize8,
              bottom: KPadding.kPaddingSize8,
            )
          : const EdgeInsets.symmetric(
              vertical: KPadding.kPaddingSize16,
            ),
      // backgroundColor: AppColors.white,
      textStyle: AppTextStyle.text20,
      text: text,
      isDesk: isDesk,
    );
  }
}
