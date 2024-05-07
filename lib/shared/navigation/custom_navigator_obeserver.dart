import 'package:flutter/material.dart';

class KNavigatorObserver extends NavigatorObserver {
  KNavigatorObserver({
    required this.didPushFunction,
  });
  final void Function() didPushFunction;
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      previousRoute != null ? didPushFunction() : null;
}
