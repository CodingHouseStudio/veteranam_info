// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:veteranam/components/components.dart';

// class MobFaqBlocprovider extends StatelessWidget {
//   const MobFaqBlocprovider({required this.childWidget, super.key});
//   final Widget childWidget;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => GetIt.I.get<MobFaqWatcherBloc>()
//         ..add(const MobFaqWatcherEvent.started()),
//       child: childWidget,
//     );
//   }
// }
