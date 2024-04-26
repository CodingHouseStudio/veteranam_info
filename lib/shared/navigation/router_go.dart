import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/components/components.dart';
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
          ? context.read<AuthenticationBloc>().state.userSetting.userRole ==
                  null
              ? KRoute.questionsForm.path
              : KRoute.home.path
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
      name: KRoute.questionsForm.name,
      path: KRoute.questionsForm.path,
      redirect: (context, state) =>
          context.read<AuthenticationBloc>().state.userSetting.userRole == null
              ? null
              : KRoute.home.path,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const QuestionsFormScreen(),
      ),
    ),
    GoRoute(
      name: KRoute.home.name,
      path: KRoute.home.path,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
      routes: [
        GoRoute(
          name: KRoute.information.name,
          path: KRoute.information.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const InformationScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.discounts.name,
          path: KRoute.discounts.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const DiscountsScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.story.name,
          path: KRoute.story.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const StoryScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.work.name,
          path: KRoute.work.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const WorkScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
          routes: [
            GoRoute(
              name: KRoute.workEmployee.name,
              path: KRoute.workEmployee.path,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const WorkEmployeeScreen(),
              ),
              onExit: (context) => context.read<ScrollCubit>().scrollUp(),
            ),
          ],
        ),
        GoRoute(
          name: KRoute.profile.name,
          path: KRoute.profile.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ProfileScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.investors.name,
          path: KRoute.investors.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const InvestorsScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.aboutUs.name,
          path: KRoute.aboutUs.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const AboutUsScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.consultation.name,
          path: KRoute.consultation.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ConsultationScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
        GoRoute(
          name: KRoute.contact.name,
          path: KRoute.contact.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ContactScreen(),
          ),
          onExit: (context) => context.read<ScrollCubit>().scrollUp(),
        ),
      ],
    ),
  ],
);
