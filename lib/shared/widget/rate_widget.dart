import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class RateWidget extends StatelessWidget {
  const RateWidget({
    required this.isDesk,
    required this.onRatingUpdate,
    super.key,
  });
  final bool isDesk;
  final void Function(double rating)? onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(KPadding.kPaddingSize20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: KPadding.kPaddingSize8,
        children: [
          Text(
            context.l10n.rateOurSite,
            key: KWidgetkeys.widget.rate.title,
            style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
          ),
          RatingBar.builder(
            allowHalfRating: true,
            itemSize: KSize.kIconSize,
            itemPadding: const EdgeInsets.only(right: KPadding.kPaddingSize8),
            itemBuilder: (context, index) => KIcon.star
                .copyWith(key: KWidgetkeys.widget.rate.ratingBarIcons),
            onRatingUpdate: onRatingUpdate ?? (double rating) {},
          ),
        ],
      ),
    );
  }
}
