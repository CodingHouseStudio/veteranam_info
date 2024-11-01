import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/about_us/view/about_us_view.dart';
import 'package:veteranam/components/consultation/view/consultation_view.dart';
import 'package:veteranam/components/discount_card/view/diiscount_card_view.dart';
import 'package:veteranam/components/discounts/view/discounts_view.dart';
import 'package:veteranam/components/employee_respond/view/employee_respond_view.dart';
import 'package:veteranam/components/error/view/error_view.dart';
import 'package:veteranam/components/feedback/view/feedback_view.dart';
import 'package:veteranam/components/home/view/home_view.dart';
import 'package:veteranam/components/information/view/information_view.dart';
import 'package:veteranam/components/investors/view/investors_view.dart';
import 'package:veteranam/components/login/view/login_view.dart';
import 'package:veteranam/components/markdown_file_dialog/view/markdown_file_view.dart';
import 'package:veteranam/components/my_story/view/my_story_view.dart';
import 'package:veteranam/components/news_card/view/news_card_view.dart';
// import 'package:veteranam/components/password_reset/view/password_reset_view.dart';
import 'package:veteranam/components/profile/view/profile_view.dart';
import 'package:veteranam/components/profile_saves/view/profile_saves_view.dart';
// import 'package:veteranam/components/pw_reset_email/view/pw_reset_email_view.dart';
import 'package:veteranam/components/sign_up/view/sign_up_view.dart';
import 'package:veteranam/components/story/view/story_view.dart';
import 'package:veteranam/components/story_add/view/story_add_view.dart';
import 'package:veteranam/components/user_role/view/user_role_view.dart';
import 'package:veteranam/components/work/view/work_view.dart';
import 'package:veteranam/components/work_employee/view/work_employee_view.dart';
import 'package:veteranam/components/work_employer/view/employer_view.dart';
import 'package:veteranam/shared/shared_flutter.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// COMMENT: Variable for navigation in App
/// restorationId - Saves the screen state. This is useful for our mobile
/// applications.
/// For example, if a user opens our app and navigates through three screens,
/// then switches to another app, when they return to our app,
/// it opens on the last screen they accessed. This provides a seamless
/// and convenient user experience.

