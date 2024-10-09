import 'package:flutter/material.dart';
import 'package:veteranam/components/my_discounts/my_discounts.dart';
import 'package:veteranam/shared/shared.dart';

class MyDiscountsScreen extends StatelessWidget {
  const MyDiscountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyDiscountsBlocprovider(
      childWidget: MyDiscountsBodyWidget(
        key: KWidgetkeys.screen.myDiscounts.screen,
      ),
    );
  }
}
