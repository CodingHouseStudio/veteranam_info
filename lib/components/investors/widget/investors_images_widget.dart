import 'package:flutter/widgets.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class InvestorsImagesWidget extends StatelessWidget {
  const InvestorsImagesWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return Row(
        spacing: KPadding.kPaddingSize24,
        children: [
          Column(
            key: InvestorsKeys.leftImages,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize8,
            children: _leftImage(isDesk: isDesk),
          ),
          Column(
            key: InvestorsKeys.rightImages,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize8,
            children: _rightImage(isDesk: isDesk),
          ),
        ],
      );
    } else {
      return Row(
        spacing: KPadding.kPaddingSize8,
        children: [
          Expanded(
            child: Column(
              key: InvestorsKeys.rightImages,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing:
                  isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize8,
              children: _leftImage(isDesk: isDesk),
            ),
          ),
          Expanded(
            child: Column(
              key: InvestorsKeys.leftImages,
              spacing:
                  isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _rightImage(isDesk: isDesk),
            ),
          ),
        ],
      );
    }
  }

  List<Widget> _leftImage({required bool isDesk}) => [
        KImage.veteran1(),
        KImage.veteran2(),
        KImage.veteran3(),
      ];
  List<Widget> _rightImage({required bool isDesk}) => [
        KImage.veteran4(),
        KImage.veteran5(),
      ];
}
