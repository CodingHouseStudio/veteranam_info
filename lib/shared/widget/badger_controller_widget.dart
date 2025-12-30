import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:veteranam/shared/shared_dart.dart';

class BadgerControllerWidget extends StatefulWidget {
  const BadgerControllerWidget({super.key, this.setInit = false});
  final bool setInit;

  @override
  State<BadgerControllerWidget> createState() => _BadgerControllerWidgetState();
}

class _BadgerControllerWidgetState extends State<BadgerControllerWidget>
    with WidgetsBindingObserver {
  bool? openedOtherApp;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> _removeBadger() async {
    await context.read<BadgerCubit>().removeBadge();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.hidden ||
        state == AppLifecycleState.paused) {
      openedOtherApp = true;
    } else if ((openedOtherApp ?? true) && state == AppLifecycleState.resumed) {
      openedOtherApp = false;
      _removeBadger();
    } else {
      openedOtherApp ??= false;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
