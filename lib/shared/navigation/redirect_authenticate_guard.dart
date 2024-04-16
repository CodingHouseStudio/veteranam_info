import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

/// COMMENT: Function for checking user registration
FutureOr<String?> Function(BuildContext, GoRouterState)? redirect =
    (BuildContext context, GoRouterState state) {
  if (context.read<AuthenticationBloc>().state.status ==
          AuthenticationStatus.unknown ||
      context.read<AuthenticationBloc>().state.status ==
          AuthenticationStatus.unauthenticated) {
    return KRoute.login.path;
  }
  return null;
};
