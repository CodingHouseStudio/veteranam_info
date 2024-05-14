import 'package:cached_network_image/cached_network_image.dart';
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
  final String? image;
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
                  decoration: image == null
                      ? KWidgetTheme.boxDecorationWidget(context)
                      : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: KPadding.kPaddingSize32,
                      vertical: image == null ? KPadding.kPaddingSize48 : 0,
                    ),
                    child: childWidget,
                  ),
                ),
              ),
            ],
          )
        : Container(
            decoration: KWidgetTheme.boxDecorationWidget(context),
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
          ? KWidgetTheme.boxDecorationImageDesk(context)
          : KWidgetTheme.boxDecorationImageMob(context),
      child: CachedNetworkImage(
        key: KWidgetkeys.widget.cardAddImage.widget,
        imageUrl: image!,
        placeholder: (context, url) =>
            const CircularProgressIndicator.adaptive(), //Image.asset(''),
        errorWidget: (context, url, error) {
          debugPrint('image error: $error');
          return KIcon.error;
        },
        fit: BoxFit.fill,
      ),
    );
  }
}
