import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discounts_add/discounts_add.dart';
import 'package:veteranam/shared/shared.dart';

class DiscountsAddBlocprovider extends StatelessWidget {
  const DiscountsAddBlocprovider({
    required this.childWidget,
    required this.discount,
    super.key,
  });
  final Widget childWidget;
  final DiscountModel? discount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<DiscountsAddBloc>()
        ..add(DiscountsAddEvent.started(discount)),
      child: childWidget,
    );
  }
}
