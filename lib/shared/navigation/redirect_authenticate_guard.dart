import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

FutureOr<String?> Function(BuildContext, GoRouterState)? redirect =
    (BuildContext context, GoRouterState state) {
  return null;

  // if (context.read<AuthenticationBloc>().state.status ==
  //         AuthenticationStatus.unknown ||
  //     context.read<AuthenticationBloc>().state.status ==
  //         AuthenticationStatus.unauthenticated) {
  //   return KRouteStatic.login.path;
  // }
  // return null;
};
