import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/components/discount/bloc/discount_watcher_bloc.dart';
import 'package:veteranam/shared/models/discount_model.dart';

class DiscountBlocprovider extends StatelessWidget {
  const DiscountBlocprovider({
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
      create: (context) => GetIt.I.get<DiscountWatcherBloc>(
        param1: discount,
        param2: discountId,
      ),
      child: childWidget,
    );
  }
}
