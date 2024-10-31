import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discount_card/bloc/discount_card_watcher_bloc.dart';

class DiscountCardBlocprovider extends StatelessWidget {
  const DiscountCardBlocprovider({
    required this.id,
    required this.childWidget,
    super.key,
  });
  final String? id;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<DiscountCardWatcherBloc>()
        ..add(DiscountCardWatcherEvent.started(id)),
      child: childWidget,
    );
  }
}
