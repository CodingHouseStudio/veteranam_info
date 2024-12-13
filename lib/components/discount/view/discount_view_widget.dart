import 'package:flutter/widgets.dart';
import 'package:veteranam/components/discount/widget/body/discount_body_widget.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/models/discount_model.dart';

class DiscountScreenWidget extends StatelessWidget {
  const DiscountScreenWidget({super.key, this.discount, this.discountId});
  final DiscountModel? discount;
  final String? discountId;

  @override
  Widget build(BuildContext context) {
    return const DiscountBlocprovider(
      childWidget: DiscountBodyWidget(),
    );
  }
}
