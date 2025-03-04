import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class SignUpLoginServiceWidget extends StatelessWidget {
  const SignUpLoginServiceWidget({
    required this.isDesk,
    // required this.title,
    super.key,
  });

  final bool isDesk;
  // final String title;

  @override
  Widget build(BuildContext context) {
    // if (isDesk) {
    // return Column(
    //   crossAxisAlignment:
    //       isDesk ? CrossAxisAlignment.start : CrossAxisAlignment.center,
    //   //key: SignUpBottomButtonsKeys.desk,
    //   children: [
    // Row(
    //   children: [
    //     const Expanded(
    //       child: Divider(
    //           //key: SignUpBottomButtonsKeys.divider,
    //           ),
    //     ),
    //     KSizedBox.kWidthSizedBox32,
    //     Text(
    //       context.l10n.or,
    //       key: SignUpBottomButtonsKeys.or,
    //       style: AppTextStyle.hint14,
    //     ),
    //     KSizedBox.kWidthSizedBox32,
    //     const Expanded(
    //       child: Divider(
    //           //key: SignUpBottomButtonsKeys.divider,
    //           ),
    //     ),
    //   ],
    // ),
    // KSizedBox.kHeightSizedBox40,
    // Text(
    //   title,
    //   key: SignUpBottomButtonsKeys.title,
    //   style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
    // ),
    // KSizedBox.kHeightSizedBox16,
    if (PlatformEnum.getPlatform.isAndroid) {
      return googleButton(context: context, isDesk: isDesk);
    } else {
      return Wrap(
        spacing: KPadding.kPaddingSize16,
        runSpacing: KPadding.kPaddingSize8,
        children: [
          googleButton(context: context, isDesk: isDesk),
          _button(
            key: SignUpBottomButtonsKeys.apple,
            context: context,
            isDesk: isDesk,
            text: context.l10n.apple,
            icon: KIcon.apple,
            onPressed: () => context
                .read<AuthenticationServicesCubit>()
                .authenticationUseApple(),
          ),
        ],
      );
    }

    // KSizedBox.kWidthSizedBox16,
    // facebookButton(
    //   context: context,
    //   isDesk: true,
    // ),
    // KSizedBox.kWidthSizedBox16,
    // Expanded(
    //   child: buildBottomButton(
    //     key: SignUpBottomButtonsKeys.apple,
    //     text: context.l10n.apple,
    //     icon: KImage.apple(),
    //   ),
    // ),
    //   ],
    // );
    //   ],
    // );
    // } else {
    //   return Column(
    // key: SignUpBottomButtonsKeys.mob,
    // children: [
    // Text(
    //   context.l10n.or,
    //   key: SignUpBottomButtonsKeys.or,
    //   style: isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
    // ),
    // KSizedBox.kHeightSizedBox16,
    // Text(
    //   context.l10n.signUpWith,
    //   key: SignUpBottomButtonsKeys.title,
    //   style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
    // ),
    // KSizedBox.kHeightSizedBox16,
    // googleButton(
    //   context: context,
    //   isDesk: false,
    // ),
    // KSizedBox.kHeightSizedBox16,
    // facebookButton(
    //   context: context,
    //   isDesk: false,
    // ),
    // KSizedBox.kHeightSizedBox16,
    // buildBottomButton(
    //   key: SignUpBottomButtonsKeys.apple,
    //   text: context.l10n.apple,
    //   icon: KImage.apple(),
    // ),
    //   ],
    // );
    // }
  }

  Widget googleButton({
    required BuildContext context,
    required bool isDesk,
  }) =>
      _button(
        key: SignUpBottomButtonsKeys.google,
        context: context,
        isDesk: isDesk,
        text: context.l10n.google,
        icon: KIcon.google,
        onPressed: () => context
            .read<AuthenticationServicesCubit>()
            .authenticationUseGoogle(),
      );

  // Widget facebookButton({
  //   required BuildContext context,
  //   required bool isDesk,
  // }) =>
  //     _button(
  //       key: SignUpBottomButtonsKeys.facebook,
  //       context: context,
  //       isDesk: isDesk,
  //       text: context.l10n.facebook,
  //       icon: KImage.facebookLogin(),
  //       onPressed: () => context
  //           .read<AuthenticationServicesCubit>()
  //           .authenticationUseFacebook(),
  //     );

  Widget _button({
    required BuildContext context,
    required bool isDesk,
    required Key key,
    required String text,
    required Widget icon,
    required void Function() onPressed,
  }) =>
      ButtonAdditionalWidget(
        key: key,
        text: text,
        picture: icon,
        onPressed: onPressed,
        isDesk: isDesk,
        expanded: false,
        hasAlign: !isDesk,
      );

  // Widget buildBottomButton({
  //   required String text,
  //   required Widget icon,
  //   required Key key,
  //   void Function()? onPressed,
  // }) {
  //   return ButtonWidget(
  //     key: key,
  //     onPressed: onPressed,
  //     icon: Padding(
  //       padding: const EdgeInsets.only(right: KPadding.kPaddingSize4),
  //       child: icon,
  //     ),
  //     padding: isDesk
  //         ? const EdgeInsets.only(
  //             left: KPadding.kPaddingSize16,
  //             right: KPadding.kPaddingSize24,
  //             top: KPadding.kPaddingSize8,
  //             bottom: KPadding.kPaddingSize8,
  //           )
  //         : const EdgeInsets.symmetric(
  //             vertical: KPadding.kPaddingSize16,
  //           ),
  //     // backgroundColor: AppColors.white,
  //     textStyle: AppTextStyle.text20,
  //     text: text,
  //     isDesk: isDesk,
  //   );
  // }
}
