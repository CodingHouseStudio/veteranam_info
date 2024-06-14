import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kozak/shared/shared.dart';
// import 'package:url_launcher/url_launcher.dart';

/// The [BuyMeACoffeeWidget] is the widget. It has a tap event and will trigger as soon someone taps it.
/// It opens up a browser window in the default browser of the device and
/// navigates to the specified UserID on Buy me a coffee.
class BuyMeACoffeeWidget extends StatelessWidget {
  /// Constructor of the BuyMeACoffee Widget
  const BuyMeACoffeeWidget({
    // required this.sponsorID,
    super.key,
    this.textStyle,
    this.backgroundColor,
    this.padding,
  });

  // final bool _isIconOnly;

  final EdgeInsets? padding;

  /// The id for the user where it should link to.
  // final String sponsorID;

  /// Custom text for the widget
  // final String? customText;

  /// Overwrites the textStyle of the widget
  final TextStyle? textStyle;

  /// Color of the background if none is provided the [theme] background
  /// will be used or the fallback
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    // var backgroundColor = this.backgroundColor;
    // final textStyle = this.textStyle;
    // final customText = this.customText;
    // if (theme == null && backgroundColor == null) {
    //   backgroundColor = const Color(0xFFFF813F);
    // } else if (backgroundColor != null) {
    //   backgroundColor = backgroundColor;
    // } else {
    //   backgroundColor = theme!.backgroundColor;
    // }
    final iconWidget = SvgPicture.network(
      "https://cdn.buymeacoffee.com/buttons/bmc-new-btn-logo.svg",
      // width: 35.0,
    );
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: 51,
      ),
      child: InkWell(
        onTap: null,
        // () {
        /// Url to the buy me a coffee website
        // final uri = Uri.parse(buyMeACoffeeUrl + sponsorID);
        // launchUrl(uri);
        // },
        child: Container(
          padding: padding ??
              EdgeInsets.symmetric(
                vertical: 7.0,
                horizontal: 10.0,
              ),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.transparent),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(190, 190, 190, 0.5),
                blurRadius: 2.0,
                offset: Offset.lerp(Offset.zero, const Offset(1, 1), 1)!,
              ),
            ],
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              iconWidget,
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  context.l10n.text,
                  style: AppTextStyle.materialThemeTitleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
