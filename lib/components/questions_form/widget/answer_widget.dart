// import 'package:flutter/material.dart';
// import 'package:veteranam/shared/shared.dart';

// class AnswerWidget extends StatelessWidget {
//   const AnswerWidget({
//     required this.onChanged,
//     required this.text,
//     required this.isDesk,
//     required this.isCheck,
//     // required this.textKey,
//     required this.checkPointKey,
//     super.key,
//   });
//   final void Function() onChanged;
//   final String text;
//   final bool isDesk;
//   final bool isCheck;
//   // final Key textKey;
//   final Key checkPointKey;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CheckPointWidget(
//           key: checkPointKey,
//           onChanged: onChanged,
//           isCheck: isCheck, text: text,
//           textStyle: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
//         ),
//         KSizedBox.kWidthSizedBox16,
//         Expanded(
//           child: Text(
//             text,
//             key: textKey,
//             style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
//           ),
//         ),
//       ],
//     );
//   }
// }
