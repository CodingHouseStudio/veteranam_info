import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';

class DiscountBlocprovider extends StatelessWidget {
  const DiscountBlocprovider({required this.childWidget, super.key});

  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => GetIt.I.get<DiscountWatcherBloc>()
        //     ..add(const DiscountWatcherEvent.started()),
        // ),
        BlocProvider(
          create: (context) => GetIt.I.get<DiscountLinkCubit>()..started(),
        ),
      ],
      child: childWidget,
    );
  }
}
