import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class MyDiscountsScreen extends StatelessWidget {
  const MyDiscountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyDiscountsBlocprovider(
      key: KWidgetkeys.screen.myDiscounts.screen,
      childWidget: const MyDiscountsBodyWidget(),
    );
  }
}
