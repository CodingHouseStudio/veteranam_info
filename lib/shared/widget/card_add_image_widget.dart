import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class CardAddImageWidget extends StatelessWidget {
  const CardAddImageWidget({
    required this.childWidget,
    required this.isDesk,
    this.image,
    super.key,
    this.titleWidget,
    this.filters,
  });

  final Widget childWidget;
  final String? image;
  final bool isDesk;
  final Widget? titleWidget;
  final Widget? filters;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: KWidgetTheme.boxDecorationCardGrayBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (titleWidget != null)
            Padding(
              padding: const EdgeInsets.all(KPadding.kPaddingSize8),
              child: titleWidget,
            ),
          if (image != null) buildImage(context),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize16,
              vertical: KPadding.kPaddingSize16,
            ),
            child: childWidget,
          ),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    debugPrint('Image: $image');
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: isDesk
              ? KWidgetTheme.boxDecorationImageMob
              : KWidgetTheme.boxDecorationImageMob,
          constraints: const BoxConstraints(
            maxHeight: KMinMaxSize.minHeight640,
            maxWidth: KMinMaxSize.maxWidth640,
          ),
          child: ImageWidget(
            key: KWidgetkeys.widget.cardAddImage.widget,
            imageUrl: image!,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: 0,
          left: KPadding.kPaddingSize16,
          child: filters != null ? filters! : Container(),
        ),
      ],
    );
  }
}
