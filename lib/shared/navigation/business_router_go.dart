import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/components.dart'
    show
        BusinessDashboardScreen,
        CompanyScreen,
        DiscountCardDialog,
        DiscountsAddScreen,
        ErrorScreen,
        FeedbackScreen,
        LoginScreen,
        MyDiscountsScreen,
        PasswordResetScreen,
        ProfileScreen,
        PwResetEmailScreen,
        SignUpScreen;
import 'package:veteranam/shared/shared.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// COMMENT: Variable for navigation in App
/// restorationId - Saves the screen state. This is useful for our mobile
/// applications.
/// For example, if a user opens our app and navigates through three screens,
/// then switches to another app, when they return to our app,
/// it opens on the last screen they accessed. This provides a seamless
/// and convenient user experience.
GoRouter businessRouter = GoRouter(
  routerNeglect: true,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => const ErrorScreen(),
  refreshListenable:
      GoRouterRefreshStream(GetIt.instance<AuthenticationBloc>().stream),
  initialLocation:
      '/${KRoute.myDiscounts.path}', // KRoute.businessDashboard.path,
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
          ? '/${KRoute.myDiscounts.path}' //KRoute.businessDashboard.path
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
    // restorationId: state.pageKey.value,
    //     child: const UserRoleScreen(),
    //   ),
    //   routes: [
    GoRoute(
      name: KRoute.login.name,
      path: '/${KRoute.login.path}',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        restorationId: state.pageKey.value,
        child: const LoginScreen(),
      ),
      routes: [
        GoRoute(
          name: KRoute.passwordReset.name,
          path: KRoute.passwordReset.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            restorationId: state.pageKey.value,
            child: PasswordResetScreen(
              code: state.uri.queryParameters[UrlParameters.verificationCode],
            ),
          ),
          routes: [
            GoRoute(
              name: KRoute.pwResetEmail.name,
              path: KRoute.pwResetEmail.path,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                name: state.name,
                restorationId: state.pageKey.value,
                child: PwResetEmailScreen(
                  email: state.uri.queryParameters[UrlParameters.email],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: KRoute.signUp.name,
      path: '/${KRoute.signUp.path}',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        restorationId: state.pageKey.value,
        child: const SignUpScreen(),
      ),
    ),
    GoRoute(
      name: KRoute.feedback.name,
      path: '/${KRoute.feedback.path}',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        restorationId: state.pageKey.value,
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
    // restorationId: state.pageKey.value,
    //     child: const ThanksScreen(),
    //   ),
    // ),
    GoRoute(
      name: KRoute.myDiscounts.name,
      path: '/${KRoute.myDiscounts.path}',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        restorationId: state.pageKey.value,
        child: const MyDiscountsScreen(),
      ),
      // name: KRoute.businessDashboard.name,
      // path: KRoute.businessDashboard.path,
      // pageBuilder: (context, state) => NoTransitionPage(
      //   key: state.pageKey,
      //   name: state.name,
      // restorationId: state.pageKey.value,
      //   child: const BusinessDashboardScreen(),
      // ),
      redirect: businessRedirect,
      routes: [
        // GoRoute(
        //   name: KRoute.privacyPolicy.name,
        //   path: KRoute.privacyPolicy.path,
        //   pageBuilder: (context, state) => DialogPage(
        //     key: state.pageKey,
        //     name: state.name,
        // restorationId: state.pageKey.value,
        //     builder: (_) => const PrivacyPolicyDialog(),
        //   ),
        // ),
        GoRoute(
          name: KRoute.company.name,
          path: KRoute.company.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            restorationId: state.pageKey.value,
            child: const CompanyScreen(),
          ),
          // routes: [
          //   GoRoute(
          //     name: KRoute.profileMyStory.name,
          //     path: KRoute.profileMyStory.path,
          //     pageBuilder: (context, state) => NoTransitionPage(
          //       key: state.pageKey,
          //       name: state.name,
          // restorationId: state.pageKey.value,
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

        // GoRoute(
        //   name: KRoute.myDiscounts.name,
        //   path: KRoute.myDiscounts.path,
        //   pageBuilder: (context, state) => NoTransitionPage(
        //     key: state.pageKey,
        //     name: state.name,
        // restorationId: state.pageKey.value,
        //     child: const MyDiscountsScreen(),
        //   ),
        //   routes: [
        GoRoute(
          name: KRoute.discountsAdd.name,
          path: KRoute.discountsAdd.path,
          pageBuilder: (context, state) {
            final discountModel =
                DiscountURLConverter.fromJson(state.uri.queryParameters);

            return NoTransitionPage(
              key: state.pageKey,
              name: state.name,
              restorationId: state.pageKey.value,
              child: DiscountsAddScreen(
                discount: discountModel,
              ),
            );
          },
        ),
        // GoRoute(
        //   name: KRoute.discountCard.name,
        //   path: ':${UrlParameters.cardId}',
        //   pageBuilder: (context, state) => DialogPage(
        //     key: state.pageKey,
        //     name: state.name,
        // restorationId: state.pageKey.value,
        //     builder: (_) => DiscountCardDialog(
        //       id: state.pathParameters[UrlParameters.cardId],
        //     ),
        //   ),
        // ),
        //   ],
        // ),
      ],
    ),
  ],
);
