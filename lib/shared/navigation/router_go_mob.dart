import 'dart:developer' show log;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/discount/view/discount_view.dart';
// import 'package:veteranam/components/discount_card/view/diiscount_card_view.dart';
import 'package:veteranam/components/discounts/view/discounts_view.dart';
import 'package:veteranam/components/error/view/error_view.dart';
import 'package:veteranam/components/feedback/view/feedback_view.dart';
import 'package:veteranam/components/investors/view/investors_view.dart';
import 'package:veteranam/components/login/view/login_view.dart';
import 'package:veteranam/components/markdown_file_dialog/view/markdown_file_view.dart';
import 'package:veteranam/components/mob_authentication_dialog/mob_authentication_dialog.dart';
import 'package:veteranam/components/mob_faq/view/mob_faq_view.dart';
import 'package:veteranam/components/mob_settings/view/mob_settings_view.dart';
import 'package:veteranam/components/password_reset/view/password_reset_view.dart';
import 'package:veteranam/components/profile/view/profile_view.dart';
import 'package:veteranam/components/pw_reset_email/view/pw_reset_email_view.dart';
import 'package:veteranam/components/sign_up/view/sign_up_view.dart';
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
  // routerNeglect: true,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => const ErrorScreen(),
  refreshListenable:
      GoRouterRefreshStream(GetIt.instance<AuthenticationBloc>().stream),
  initialLocation: '${KRoute.settings.path}${KRoute.discounts.path}',
  observers: [
    if (Config.isProduction && Config.isReleaseMode)
      FirebaseAnalyticsObserver(
        analytics: FirebaseAnalytics.instance,
        onError: (_) => log(
          '${ErrorText.firebaseAnalyticsObserver} ${_.code}',
          error: 'Message: ${_.message},Detail ${_.details},'
              ' StackTrace ${_.stacktrace}',
          name: ErrorText.firebaseAnalyticsObserver,
          sequenceNumber: KDimensions.logLevelWarning,
          level: KDimensions.logLevelWarning,
        ),
      ),
  ],
  redirect: (BuildContext context, GoRouterState state) async {
    if (context.read<AuthenticationBloc>().state.status ==
        AuthenticationStatus.authenticated) {
      final fullPath = state.fullPath;
      if (fullPath != null) {
        if (fullPath.contains(KRoute.login.path)) {
          return '${KRoute.userRole.path}/${KRoute.login.path}/${KRoute.mobLoginAuthenticationDialog.path}';
        } else if (fullPath.contains(KRoute.signUp.path)) {
          return '${KRoute.userRole.path}/${KRoute.signUp.path}/${KRoute.mobSignUpAuthenticationDialog.path}';
        }
      }
    }
    return null;
  },
  routes: [
    GoRoute(
      name: KRoute.login.name,
      path: '${KRoute.userRole.path}/${KRoute.login.path}',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        restorationId: state.pageKey.value,
        child: const LoginScreen(),
      ),
      routes: [
        GoRoute(
          name: KRoute.mobLoginAuthenticationDialog.name,
          path: KRoute.mobLoginAuthenticationDialog.path,
          pageBuilder: (context, state) => DialogPage(
            key: state.pageKey,
            name: state.name,
            restorationId: state.pageKey.value,
            barrierDismissible: false,
            builder: (_) => const MobAuthenticationDialog(
              state: MobAuthenticationDialogState.login,
            ),
          ),
        ),
        GoRoute(
          name: KRoute.resetPassword.name,
          path: KRoute.resetPassword.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            restorationId: state.pageKey.value,
            child: PasswordResetScreen(
              code: state.uri.queryParameters[UrlParameters.verificationCode],
              continueUrl: state.uri.queryParameters[UrlParameters.continueUrl],
            ),
          ),
        ),
        GoRoute(
          name: KRoute.forgotPassword.name,
          path: KRoute.forgotPassword.path,
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
    GoRoute(
      name: KRoute.signUp.name,
      path: '${KRoute.userRole.path}/${KRoute.signUp.path}',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        restorationId: state.pageKey.value,
        child: const SignUpScreen(),
      ),
      routes: [
        GoRoute(
          name: KRoute.mobSignUpAuthenticationDialog.name,
          path: KRoute.mobSignUpAuthenticationDialog.path,
          pageBuilder: (context, state) => DialogPage(
            key: state.pageKey,
            name: state.name,
            barrierDismissible: false,
            restorationId: state.pageKey.value,
            builder: (_) => const MobAuthenticationDialog(
              state: MobAuthenticationDialogState.signUp,
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      name: KRoute.settings.name,
      path: KRoute.settings.path,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        restorationId: state.pageKey.value,
        child: const MobSettingsScreen(),
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
              name: KRoute.discount.name,
              path: ':${UrlParameters.cardId}',
              pageBuilder: (context, state) {
                DiscountModel? discountModel;
                if (state.extra is DiscountModel) {
                  discountModel = state.extra as DiscountModel?;
                }
                return NoTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  restorationId: state.pageKey.value,
                  child: DiscountScreen(
                    discount: discountModel,
                    discountId: state.pathParameters[UrlParameters.cardId],
                  ),
                );
              },
            ),
          ],
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
        GoRoute(
          name: KRoute.mobFAQ.name,
          path: KRoute.mobFAQ.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            name: state.name,
            restorationId: state.pageKey.value,
            child: const MobFaqScreen(),
          ),
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
          redirect: (context, state) =>
              context.read<AuthenticationBloc>().state.status !=
                      AuthenticationStatus.authenticated
                  ? '${KRoute.settings.path}${KRoute.discounts.path}'
                  : null,
        ),
      ],
    ),
  ],
);
