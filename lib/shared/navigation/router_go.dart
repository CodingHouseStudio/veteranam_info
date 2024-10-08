import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/components.dart'
    show
        AboutUsScreen,
        ConsultationScreen,
        DiscountCardDialog,
        DiscountsScreen,
        EmployeeRespondScreen,
        ErrorScreen,
        FeedbackScreen,
        HomeScreen,
        InformationScreen,
        InvestorsScreen,
        LoginScreen,
        MobFaqScreen,
        MobSettingsScreen,
        NewsCardDialog,
        PasswordResetScreen,
        PrivacyPolicyDialog,
        ProfileMyStoryScreen,
        ProfileSavesScreen,
        ProfileScreen,
        PwResetEmailScreen,
        QuestionsFormScreen,
        SignUpScreen,
        StoryAddScreen,
        StoryScreen,
        ThanksScreen,
        UserRoleScreen,
        WorkEmployeeScreen,
        WorkEmployerScreen,
        WorkScreen;
import 'package:veteranam/shared/shared.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// COMMENT: Variable for navigation in App
GoRouter router = GoRouter(
  routerNeglect: true,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => const ErrorScreen(),
  refreshListenable:
      GoRouterRefreshStream(GetIt.instance<AuthenticationBloc>().stream),
  initialLocation: kIsWeb ? KRoute.home.path : '/${KRoute.discounts.path}',
  observers: [
    if (Config.isProduction && kReleaseMode)
      FirebaseAnalyticsObserver(
        analytics: FirebaseAnalytics.instance,
        // We have in the if kReleaseMode
        // onError: (_) =>
        // foundation.kDebugMode
        //     ? debugPrint('FirebaseAnalyticsObserver error $_')
        //     : null,
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
    if (Config.isDevelopment)
      GoRoute(
        name: KRoute.userRole.name,
        path: KRoute.userRole.path,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          name: state.name,
          child: const UserRoleScreen(),
        ),
        routes: [
          GoRoute(
            name: KRoute.login.name,
            path: KRoute.login.path,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              name: state.name,
              child: const LoginScreen(),
            ),
            routes: [
              GoRoute(
                name: KRoute.passwordReset.name,
                path: KRoute.passwordReset.path,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: PasswordResetScreen(
                    code: state.uri.queryParameters['oobCode'],
                  ),
                ),
                routes: [
                  GoRoute(
                    name: KRoute.pwResetEmail.name,
                    path: KRoute.pwResetEmail.path,
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      name: state.name,
                      child: const PwResetEmailScreen(),
                    ),
                  ),
                ],
              ),
            ],
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
        ],
      ),
    if (Config.isDevelopment)
      GoRoute(
        name: KRoute.questionsForm.name,
        path: KRoute.questionsForm.path,
        redirect: (context, state) =>
            context.read<AuthenticationBloc>().state.userSetting.userRole ==
                    null
                ? null
                : KRoute.thanks.path,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          name: state.name,
          child: const QuestionsFormScreen(),
        ),
      ),
    if (Config.isDevelopment)
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
      name: kIsWeb ? KRoute.home.name : KRoute.settings.name,
      path: KRoute.home.path,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        child: kIsWeb ? const HomeScreen() : const MobSettingsScreen(),
      ),
      routes: [
        GoRoute(
          name: KRoute.privacyPolicy.name,
          path: KRoute.privacyPolicy.path,
          pageBuilder: (context, state) => DialogPage(
            key: state.pageKey,
            name: state.name,
            builder: (_) => const PrivacyPolicyDialog(),
          ),
        ),
        if (Config.isDevelopment)
          GoRoute(
            name: KRoute.information.name,
            path: KRoute.information.path,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              name: state.name,
              child: const InformationScreen(),
            ),
            routes: [
              GoRoute(
                name: KRoute.newsCard.name,
                path: ':cardId',
                pageBuilder: (context, state) => DialogPage(
                  key: state.pageKey,
                  name: state.name,
                  builder: (_) => NewsCardDialog(
                    id: state.pathParameters['cardId'],
                  ),
                ),
              ),
            ],
          ),
        GoRoute(
          name: KRoute.discounts.name,
          path: KRoute.discounts.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            child: const DiscountsScreen(),
          ),
          routes: [
            // if (Config.isDevelopment)
            //   GoRoute(
            //     name: KRoute.myDiscounts.name,
            //     path: KRoute.myDiscounts.path,
            //     pageBuilder: (context, state) => NoTransitionPage(
            //       key: state.pageKey,
            //       name: state.name,
            //       child: const MyDiscountsScreen(),
            //     ),
            //   ),
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
        if (Config.isDevelopment)
          GoRoute(
            name: KRoute.stories.name,
            path: KRoute.stories.path,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              name: state.name,
              child: const StoryScreen(),
            ),
            routes: [
              GoRoute(
                name: KRoute.storyAdd.name,
                path: KRoute.storyAdd.path,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: const StoryAddScreen(),
                ),
              ),
            ],
          ),
        if (Config.isDevelopment)
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
                  child: const WorkEmployerScreen(),
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
                    name: KRoute.employeeRespond.name,
                    path: KRoute.employeeRespond.path,
                    pageBuilder: (context, state) => NoTransitionPage(
                      name: state.name,
                      key: state.pageKey,
                      child: const EmployeeRespondScreen(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        if (Config.isDevelopment)
          GoRoute(
            name: KRoute.profile.name,
            path: KRoute.profile.path,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              name: state.name,
              child: const ProfileScreen(),
            ),
            routes: [
              GoRoute(
                name: KRoute.profileMyStory.name,
                path: KRoute.profileMyStory.path,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: const ProfileMyStoryScreen(),
                ),
              ),
              GoRoute(
                name: KRoute.profileSaves.name,
                path: KRoute.profileSaves.path,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: const ProfileSavesScreen(),
                ),
              ),
            ],
            redirect: (context, state) =>
                context.read<AuthenticationBloc>().state.status !=
                        AuthenticationStatus.authenticated
                    ? KRoute.home.path
                    : null,
          ),
        GoRoute(
          name: KRoute.support.name,
          path: KRoute.support.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            child: const InvestorsScreen(),
          ),
        ),
        if (Config.isDevelopment)
          GoRoute(
            name: KRoute.aboutUs.name,
            path: KRoute.aboutUs.path,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              name: state.name,
              child: const AboutUsScreen(),
            ),
          ),
        if (Config.isDevelopment)
          GoRoute(
            name: KRoute.consultation.name,
            path: KRoute.consultation.path,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              name: state.name,
              child: const ConsultationScreen(),
            ),
          ),
        //         GoRoute(
        //   name: KRoute.contact.name,
        //   path: KRoute.contact.path,
        //   pageBuilder: (context, state) => NoTransitionPage(
        //     key: state.pageKey,
        //     name: state.name,
        //     child: const ContactScreen(),
        //   ),
        // ),
        GoRoute(
          name: KRoute.feedback.name,
          path: KRoute.feedback.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            child: const FeedbackScreen(),
          ),
        ),
        if (!kIsWeb)
          GoRoute(
            name: KRoute.mobFAQ.name,
            path: KRoute.mobFAQ.path,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              name: state.name,
              child: const MobFaqScreen(),
            ),
          ),
      ],
    ),
  ],
);

// extension NavigatorExtention on BuildContext {
//   void goNamedWithScroll(
//     String name, {
//     Map<String, String> pathParameters = const <String, String>{},
//     Map<String, dynamic> queryParameters = const <String, dynamic>{},
//     Object? extra,
//   }) {
//     // if (read<ScrollCubit>().state.positions.isNotEmpty) {
//     //   read<ScrollCubit>().scrollUp();
//     // }
//     // read<ScrollCubit>().initial();
//     goNamed(
//       name,
//       pathParameters: pathParameters,
//       queryParameters: queryParameters,
//       extra: extra,
//     );
//   }
// }