GoRouter router = GoRouter(
  routerNeglect: true,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => const ErrorScreen(),
  refreshListenable:
      GoRouterRefreshStream(GetIt.instance<AuthenticationBloc>().stream),
  initialLocation: KRoute.home.path,
  observers: [
    if (Config.isProduction && Config.isReleaseMode)
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
          ?
          // context.read<AuthenticationBloc>().state.userSetting.userRole ==
          //         null
          //     ? KRoute.questionsForm.path
          //     :
          KRoute.home.path
          : null;
    }
    return null;
  },
  routes: [
    // if (Config.isDevelopment)
    GoRoute(
      name: KRoute.userRole.name,
      path: KRoute.userRole.path,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        restorationId: state.pageKey.value,
        child: const UserRoleScreen(),
      ),
      routes: [
        GoRoute(
          name: KRoute.login.name,
          path: KRoute.login.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            restorationId: state.pageKey.value,
            child: const LoginScreen(),
          ),
          // routes: [
          //   GoRoute(
          //     name: KRoute.passwordReset.name,
          //     path: KRoute.passwordReset.path,
          //     pageBuilder: (context, state) => NoTransitionPage(
          //       key: state.pageKey,
          //       name: state.name,
          //       restorationId: state.pageKey.value,
          //       child: PasswordResetScreen(
          //         code:
          //             state.uri.queryParameters[UrlParameters.
          // verificationCode],
          //       ),
          //     ),
          //     routes: [
          //       GoRoute(
          //         name: KRoute.pwResetEmail.name,
          //         path: KRoute.pwResetEmail.path,
          //         pageBuilder: (context, state) => NoTransitionPage(
          //           key: state.pageKey,
          //           name: state.name,
          //           restorationId: state.pageKey.value,
          //           child: PwResetEmailScreen(
          //             email: state.uri.queryParameters[UrlParameters.email],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ],
        ),
        GoRoute(
          name: KRoute.signUp.name,
          path: KRoute.signUp.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            restorationId: state.pageKey.value,
            child: const SignUpScreen(),
          ),
        ),
      ],
    ),
    // if (Config.isDevelopment)
    //   GoRoute(
    //     name: KRoute.questionsForm.name,
    //     path: KRoute.questionsForm.path,
    //     redirect: (context, state) =>
    //         context.read<AuthenticationBloc>().state.userSetting.userRole ==
    //                 null
    //             ? null
    //             : KRoute.thanks.path,
    //     pageBuilder: (context, state) => NoTransitionPage(
    //       key: state.pageKey,
    //       name: state.name,
    //       restorationId: state.pageKey.value,
    //       child: const QuestionsFormScreen(),
    //     ),
    //   ),
    // if (Config.isDevelopment)
    //   GoRoute(
    //     name: KRoute.thanks.name,
    //     path: KRoute.thanks.path,
    //     pageBuilder: (context, state) => NoTransitionPage(
    //       key: state.pageKey,
    //       name: state.name,
    //       restorationId: state.pageKey.value,
    //       child: const ThanksScreen(),
    //     ),
    //   ),
    GoRoute(
      name: KRoute.home.name,
      path: KRoute.home.path,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        restorationId: state.pageKey.value,
        child: const HomeScreen(),
      ),
      routes: [
        GoRoute(
          name: KRoute.privacyPolicy.name,
          path: KRoute.privacyPolicy.path,
          pageBuilder: (context, state) => DialogPage(
            key: state.pageKey,
            name: state.name,
            restorationId: state.pageKey.value,
            builder: (_) => MarkdownFileDialog(
              ukFilePath: KAppText.ukPrivacyPolicyPath,
              enFilePath: KAppText.enPrivacyPolicyPath,
              startText: context.l10n.privacyPolicyStart,
            ),
          ),
        ),
        if (Config.isDevelopment)
          GoRoute(
            name: KRoute.information.name,
            path: KRoute.information.path,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              name: state.name,
              restorationId: state.pageKey.value,
              child: const InformationScreen(),
            ),
            routes: [
              GoRoute(
                name: KRoute.newsCard.name,
                path: ':${UrlParameters.cardId}',
                pageBuilder: (context, state) => DialogPage(
                  key: state.pageKey,
                  name: state.name,
                  restorationId: state.pageKey.value,
                  builder: (_) => NewsCardDialog(
                    id: state.pathParameters[UrlParameters.cardId],
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
              restorationId: state.pageKey.value,
              child: const StoryScreen(),
            ),
            routes: [
              GoRoute(
                name: KRoute.storyAdd.name,
                path: KRoute.storyAdd.path,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  restorationId: state.pageKey.value,
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
              restorationId: state.pageKey.value,
              child: const WorkScreen(),
            ),
            routes: [
              GoRoute(
                name: KRoute.employer.name,
                path: KRoute.employer.path,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  restorationId: state.pageKey.value,
                  child: const WorkEmployerScreen(),
                ),
              ),
              GoRoute(
                name: KRoute.workEmployee.name,
                path: KRoute.workEmployee.path,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  restorationId: state.pageKey.value,
                  child: const WorkEmployeeScreen(),
                ),
                routes: [
                  GoRoute(
                    name: KRoute.employeeRespond.name,
                    path: KRoute.employeeRespond.path,
                    pageBuilder: (context, state) => NoTransitionPage(
                      name: state.name,
                      restorationId: state.pageKey.value,
                      key: state.pageKey,
                      child: const EmployeeRespondScreen(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        GoRoute(
          name: KRoute.discounts.name,
          path: KRoute.discounts.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            restorationId: state.pageKey.value,
            child: const DiscountsScreen(),
          ),
          routes: [
            GoRoute(
              name: KRoute.discountCard.name,
              path: ':${UrlParameters.cardId}',
              pageBuilder: (context, state) => DialogPage(
                key: state.pageKey,
                name: state.name,
                restorationId: state.pageKey.value,
                builder: (_) => DiscountCardDialog(
                  id: state.pathParameters[UrlParameters.cardId],
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          name: KRoute.profile.name,
          path: KRoute.profile.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            restorationId: state.pageKey.value,
            child: const ProfileScreen(),
          ),
          routes: [
            if (Config.isDevelopment)
              GoRoute(
                name: KRoute.profileMyStory.name,
                path: KRoute.profileMyStory.path,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  restorationId: state.pageKey.value,
                  child: const ProfileMyStoryScreen(),
                ),
              ),
            if (Config.isDevelopment)
              GoRoute(
                name: KRoute.profileSaves.name,
                path: KRoute.profileSaves.path,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  restorationId: state.pageKey.value,
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
            restorationId: state.pageKey.value,
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
              restorationId: state.pageKey.value,
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
              restorationId: state.pageKey.value,
              child: const ConsultationScreen(),
            ),
          ),
        //         GoRoute(
        //   name: KRoute.contact.name,
        //   path: KRoute.contact.path,
        //   pageBuilder: (context, state) => NoTransitionPage(
        //     key: state.pageKey,
        //     name: state.name,
        // restorationId: state.pageKey.value,
        //     child: const ContactScreen(),
        //   ),
        // ),
        GoRoute(
          name: KRoute.feedback.name,
          path: KRoute.feedback.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            restorationId: state.pageKey.value,
            child: const FeedbackScreen(),
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
