import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class CancelWidget extends StatelessWidget {
  const CancelWidget({required this.widgetKey, super.key});
  final Key widgetKey;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButtonWidget(
        key: widgetKey,
        onPressed: () => context.pop(),
        icon: KIcon.close,
        background: AppColors.materialThemeWhite,
        padding: KPadding.kPaddingSize12,
      ),
    );
  }
}
