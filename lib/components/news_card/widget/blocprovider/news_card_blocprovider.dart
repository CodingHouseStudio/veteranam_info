import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/components/news_card/bloc/news_card_watcher_bloc.dart';

class NewsCardBlocprovider extends StatelessWidget {
  const NewsCardBlocprovider({
    required this.id,
    required this.childWidget,
    super.key,
  });
  final String? id;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<NewsCardWatcherBloc>()
        ..add(NewsCardWatcherEvent.started(id)),
      child: childWidget,
    );
  }
}
