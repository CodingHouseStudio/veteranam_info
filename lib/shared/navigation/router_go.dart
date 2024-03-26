import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/components/discounts/discounts.dart';
import 'package:kozak/components/home/home.dart';
import 'package:kozak/components/information/information.dart';
import 'package:kozak/components/investors/investors.dart';
import 'package:kozak/components/profile/profile.dart';
import 'package:kozak/components/story/story.dart';
import 'package:kozak/components/work/work.dart';
import 'package:kozak/shared/constants/rout_constants.dart';
import 'package:kozak/shared/navigation/redirect_authenticate_guard.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  routerNeglect: true,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  // errorBuilder: (context, state) => const ErrorScreen(),
  // refreshListenable:
  //     GoRouterRefreshStream(GetIt.instance<AuthenticationBloc>().stream),
  initialLocation: KRouteStatic.home.path,
  // redirect: (BuildContext context, GoRouterState state) async {
  //   if (context.read<AuthenticationBloc>().state.status ==
  //       AuthenticationStatus.authenticated) {
  //     return state.uri.toString().contains(KRouteStatic.login.path) ||
  //             state.uri.toString().contains(KRouteStatic.signUp.path)
  //         ? KRouteStatic.home.path
  //         : null;
  //   }
  //   return null;
  // },
  routes: [
    GoRoute(
      name: KRouteStatic.home.name,
      path: KRouteStatic.home.path,
      redirect: redirect,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
      routes: [
        GoRoute(
          name: KRouteStatic.information.name,
          path: KRouteStatic.information.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const InformationScreen(),
          ),
        ),
        GoRoute(
          name: KRouteStatic.discounts.name,
          path: KRouteStatic.discounts.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const DiscountsScreen(),
          ),
        ),
        GoRoute(
          name: KRouteStatic.story.name,
          path: KRouteStatic.story.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const StoryScreen(),
          ),
        ),
        GoRoute(
          name: KRouteStatic.work.name,
          path: KRouteStatic.work.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const WorkScreen(),
          ),
        ),
        GoRoute(
          name: KRouteStatic.profile.name,
          path: KRouteStatic.profile.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ProfileScreen(),
          ),
        ),
        GoRoute(
          name: KRouteStatic.investors.name,
          path: KRouteStatic.investors.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const InvestorsScreen(),
          ),
        ),
      ],
    ),
  ],
);
