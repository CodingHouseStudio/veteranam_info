import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:veteranam/components/discounts/bloc/bloc.dart';

class AdvancedFilterMobBlocprovider extends StatelessWidget {
  const AdvancedFilterMobBlocprovider({
    required this.childWidget,
    required this.bloc,
    required this.configBloc,
    super.key,
  });

  final Widget childWidget;
  final DiscountsWatcherBloc bloc;
  final DiscountConfigCubit configBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: bloc,
        ),
        BlocProvider.value(
          value: configBloc,
        ),
      ],
      child: childWidget,
    );
  }
}
