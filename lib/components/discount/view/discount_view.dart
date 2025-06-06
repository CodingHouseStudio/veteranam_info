import 'package:flutter/material.dart';
import 'package:veteranam/components/discount/widget/blocprovider/discount_blocprovider.dart';
import 'package:veteranam/components/discount/widget/body/discount_body_widget.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({super.key, this.discount, this.discountId});
  final DiscountModel? discount;
  final String? discountId;

  @override
  Widget build(BuildContext context) {
    final scaffold = DiscountBlocprovider(
      discount: discount,
      discountId: discountId,
      childWidget: Scaffold(
        key: DiscountKeys.screen,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Config.isWeb
            ? null
            : const MobNavigationWidget(
                index: 0,
              ),
        appBar: appBar,
        body: DiscountBodyWidget(
          discount: discount,
          discountId: discountId,
        ),
      ),
    );
    if (Config.isWeb) {
      return scaffold;
    }
    return ColoredBox(
      color: AppColors.materialThemeWhite,
      child: SafeArea(child: scaffold),
    );
  }
}
