import 'package:flutter/material.dart';
import 'package:veteranam/components/discounts_add/discounts_add.dart';
import 'package:veteranam/shared/shared.dart';

class DiscountsAddScreen extends StatelessWidget {
  const DiscountsAddScreen({
    required this.discount,
    required this.discountId,
    super.key,
  });
  final DiscountModel? discount;
  final String? discountId;

  @override
  Widget build(BuildContext context) {
    return DiscountsAddBlocprovider(
      key: KWidgetkeys.screen.discountsAdd.screen,
      childWidget: DiscountsAddBodyWidget(
        discountId: discountId,
      ),
      discount: discount,
      discountId: discountId,
    );
  }
}
