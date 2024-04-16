import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/bloc/authentication/listenable.dart';
import 'package:kozak/shared/shared.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// COMMENT: Variable for navigation in App
final GoRouter router = GoRouter(
  routerNeglect: true,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => const ErrorScreen(),
  refreshListenable:
      GoRouterRefreshStream(GetIt.instance<AuthenticationBloc>().stream),
  initialLocation: KRoute.home.path,
  // redirect: (BuildContext context, GoRouterState state) async {
  //   if (context.read<AuthenticationBloc>().state.status ==
  //       AuthenticationStatus.authenticated) {
  //     return state.uri.toString().contains(KRoute.login.path) ||
  //             state.uri.toString().contains(KRoute.signUp.path)
  //         ? KRoute.home.path
  //         : null;
  //   }
  //   return null;
  // },
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(
          goRouterState: state,
          navigationShell: child,
        );
      },
      routes: [
        GoRoute(
          name: KRoute.login.name,
          path: KRoute.login.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
          name: KRoute.signUp.name,
          path: KRoute.signUp.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const SignUpScreen(),
          ),
        ),
        GoRoute(
          name: KRoute.home.name,
          path: KRoute.home.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
          ),
          routes: [
            GoRoute(
              name: KRoute.information.name,
              path: KRoute.information.path,
              redirect: redirect,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const InformationScreen(),
              ),
            ),
            GoRoute(
              name: KRoute.discounts.name,
              path: KRoute.discounts.path,
              redirect: redirect,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const DiscountsScreen(),
              ),
            ),
            GoRoute(
              name: KRoute.story.name,
              path: KRoute.story.path,
              redirect: redirect,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const StoryScreen(),
              ),
            ),
            GoRoute(
              name: KRoute.work.name,
              path: KRoute.work.path,
              redirect: redirect,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const WorkScreen(),
              ),
            ),
            GoRoute(
              name: KRoute.profile.name,
              path: KRoute.profile.path,
              redirect: redirect,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ProfileScreen(),
              ),
            ),
            GoRoute(
              name: KRoute.investors.name,
              path: KRoute.investors.path,
              redirect: redirect,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const InvestorsScreen(),
              ),
            ),
            GoRoute(
              name: KRoute.aboutUs.name,
              path: KRoute.aboutUs.path,
              redirect: redirect,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const AboutUsScreen(),
              ),
            ),
            GoRoute(
              name: KRoute.consultation.name,
              path: KRoute.consultation.path,
              redirect: redirect,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ConsultationScreen(),
              ),
            ),
            GoRoute(
              name: KRoute.contact.name,
              path: KRoute.contact.path,
              redirect: redirect,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ContactScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
