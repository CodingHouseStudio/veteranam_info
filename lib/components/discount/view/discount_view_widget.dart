import 'package:flutter/material.dart';
import 'package:veteranam/components/discount/widget/blocprovider/discount_blocprovider.dart';
import 'package:veteranam/components/discount/widget/body/discount_body_widget.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountScreenWidget extends StatelessWidget {
  const DiscountScreenWidget({super.key, this.discount, this.discountId});
  final DiscountModel? discount;
  final String? discountId;

  @override
  Widget build(BuildContext context) {
    final scaffold = DiscountBlocprovider(
      discount: discount,
      discountId: discountId,
      childWidget: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Config.isWeb
            ? null
            : const MobNavigationWidget(
                index: 0,
              ),
        appBar: AppBar(
          backgroundColor: AppColors.materialThemeWhite,
          toolbarHeight: KSize.kAppBarHeight,
        ),
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
