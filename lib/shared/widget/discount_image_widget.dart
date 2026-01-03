import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountImageWidget extends StatelessWidget {
  const DiscountImageWidget({
    required this.images,
    required this.discount,
    super.key,
    this.borderRadius,
  });

  final List<ImageModel>? images;
  final String discount;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    if (images == null || images!.isEmpty) return const SizedBox.shrink();
    return Stack(
      children: [
        ClipRRect(
          borderRadius: KBorderRadius.kBorderRadiusLeft32,
          child: NetworkImageWidget(
            imageUrl: images!.first.downloadURL,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: KPadding.kPaddingSize16,
            right: KPadding.kPaddingSize16,
          ),
          child: DecoratedBox(
            decoration: KWidgetTheme.boxDecorationDiscount,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize8,
                vertical: KPadding.kPaddingSize4,
              ),
              child: TextPointWidget(
                discount,
                key: DiscountCardKeys.discount,
                mainAxisSize: MainAxisSize.min,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
