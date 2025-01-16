// import 'package:flutter/material.dart';
// import 'package:veteranam/shared/shared_flutter.dart';

// class DropDownButton extends StatefulWidget {
//   const DropDownButton({
//     required this.isDesk,
//     required this.buttonText,
//     required this.items,
//     required this.offset,
//     super.key,
//   });

//   final bool isDesk;
//   final String buttonText;
//   final List<DropDownItem> items;
//   final Offset offset;

//   @override
//   DropDownButtonState createState() => DropDownButtonState();
// }

// class DropDownButtonState extends State<DropDownButton> {
//   bool _showButtons = false;

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<int>(
//       key: DropDownButtonKeys.widget,
//       offset: widget.offset,
//       // position: PopupMenuPosition.under,
//       shape: KWidgetTheme.outlineBorder,
//       style: KButtonStyles.borderBlackButtonStyle.copyWith(
//         padding: const WidgetStatePropertyAll(
//           EdgeInsets.only(
//             left: KPadding.kPaddingSize10,
//             right: KPadding.kPaddingSize22,
//           ),
//         ),
//       ),
//       menuPadding: const EdgeInsets.symmetric(
//         vertical: KPadding.kPaddingSize8,
//       ),
//       color: AppColors.materialThemeKeyColorsNeutral,
//       padding: EdgeInsets.zero,
//       onCanceled: onTap,
//       onOpened: onTap,
//       onSelected: (index) {
//         widget.items.elementAt(index).event?.call();
//       },
//       itemBuilder: (context) {
//         return List.generate(widget.items.length, (index) {
//           return PopupMenuItem(
//             key: widget.items.elementAt(index).key,
//             //onTap: widget.items.elementAt(index).action,
//             value: index,
//             child: Text(
//               widget.items.elementAt(index).text,
//               style: AppTextStyle.materialThemeBodyMedium,
//             ),
//           );
//         });
//       },
//       icon: Row(
//         key: DropDownButtonKeys.loginButton,
//         children: [
//           if (_showButtons) KIcon.trailingUp else KIcon.keyboardArrowDown,
//           KSizedBox.kWidthSizedBox8,
//           Text(
//             widget.buttonText,
//             style: AppTextStyle.materialThemeTitleMedium,
//           ),
//         ],
//       ),
//     );
//   }

//   void onTap() => setState(() {
//         _showButtons = !_showButtons;
//       });
// }
