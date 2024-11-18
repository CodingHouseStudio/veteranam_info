import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class CardEmptyWidget extends StatelessWidget {
  const CardEmptyWidget({
    required this.chilcWidget,
    required this.cardIsEmpty,
    required this.popRouteName,
    super.key,
    this.height,
  });
  final Widget chilcWidget;
  final bool cardIsEmpty;
  final double? height;
  final String popRouteName;

  @override
  Widget build(BuildContext context) {
    if (cardIsEmpty) {
      return SizedBox(
        key: KWidgetkeys.widget.cardEmpty.widget,
        height: height ?? KSize.kPixel460,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(KPadding.kPaddingSize16),
              child: CancelWidget(
                // color: Colors.black,
                onPressed: () => context.goNamed(popRouteName),
                widgetKey: KWidgetkeys.widget.cardEmpty.closeButton,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KIcon.found
                        .copyWith(key: KWidgetkeys.widget.cardEmpty.image),
                    Text(
                      context.l10n.cardNotFoundCardLink,
                      key: KWidgetkeys.widget.cardEmpty.text,
                      style: AppTextStyle.materialThemeTitleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            KSizedBox.kHeightSizedBox64,
          ],
        ),
      );
    }
    return chilcWidget;
  }
}
