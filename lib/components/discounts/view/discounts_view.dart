import 'package:flutter/material.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountsScreen extends StatelessWidget {
  const DiscountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DiscountBlocprovider(
        childWidget: DiscountsBodyWidget(
          key: KWidgetkeys.screen.discounts.screen,
        ),
      ),
    );
  }
}
