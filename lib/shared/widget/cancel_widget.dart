import 'package:flutter/widgets.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class CancelWidget extends StatelessWidget {
  const CancelWidget({
    required this.widgetKey,
    required this.onPressed,
    super.key,
  });
  final Key widgetKey;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButtonWidget(
        key: widgetKey,
        onPressed: onPressed,
        icon: KIcon.close,
        background: AppColors.materialThemeWhite,
        padding: KPadding.kPaddingSize12,
      ),
    );
  }
}
