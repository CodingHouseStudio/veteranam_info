import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/components/thanks/thanks.dart';
import 'package:kozak/shared/shared.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// COMMENT: Variable for navigation in App
GoRouter router = GoRouter(
  routerNeglect: true,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => const ErrorScreen(),
  refreshListenable:
      GoRouterRefreshStream(GetIt.instance<AuthenticationBloc>().stream),
  initialLocation: KRoute.home.path,
  observers: [
    FirebaseAnalyticsObserver(
      analytics: FirebaseAnalytics.instance,
      onError: (_) => debugPrint('FirebaseAnalyticsObserver error $_'),
    ),
  ],
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
        name: state.name,
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      name: KRoute.signUp.name,
      path: KRoute.signUp.path,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        child: const SignUpScreen(),
      ),
    ),
    GoRoute(
      name: KRoute.questionsForm.name,
      path: KRoute.questionsForm.path,
      redirect: (context, state) =>
          context.read<AuthenticationBloc>().state.userSetting.userRole == null
              ? null
              : KRoute.thanks.path,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        child: const QuestionsFormScreen(),
      ),
    ),
    GoRoute(
      name: KRoute.thanks.name,
      path: KRoute.thanks.path,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        child: const ThanksScreen(),
      ),
    ),
    GoRoute(
      name: KRoute.home.name,
      path: KRoute.home.path,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        child: const HomeScreen(),
      ),
      routes: [
        GoRoute(
          name: KRoute.information.name,
          path: KRoute.information.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            child: const InformationScreen(),
          ),
        ),
        GoRoute(
          name: KRoute.discounts.name,
          path: KRoute.discounts.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            child: const DiscountsScreen(),
          ),
        ),
        GoRoute(
          name: KRoute.story.name,
          path: KRoute.story.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            child: const StoryScreen(),
          ),
        ),
        GoRoute(
          name: KRoute.work.name,
          path: KRoute.work.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            child: const WorkScreen(),
          ),
          routes: [
            GoRoute(
              name: KRoute.employer.name,
              path: KRoute.employer.path,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                name: state.name,
                child: const EmployerScreen(),
              ),
            ),
            GoRoute(
              name: KRoute.workEmployee.name,
              path: KRoute.workEmployee.path,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                name: state.name,
                child: const WorkEmployeeScreen(),
              ),
              routes: [
                GoRoute(
                  name: KRoute.workRespond.name,
                  path: KRoute.workRespond.path,
                  pageBuilder: (context, state) => NoTransitionPage(
                    name: state.name,
                    key: state.pageKey,
                    child: const WorkRespondScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          name: KRoute.profile.name,
          path: KRoute.profile.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            child: const ProfileScreen(),
          ),
          redirect: (context, state) =>
              context.read<AuthenticationBloc>().state.status !=
                      AuthenticationStatus.authenticated
                  ? KRoute.home.path
                  : null,
        ),
        GoRoute(
          name: KRoute.investors.name,
          path: KRoute.investors.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            child: const InvestorsScreen(),
          ),
        ),
        GoRoute(
          name: KRoute.aboutUs.name,
          path: KRoute.aboutUs.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            child: const AboutUsScreen(),
          ),
        ),
        GoRoute(
          name: KRoute.consultation.name,
          path: KRoute.consultation.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            child: const ConsultationScreen(),
          ),
        ),
        GoRoute(
          name: KRoute.contact.name,
          path: KRoute.contact.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            child: const ContactScreen(),
          ),
        ),
      ],
    ),
  ],
);

extension NavigatorExtention on BuildContext {
  void goNamedWithScroll(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    Scrollable.ensureVisible(this, alignment: KSize.kTopScroll);
    GoRouter.of(this).goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }
}
