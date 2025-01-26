import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discounts/bloc/watcher/discounts_watcher_bloc.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/components/mob_faq/bloc/mob_faq_watcher_bloc.dart';
import 'package:veteranam/l10n/l10n.dart';
import 'package:veteranam/shared/bloc/bloc.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/models/user_setting_model.dart';
import 'package:veteranam/shared/widget/mob_feedback_widget.dart';

import '../test_mocks/test_mocks.dart';

/// COMMENT: Helpers adds common elements to all screens in tests
///
/// mockGoRouter sets if you want use go router
extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MockGoRouter? mockGoRouter,
    bool addFeedback = false,
  }) async {
    await pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetIt.I.get<AppLayoutCubit>(),
          ),
          BlocProvider(
            create: (context) => GetIt.I.get<DiscountsWatcherBloc>(),
            // ..add(const DiscountsWatcherEvent.started()),
          ),
          BlocProvider(
            create: (context) => GetIt.I.get<InvestorsWatcherBloc>(),
            // ..add(const InvestorsWatcherEvent.started()),
          ),
          BlocProvider(
            create: (context) => GetIt.I.get<AuthenticationBloc>(),
            // ..add(
            //   AuthenticationInitialized(),
            // ),
          ),
          BlocProvider(
            create: (context) => GetIt.I.get<UserWatcherBloc>(),
            // ..add(
            //   const UserWatcherEvent.started(),
            // ),
          ),
          // BlocProvider(
          //   create: (context) => GetIt.I.get<LanguageBloc>(),
          // ),
          BlocProvider(
            create: (context) => GetIt.I.get<UrlCubit>(),
          ),
          BlocProvider(
            create: (context) => GetIt.I.get<NetworkCubit>(),
          ),
          if (Config.isBusiness)
            BlocProvider(
              create: (context) => GetIt.I.get<CompanyWatcherBloc>(),
              //     ..add(const CompanyWatcherEvent.started()),
            ),
          if (!Config.isWeb) ...[
            BlocProvider(
              create: (context) => GetIt.I.get<MobFeedbackBloc>(),
            ),
            BlocProvider(
              create: (context) => GetIt.I.get<MobFaqWatcherBloc>(),
              // ..add(
              //   const MobFaqWatcherEvent.started(),
              // ),
            ),
            BlocProvider(
              create: (context) => GetIt.I.get<MobOfflineModeCubit>(),
            ),
            BlocProvider(
              create: (context) => GetIt.I.get<AppVersionCubit>(),
            ),
          ],
        ],
        child: BlocSelector<UserWatcherBloc, UserWatcherState, Language>(
          selector: (state) => state.userSetting.locale,
          builder: (context, language) {
            if (mockGoRouter == null) {
              return _body(
                widget: widget,
                currentLocale: language.value,
                addFeedback: addFeedback,
              );
            } else {
              return MockGoRouterProvider(
                goRouter: mockGoRouter,
                child: _body(
                  widget: widget,
                  currentLocale: language.value,
                  addFeedback: addFeedback,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _body({
    required Widget widget,
    required Locale currentLocale,
    required bool addFeedback,
  }) =>
      Config.isWeb || !addFeedback
          ? _materialApp(
              widget: widget,
              currentLocale: currentLocale,
            )
          : BetterFeedback(
              localizationsDelegates: locale,
              localeOverride: currentLocale,
              mode: FeedbackMode.navigate,
              feedbackBuilder: (context, onSubmit, scrollController) =>
                  MobFeedbackWidget(
                onSubmit: onSubmit,
                // scrollController: scrollController,
              ),
              child: _materialApp(
                widget: widget,
                currentLocale: currentLocale,
              ),
            );
  Widget _materialApp({
    required Widget widget,
    required Locale currentLocale,
  }) =>
      MaterialApp(
        localizationsDelegates: locale,
        locale: currentLocale,
        supportedLocales: supportedLocales,
        home: widget,
      );
}
