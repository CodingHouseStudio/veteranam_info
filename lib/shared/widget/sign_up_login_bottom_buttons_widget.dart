// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:veteranam/shared/shared.dart';

// class SignUpLoginBottomButtonsWidget extends StatelessWidget {
//   const SignUpLoginBottomButtonsWidget({
//     required this.isDesk,
//     required this.title,
//     super.key,
//   });

//   final bool isDesk;
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     if (isDesk) {
//       return Column(
//         crossAxisAlignment:
//             isDesk ? CrossAxisAlignment.start : CrossAxisAlignment.center,
//         //key: KWidgetkeys.widget.signUpBottomButtons.desk,
//         children: [
//           Row(
//             children: [
//               const Expanded(
//                 child: Divider(
//                     //key: KWidgetkeys.widget.signUpBottomButtons.divider,
//                     ),
//               ),
//               KSizedBox.kWidthSizedBox32,
//               Text(
//                 context.l10n.or,
//                 key: KWidgetkeys.widget.signUpBottomButtons.or,
//                 style: AppTextStyle.hint14,
//               ),
//               KSizedBox.kWidthSizedBox32,
//               const Expanded(
//                 child: Divider(
//                     //key: KWidgetkeys.widget.signUpBottomButtons.divider,
//                     ),
//               ),
//             ],
//           ),
//           KSizedBox.kHeightSizedBox40,
//           Text(
//             title,
//             key: KWidgetkeys.widget.signUpBottomButtons.title,
//             style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
//           ),
//           KSizedBox.kHeightSizedBox16,
//           Row(
//             children: [
//               Expanded(
//                 child: googleButton(context: context, isDesk: true),
//               ),
//               KSizedBox.kWidthSizedBox16,
//               Expanded(
//                 child: buildBottomButton(
//                   key: KWidgetkeys.widget.signUpBottomButtons.facebook,
//                   text: context.l10n.facebook,
//                   icon: KImage.facebook(),
//                 ),
//               ),
//               KSizedBox.kWidthSizedBox16,
//               Expanded(
//                 child: buildBottomButton(
//                   key: KWidgetkeys.widget.signUpBottomButtons.apple,
//                   text: context.l10n.apple,
//                   icon: KImage.apple(),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         // key: KWidgetkeys.widget.signUpBottomButtons.mob,
//         children: [
//           Text(
//             context.l10n.or,
//             key: KWidgetkeys.widget.signUpBottomButtons.or,
//             style: isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
//           ),
//           KSizedBox.kHeightSizedBox16,
//           Text(
//             context.l10n.signUpWith,
//             key: KWidgetkeys.widget.signUpBottomButtons.title,
//             style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
//           ),
//           KSizedBox.kHeightSizedBox16,
//           googleButton(context: context, isDesk: false),
//           KSizedBox.kHeightSizedBox16,
//           buildBottomButton(
//             key: KWidgetkeys.widget.signUpBottomButtons.facebook,
//             text: context.l10n.facebook,
//             icon: KImage.facebook(),
//           ),
//           KSizedBox.kHeightSizedBox16,
//           buildBottomButton(
//             key: KWidgetkeys.widget.signUpBottomButtons.apple,
//             text: context.l10n.apple,
//             icon: KImage.apple(),
//           ),
//         ],
//       );
//     }
//   }

//   Widget googleButton({required BuildContext context,
// required bool isDesk}) =>
//       ButtonAdditionalWidget(
//         key: KWidgetkeys.widget.signUpBottomButtons.google,
//         text: context.l10n.google,
//         picture: KImage.google(),
//         onPressed: () => context
//             .read<AuthenticationServicesCubit>()
//             .authenticationUseGoogle(),
//       );

//   Widget buildBottomButton({
//     required String text,
//     required Widget icon,
//     required Key key,
//     void Function()? onPressed,
//   }) {
//     return ButtonWidget(
//       key: key,
//       onPressed: onPressed,
//       icon: Padding(
//         padding: const EdgeInsets.only(right: KPadding.kPaddingSize4),
//         child: icon,
//       ),
//       padding: isDesk
//           ? const EdgeInsets.only(
//               left: KPadding.kPaddingSize16,
//               right: KPadding.kPaddingSize24,
//               top: KPadding.kPaddingSize8,
//               bottom: KPadding.kPaddingSize8,
//             )
//           : const EdgeInsets.symmetric(
//               vertical: KPadding.kPaddingSize16,
//             ),
//       // backgroundColor: AppColors.white,
//       textStyle: AppTextStyle.text20,
//       text: text,
//       isDesk: isDesk,
//     );
//   }
// }
