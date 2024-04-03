import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class CardAddImageWidget extends StatelessWidget {
  const CardAddImageWidget({
    required this.childWidget,
    this.image,
    super.key,
  });
  final Widget childWidget;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: KPadding.kPaddingSize48,
        vertical: image != null ? 0 : KPadding.kPaddingSize48,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (image != null)
            Expanded(
              child: Container(
                decoration: KWidetTheme.boxDecorationImage,
                child: CachedNetworkImage(
                  key: KWidgetkeys.widget.cardAddImage.widget,
                  imageUrl: image!,
                  placeholder: (context, url) => Image.asset(''),
                  errorWidget: (context, url, error) => KIcon.error,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          Expanded(child: childWidget),
        ],
      ),
    );
  }
}
