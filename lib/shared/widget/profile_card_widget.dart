// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:veteranam/components/components.dart';
// import 'package:veteranam/shared/shared.dart';

// class ProfileCardWidget extends StatefulWidget {
//   const ProfileCardWidget({
//     required this.isDesk,
//     super.key,
//   });

//   @override
//   ProfileCardWidgetState createState() => ProfileCardWidgetState();
//   final bool isDesk;
// }

// class ProfileCardWidgetState extends State<ProfileCardWidget> {
//   //bool isEditing = true;
//   late TextEditingController nameController;
//   late TextEditingController surnameController;
//   late TextEditingController emailController;
//   late TextEditingController nicknameController;

//   @override
//   void initState() {
//     nameController = TextEditingController();
//     surnameController = TextEditingController();
//     emailController = TextEditingController();
//     nicknameController = TextEditingController();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           decoration: KWidgetTheme.boxDecorationHome,
//           padding: const EdgeInsets.all(KPadding.kPaddingSize16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   UserPhotoWidget(
//                     onPressed: () => context
//                         .read<ProfileBloc>()
//                         .add(const ProfileEvent.imageUpdated()),
//                     imageUrl:
//                         context.read<AuthenticationBloc>().state.user?.photo,
//                     perimeter: KSize.kPixel72,
//                     icon: KIcon.personEdit,
//                     background: AppColors.materialThemeKeyColorsPrimary,
//                     iconColor: AppColors.materialThemeBlack,
//                   ),
//                   KSizedBox.kWidthSizedBox32,
//                   if (widget.isDesk)
//                     Text(
//                       context.l10n.dataEditing,
//                       key: KWidgetkeys.widget.profileCard.editText,
//                       style: widget.isDesk
//                           ? AppTextStyle.materialThemeHeadlineLarge
//                           : AppTextStyle.materialThemeHeadlineSmall,
//                     )
//                   else
//                     Expanded(
//                       child: Text(
//                         context.l10n.dataEditing,
//                         key: KWidgetkeys.widget.profileCard.editText,
//                         style: widget.isDesk
//                             ? AppTextStyle.materialThemeHeadlineLarge
//                             : AppTextStyle.materialThemeHeadlineSmall,
//                       ),
//                     ),
//                   KSizedBox.kWidthSizedBox8,
//                   KIcon.edit,
//                 ],
//               ),
//               KSizedBox.kHeightSizedBox32,
//               _textField(
//                 fieldKey: KWidgetkeys.widget.profileCard.nameField,
//                 textKey: KWidgetkeys.widget.profileCard.nameText,
//                 text: context.read<AuthenticationBloc>().state.user.firstName,
//                 controller: nameController,
//                 hint: context.l10n.writeYouName,
//                 onChanged: (text) => context
//                     .read<ProfileBloc>()
//                     .add(ProfileEvent.nameUpdated(text)),
//               ),
//               KSizedBox.kHeightSizedBox32,
//               _textField(
//                 fieldKey: KWidgetkeys.widget.profileCard.lastNameField,
//                 textKey: KWidgetkeys.widget.profileCard.lastNameText,
//                 text: context.read<AuthenticationBloc>().state.user.lastName,
//                 controller: surnameController,
//                 hint: context.l10n.writeYouLastName,
//                 onChanged: (text) => context
//                     .read<ProfileBloc>()
//                     .add(ProfileEvent.surnameUpdated(text)),
//               ),
//               KSizedBox.kHeightSizedBox32,
//               _textField(
//                 fieldKey: KWidgetkeys.widget.profileCard.emailFied,
//                 textKey: KWidgetkeys.widget.profileCard.emailText,
//                 text: context.read<AuthenticationBloc>().state.user?.email,
//                 controller: emailController,
//                 hint: KMockText.email,
//                 readOnly: true,
//               ),
//               KSizedBox.kHeightSizedBox32,
//               _textField(
//                 fieldKey: KWidgetkeys.widget.profileCard.nickNameField,
//                 textKey: KWidgetkeys.widget.profileCard.nickNameText,
//                 text: context
//                     .read<AuthenticationBloc>()
//                     .state
//                     .userSetting
//                     .nickname,
//                 hint: KAppText.nickname,
//                 controller: nicknameController,
//                 onChanged: (text) => context
//                     .read<ProfileBloc>()
//                     .add(ProfileEvent.nicknameUpdated(text)),
//               ),
//               KSizedBox.kHeightSizedBox32,
//               DoubleButtonWidget(
//                 widgetKey: KWidgetkeys.widget.profileCard.saveButton,
//                 text: context.l10n.saveChangesProfile,
//                 color: AppColors.materialThemeKeyColorsSecondary,
//                 textColor: AppColors.materialThemeWhite,
//                 deskPadding: const EdgeInsets.symmetric(
//                   vertical: KPadding.kPaddingSize12,
//                   horizontal: KPadding.kPaddingSize32,
//                 ),
//                 deskIconPadding: KPadding.kPaddingSize12,
//                 onPressed: () =>
//                     context.read<ProfileBloc>().add(const ProfileEvent.save()),
//                 isDesk: widget.isDesk,
//                 mobTextWidth: double.infinity,
//                 mobVerticalTextPadding: KPadding.kPaddingSize16,
//                 mobIconPadding: KPadding.kPaddingSize16,
//               ),
//             ],
//           ),
//         ),
//         if (widget.isDesk)
//           KSizedBox.kHeightSizedBox32
//         else
//           KSizedBox.kHeightSizedBox48,
//         if (widget.isDesk)
//           Row(
//             children: [
//               Expanded(
//                 child: ButtonAdditionalWidget(
//                   key: KWidgetkeys.widget.profileCard.logOutButton,
//                   text: context.l10n.logOut,
//                   picture: KIcon.logOut,
//                   onPressed: () => context.dialog.showLogoutConfirmationDialog(
//                     isDesk: true,
//                   ),
//                   isDesk: widget.isDesk,
//                   expanded: true,
//                 ),
//               ),
//               KSizedBox.kWidthSizedBox40,
//               Expanded(
//                 child: TextButton(
//                   key: KWidgetkeys.widget.profileCard.deleteButton,
//                   style: KButtonStyles.borderSecondaryButtonStyle,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: KPadding.kPaddingSize12,
//                     ),
//                     child: Text(
//                       context.l10n.deleteAccount,
//                       style: AppTextStyle.materialThemeTitleMedium,
//                     ),
//                   ),
//                   onPressed: () => context.dialog.showDeleteConfirmationDialog(
//                     isDesk: widget.isDesk,
//                   ),
//                   //isDesk: true,
//                 ),
//               ),
//             ],
//           )
//         else ...[
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               ButtonAdditionalWidget(
//                 key: KWidgetkeys.widget.profileCard.logOutButton,
//                 text: context.l10n.logOut,
//                 picture: KIcon.logOut,
//                 onPressed: () => context.dialog.showLogoutConfirmationDialog(
//                   isDesk: true,
//                 ),
//                 isDesk: widget.isDesk,
//                 expanded: true,
//                 mobPadding: const EdgeInsets.symmetric(
//                   vertical: KPadding.kPaddingSize16,
//                 ),
//                 iconPadding: KPadding.kPaddingSize16,
//               ),
//               KSizedBox.kHeightSizedBox16,
//               TextButton(
//                 key: KWidgetkeys.widget.profileCard.deleteButton,
//                 style: KButtonStyles.borderSecondaryButtonStyle,
//                 child: Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: KPadding.kPaddingSize16,
//                     ),
//                     child: Text(
//                       context.l10n.deleteAccount,
//                       style: AppTextStyle.materialThemeTitleMedium,
//                     ),
//                   ),
//                 ),
//                 onPressed: () => context.dialog.showDeleteConfirmationDialog(
//                   isDesk: widget.isDesk,
//                 ),
//                 //isDesk: true,
//               ),
//             ],
//           ),
//         ],
//       ],
//     );
//   }

//   Widget _textField({
//     required String hint,
//     required String? text,
//     required Key fieldKey,
//     required Key textKey,
//     required TextEditingController controller,
//     void Function(String text)? onChanged,
//     bool readOnly = false,
//   }) {
//     return TextFieldWidget(
//       widgetKey: fieldKey,
//       readOnly: readOnly,
//       controller: controller..text = text ?? '',
//       labelText: hint,
//       hintStyle: widget.isDesk
//           ? AppTextStyle.materialThemeTitleMedium
//           : AppTextStyle.materialThemeTitleSmall,
//       // fillColor: AppColors.transparent,
//       contentPadding: const EdgeInsets.symmetric(
//         vertical: KPadding.kPaddingSize16,
//         horizontal: KPadding.kPaddingSize32,
//       ),
//       isDesk: widget.isDesk,
//       onChanged: onChanged,
//     );
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     surnameController.dispose();
//     emailController.dispose();
//     nicknameController.dispose();
//     super.dispose();
//   }
// }
