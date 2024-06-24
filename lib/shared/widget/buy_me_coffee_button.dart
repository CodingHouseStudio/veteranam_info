import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';
// import 'package:url_launcher/url_launcher.dart';

class BuyMeACoffeeWidget extends StatelessWidget {
  const BuyMeACoffeeWidget({
    // required this.sponsorID,
    super.key,
    this.textStyle,
    this.backgroundColor,
    this.padding,
  });

  final EdgeInsets? padding;

  final TextStyle? textStyle;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        '☕ Buy me a coffee',
        style: AppTextStyle.materialThemeTitleMedium,
      ),
    );

    // return ConstrainedBox(
    //   constraints: const BoxConstraints(
    //     maxHeight: 51,
    //   ),
    //   child: InkWell(
    //     // () {
    //     /// Url to the buy me a coffee website
    //     // final uri = Uri.parse(buyMeACoffeeUrl + sponsorID);
    //     // launchUrl(uri);
    //     // },
    //     child: Container(
    //       padding: padding ??
    //           const EdgeInsets.symmetric(
    //             vertical: 7,
    //             horizontal: 10,
    //           ),
    //       decoration: BoxDecoration(
    //         color: backgroundColor,
    //         border: Border.all(color: Colors.transparent),
    //         boxShadow: [
    //           BoxShadow(
    //             color: const Color.fromRGBO(190, 190, 190, 0.5),
    //             blurRadius: 2,
    //             offset: Offset.lerp(Offset.zero, const Offset(1, 1), 1)!,
    //           ),
    //         ],
    //         borderRadius: const BorderRadius.all(
    //           Radius.circular(5),
    //         ),
    //       ),
    //       child: Row(
    //         mainAxisSize: MainAxisSize.min,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           iconWidget,
    //           Padding(
    //             padding: const EdgeInsets.only(left: 8),
    //             child: Text(
    //               context.l10n.text,
    //               style: AppTextStyle.materialThemeTitleMedium,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
