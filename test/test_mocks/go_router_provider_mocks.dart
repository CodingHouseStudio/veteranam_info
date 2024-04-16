// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockGoRouter extends Mock implements GoRouter {
  // MockGoRouter({
  //   required this.initialLocation,
  // });
  // final String initialLocation;
  // @override
  // late final GoRouteInformationProvider routeInformationProvider =
  //     GoRouteInformationProvider(
  //   initialLocation: initialLocation,
  //   initialExtra: null,
  // );
}

class MockGoRouterState extends Mock implements GoRouterState {
  MockGoRouterState({required this.fullPath});
  @override
  final String? fullPath;
}

class MockGoRouterProvider extends StatelessWidget {
  const MockGoRouterProvider({
    required this.goRouter,
    required this.child,
    super.key,
  });

  /// The mock navigator used to mock navigation calls.
  final MockGoRouter goRouter;

  /// The child [Widget] to render.
  final Widget child;

  @override
  Widget build(BuildContext context) => InheritedGoRouter(
        goRouter: goRouter,
        child: child,
      );
}
