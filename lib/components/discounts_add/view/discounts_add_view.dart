import 'package:flutter/material.dart';
import 'package:veteranam/components/discounts_add/discounts_add.dart';
import 'package:veteranam/shared/shared.dart';

class DiscountsAddScreen extends StatelessWidget {
  const DiscountsAddScreen({required this.discount, super.key});
  final DiscountModel? discount;

  @override
  Widget build(BuildContext context) {
    return DiscountsAddBlocprovider(
      key: KWidgetkeys.screen.discountsAdd.screen,
      childWidget: DiscountsAddBodyWidget(
        discount: discount,
      ),
      discount: discount,
    );
  }
}
