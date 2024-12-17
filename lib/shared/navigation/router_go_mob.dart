import 'dart:developer' show log;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/discount/view/discount_view_widget.dart';
// import 'package:veteranam/components/discount_card/view/diiscount_card_view.dart';
import 'package:veteranam/components/discounts/view/discounts_view.dart';
import 'package:veteranam/components/error/view/error_view.dart';
import 'package:veteranam/components/feedback/view/feedback_view.dart';
import 'package:veteranam/components/investors/view/investors_view.dart';
import 'package:veteranam/components/login/view/login_view.dart';
import 'package:veteranam/components/markdown_file_dialog/view/markdown_file_view.dart';
import 'package:veteranam/components/mob_faq/view/mob_faq_view.dart';
import 'package:veteranam/components/mob_settings/view/mob_settings_view.dart';
import 'package:veteranam/components/profile/view/profile_view.dart';
import 'package:veteranam/components/sign_up/view/sign_up_view.dart';
import 'package:veteranam/components/user_role/view/user_role_view.dart';
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
      return state.uri.toString().contains(KRoute.login.path) ||
              state.uri.toString().contains(KRoute.signUp.path)
          ? '${KRoute.settings.path}${KRoute.discounts.path}'
          : null;
    }
    return null;
  },
  routes: [
    GoRoute(
      name: KRoute.userRole.name,
      path: KRoute.userRole.path,
      builder: (context, state) => const UserRoleScreen(),
      routes: [
        GoRoute(
          name: KRoute.login.name,
          path: KRoute.login.path,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: KRoute.signUp.name,
          path: KRoute.signUp.path,
          builder: (context, state) => const SignUpScreen(),
        ),
      ],
    ),
    GoRoute(
      name: KRoute.settings.name,
      path: KRoute.settings.path,
      builder: (context, state) => const MobSettingsScreen(),
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
          builder: (context, state) => const DiscountsScreen(),
          routes: [
            GoRoute(
              name: KRoute.discount.name,
              path: ':${UrlParameters.cardId}',
              builder: (context, state) {
                DiscountModel? discountModel;
                if (state.extra is DiscountModel) {
                  discountModel = state.extra as DiscountModel?;
                }

                return DiscountScreenWidget(
                  discount: discountModel,
                  discountId: state.pathParameters[UrlParameters.cardId],
                );
              },
            ),
          ],
        ),
        GoRoute(
          name: KRoute.support.name,
          path: KRoute.support.path,
          builder: (context, state) => const InvestorsScreen(),
        ),
        GoRoute(
          name: KRoute.feedback.name,
          path: KRoute.feedback.path,
          builder: (context, state) => const FeedbackScreen(),
        ),
        GoRoute(
          name: KRoute.mobFAQ.name,
          path: KRoute.mobFAQ.path,
          builder: (context, state) => const MobFaqScreen(),
        ),
        GoRoute(
          name: KRoute.profile.name,
          path: KRoute.profile.path,
          builder: (context, state) => const ProfileScreen(),
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
