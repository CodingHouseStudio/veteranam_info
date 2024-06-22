import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class CardAddImageWidget extends StatelessWidget {
  const CardAddImageWidget({
    required this.childWidget,
    required this.isDesk,
    this.image,
    super.key,
    this.titleWidget,
  });
  final Widget childWidget;
  final ImageModel? image;
  final bool isDesk;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    return isDesk
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image != null)
                Expanded(
                  child: buildImage(context),
                ),
              Expanded(
                child: Container(
                  decoration:
                      image == null ? KWidgetTheme.boxDecorationWidget : null,
                  padding: EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize32,
                    vertical: image == null ? KPadding.kPaddingSize48 : 0,
                  ),
                  child: childWidget,
                ),
              ),
            ],
          )
        : DecoratedBox(
            decoration: KWidgetTheme.boxDecorationWidget,
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
    return Container(
      decoration: isDesk
          ? KWidgetTheme.boxDecorationImageDesk
          : KWidgetTheme.boxDecorationImageMob,
      constraints: const BoxConstraints(
        maxHeight: KMinMaxSize.minHeight640,
        maxWidth: KMinMaxSize.maxWidth640,
      ),
      child: ImageWidget(
        key: KWidgetkeys.widget.cardAddImage.widget,
        imageUrl: image!.downloadURL,
        fit: BoxFit.contain,
      ),
    );
  }
}
