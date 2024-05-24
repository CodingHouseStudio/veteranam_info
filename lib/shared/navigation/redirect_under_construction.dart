import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

FutureOr<String?> Function(BuildContext, GoRouterState)? redirect =
    (BuildContext context, GoRouterState state) {
  if (Config.isProduction) {
    return KRoute.underConstruction.path;
  }
  return null;
};
