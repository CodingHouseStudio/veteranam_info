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
  final ImageModel? image;
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
              padding:
                  const EdgeInsets.symmetric(vertical: KPadding.kPaddingSize8),
              child: titleWidget,
            ),
          if (image != null) buildImage(context),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: KPadding.kPaddingSize12,
            ),
            child: childWidget,
          ),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          decoration: isDesk
              ? KWidgetTheme.boxDecorationImageDesk
              : KWidgetTheme.boxDecorationImageMob,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            child: ImageWidget(
              key: KWidgetkeys.widget.cardAddImage.widget,
              imageUrl: image!.downloadURL,
              fit: BoxFit.fill,
            ),
          ),
        ),
        if (filters != null)
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: isDesk
                  ? const EdgeInsets.only(
                      left: KPadding.kPaddingSize32,
                      right: KPadding.kPaddingSize16,
                      top: KPadding.kPaddingSize16,
                    )
                  : const EdgeInsets.only(
                      left: KPadding.kPaddingSize16,
                      right: KPadding.kPaddingSize16,
                      top: KPadding.kPaddingSize16,
                    ),
              child: filters,
            ),
          ),
      ],
    );
  }
}
