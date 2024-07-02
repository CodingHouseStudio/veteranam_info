import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class DiscountsScreen extends StatelessWidget {
  const DiscountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DiscountBlocprovider(
      childWidget: DiscountBodyWidget(
        key: KWidgetkeys.screen.discounts.screen,
      ),
    );
  }
}
