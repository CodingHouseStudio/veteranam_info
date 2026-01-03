import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
              padding: const EdgeInsets.all(KPadding.kPaddingSize8),
              child: titleWidget,
            ),
          if (image != null) buildImage(context),
          Padding(
            padding: const EdgeInsets.all(
              KPadding.kPaddingSize16,
            ),
            child: childWidget,
          ),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    //ebugPrint('Image: $image');
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: KWidgetTheme.boxDecorationImageMob,
          constraints: const BoxConstraints(
            maxHeight: KMinMaxSize.minHeight640,
            maxWidth: KMinMaxSize.maxWidth640,
          ),
          child: NetworkImageWidget(
            key: CardAddImageKeys.widget,
            imageUrl: image!.downloadURL,
            fit: BoxFit.contain,
          ),
        ),
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
            child: filters != null ? filters! : Container(),
          ),
        ),
      ],
    );
  }
}
