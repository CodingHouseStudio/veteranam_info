import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/components/discounts_add/bloc/discounts_add_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountsAddBlocprovider extends StatelessWidget {
  const DiscountsAddBlocprovider({
    required this.childWidget,
    required this.discount,
    required this.discountId,
    super.key,
  });
  final Widget childWidget;
  final DiscountModel? discount;
  final String? discountId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<DiscountsAddBloc>(
        param1: discount,
        param2: discountId,
      ),
      child: childWidget,
    );
  }
}
