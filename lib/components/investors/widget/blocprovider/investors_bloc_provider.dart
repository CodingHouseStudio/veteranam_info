// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:veteranam/components/components.dart';

// class InvestorsBlocprovider extends StatelessWidget {
//   const InvestorsBlocprovider({required this.childWidget, super.key});
//   final Widget childWidget;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => GetIt.I.get<InvestorsWatcherBloc>()
//         ..add(const InvestorsWatcherEvent.started()),
//       child: childWidget,
//     );
//   }
// }
