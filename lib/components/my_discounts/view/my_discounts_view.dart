import 'package:flutter/material.dart';
import 'package:veteranam/components/my_discounts/my_discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MyDiscountsScreen extends StatelessWidget {
  const MyDiscountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyDiscountsBlocprovider(
      childWidget: MyDiscountsBodyWidget(
        key: MyDiscountsKeys.screen,
      ),
    );
  }
}
