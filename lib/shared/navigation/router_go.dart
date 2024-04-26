import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/components/thanks/thanks.dart';
import 'package:kozak/shared/bloc/authentication/listenable.dart';
import 'package:kozak/shared/shared.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// COMMENT: Variable for navigation in App
final GoRouter router = GoRouter(
  routerNeglect: true,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => const ErrorScreen(),
  refreshListenable:
      GoRouterRefreshStream(GetIt.instance<AuthenticationBloc>().stream),
  initialLocation: KRoute.home.path,
  redirect: (BuildContext context, GoRouterState state) async {
    if (context.read<AuthenticationBloc>().state.status ==
        AuthenticationStatus.authenticated) {
      return state.uri.toString().contains(KRoute.login.path) ||
              state.uri.toString().contains(KRoute.signUp.path)
          ? KRoute.home.path
          : null;
    }
    return null;
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
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.discounts.name,
          path: KRoute.discounts.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const DiscountsScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.story.name,
          path: KRoute.story.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const StoryScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.work.name,
          path: KRoute.work.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const WorkScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.profile.name,
          path: KRoute.profile.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ProfileScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.investors.name,
          path: KRoute.investors.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const InvestorsScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.aboutUs.name,
          path: KRoute.aboutUs.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const AboutUsScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.consultation.name,
          path: KRoute.consultation.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ConsultationScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.contact.name,
          path: KRoute.contact.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ContactScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.thanks.name,
          path: KRoute.thanks.path,
          redirect: redirect,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ThanksScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
      ],
    ),
  ],
);
