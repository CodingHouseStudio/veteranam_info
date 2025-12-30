import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:veteranam/shared/shared_dart.dart';

FutureOr<String?> Function(BuildContext, GoRouterState)? businessRedirect =
    (BuildContext context, GoRouterState state) {
  if (context.read<AuthenticationBloc>().state.status !=
      AuthenticationStatus.authenticated) {
    return '/${KRoute.login.path}';
  }
  return null;
};
