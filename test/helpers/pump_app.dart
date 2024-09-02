import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_mocks/test_mocks.dart';

/// COMMENT: Helpers adds common elements to all screens in tests
///
/// mockGoRouter sets if you want use go router
extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MockGoRouter? mockGoRouter,
    bool addFeedback = false,
  }) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetIt.I.get<DiscountWatcherBloc>()
              ..add(const DiscountWatcherEvent.started()),
          ),
          BlocProvider(
            create: (context) => GetIt.I.get<InvestorsWatcherBloc>()
              ..add(const InvestorsWatcherEvent.started()),
          ),
          BlocProvider(
            create: (context) => GetIt.I.get<AuthenticationBloc>()
              ..add(AuthenticationInitialized()),
          ),
          BlocProvider(
            create: (context) => GetIt.I.get<UrlCubit>(),
          ),
          BlocProvider(
            create: (context) =>
                GetIt.I.get<NetworkCubit>()..networkInitialized(),
          ),
          if (!KTest.testIsWeb) ...[
            BlocProvider(
              create: (context) => GetIt.I.get<MobFeedbackBloc>(),
            ),
            BlocProvider(
              create: (context) => GetIt.I.get<MobFaqWatcherBloc>()
                ..add(
                  const MobFaqWatcherEvent.started(),
                ),
            ),
            BlocProvider(
              create: (context) => GetIt.I.get<MobOfflineModeCubit>(),
            ),
            BlocProvider(
              create: (context) => GetIt.I.get<BuildCubit>()..started(),
            ),
          ],
        ],
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) => mockGoRouter == null
              ? _body(
                  widget: widget,
                  currentLocale: state.userSetting.locale.value,
                  addFeedback: addFeedback,
                )
              : MockGoRouterProvider(
                  goRouter: mockGoRouter,
                  child: _body(
                    widget: widget,
                    currentLocale: state.userSetting.locale.value,
                    addFeedback: addFeedback,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _body({
    required Widget widget,
    required Locale currentLocale,
    required bool addFeedback,
  }) =>
      KTest.testIsWeb || !addFeedback
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
