import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter/foundation.dart' deferred as foundation;
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../components/business_dashboard/business_dashboard.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// COMMENT: Variable for navigation in App
GoRouter businessRouter = GoRouter(
  routerNeglect: true,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => const ErrorScreen(),
  refreshListenable:
      GoRouterRefreshStream(GetIt.instance<AuthenticationBloc>().stream),
  initialLocation: KRoute.businessDashboard.path,
  observers: [
    if (Config.isProduction && kReleaseMode)
      FirebaseAnalyticsObserver(
        analytics: FirebaseAnalytics.instance,
        // onError: (_) => foundation.kDebugMode
        //     ? debugPrint('FirebaseAnalyticsObserver error $_')
        //     : null,
      ),
  ],
  redirect: (BuildContext context, GoRouterState state) async {
    if (context.read<AuthenticationBloc>().state.status ==
        AuthenticationStatus.authenticated) {
      return state.uri.toString().contains(KRoute.login.path) ||
              state.uri.toString().contains(KRoute.signUp.path)
          ? KRoute.businessDashboard.path
          : null;
    }
    return null;
  },
  routes: [
    // if (Config.isDevelopment)
    // GoRoute(
    //   name: KRoute.userRole.name,
    //   path: KRoute.userRole.path,
    //   pageBuilder: (context, state) => NoTransitionPage(
    //     key: state.pageKey,
    //     name: state.name,
    //     child: const UserRoleScreen(),
    //   ),
    //   routes: [
    GoRoute(
      name: KRoute.login.name,
      path: '/${KRoute.login.path}',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      name: KRoute.signUp.name,
      path: '/${KRoute.signUp.path}',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        child: const SignUpScreen(),
      ),
    ),
    GoRoute(
      name: KRoute.feedback.name,
      path: '/${KRoute.feedback.path}',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        child: const FeedbackScreen(),
      ),
    ),
    //   ],
    // ),
    // if (Config.isDevelopment)
    // GoRoute(
    //   name: KRoute.thanks.name,
    //   path: KRoute.thanks.path,
    //   pageBuilder: (context, state) => NoTransitionPage(
    //     key: state.pageKey,
    //     name: state.name,
    //     child: const ThanksScreen(),
    //   ),
    // ),
    GoRoute(
      name: KRoute.businessDashboard.name,
      path: KRoute.businessDashboard.path,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        child: const BusinessDashboardScreen(),
      ),
      redirect: businessRedirect,
      routes: [
        // GoRoute(
        //   name: KRoute.privacyPolicy.name,
        //   path: KRoute.privacyPolicy.path,
        //   pageBuilder: (context, state) => DialogPage(
        //     key: state.pageKey,
        //     name: state.name,
        //     builder: (_) => const PrivacyPolicyDialog(),
        //   ),
        // ),
        if (Config.isDevelopment || Config.isBusiness)
          GoRoute(
            name: KRoute.profile.name,
            path: KRoute.profile.path,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              name: state.name,
              child: const ProfileScreen(),
            ),
            // routes: [
            //   GoRoute(
            //     name: KRoute.profileMyStory.name,
            //     path: KRoute.profileMyStory.path,
            //     pageBuilder: (context, state) => NoTransitionPage(
            //       key: state.pageKey,
            //       name: state.name,
            //       child: const ProfileMyStoryScreen(),
            //     ),
            //   ),
            // ],
            redirect: (context, state) =>
                context.read<AuthenticationBloc>().state.status !=
                        AuthenticationStatus.authenticated
                    ? KRoute.home.path
                    : null,
          ),

        GoRoute(
          name: KRoute.myDiscounts.name,
          path: KRoute.myDiscounts.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            child: const MyDiscountsScreen(),
          ),
          routes: [
            GoRoute(
              name: KRoute.discountsAdd.name,
              path: KRoute.discountsAdd.path,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                name: state.name,
                child: const DiscountsAddScreen(),
              ),
            ),
            GoRoute(
              name: KRoute.discountCard.name,
              path: ':cardId',
              pageBuilder: (context, state) => DialogPage(
                key: state.pageKey,
                name: state.name,
                builder: (_) => DiscountCardDialog(
                  id: state.pathParameters['cardId'],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
