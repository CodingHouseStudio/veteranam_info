import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';

class AdvancedFilterMobBlocprovider extends StatelessWidget {
  const AdvancedFilterMobBlocprovider({
    required this.childWidget,
    required this.bloc,
    super.key,
  });

  final Widget childWidget;
  final DiscountsWatcherBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: childWidget,
    );
  }
}
