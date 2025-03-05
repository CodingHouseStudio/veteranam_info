import 'package:flutter/material.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountsScreen extends StatelessWidget {
  const DiscountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffold = DiscountsBlocprovider(
      childWidget: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Config.isWeb
            ? null
            : const MobNavigationWidget(
                index: 0,
              ),
        appBar: appBar,
        body: const DiscountsBodyWidget(
          key: DiscountsKeys.screen,
        ),
      ),
    );
    if (Config.isWeb) {
      return scaffold;
    }
    // if (PlatformEnum.getPlatform.isIOS) {
    return ColoredBox(
      color: AppColors.materialThemeWhite,
      child: SafeArea(child: scaffold),
    );
    // } else {
    //   return SafeArea(child: scaffold);
    // }
  }
}
