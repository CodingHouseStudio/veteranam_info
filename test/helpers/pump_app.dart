import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_mocks/test_mocks.dart';

/// COMMENT: Helpers adds common elements to all screens in tests
///
/// mockGoRouter sets if you want use go router
extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MockGoRouter? mockGoRouter,
  }) {
    return pumpWidget(
      BlocProvider(
        create: (context) =>
            GetIt.I.get<AuthenticationBloc>()..add(AuthenticationInitialized()),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) => mockGoRouter == null
              ? _body(
                  widget: widget,
                  currentLocale: state.userSetting.locale.value,
                )
              : MockGoRouterProvider(
                  goRouter: mockGoRouter,
                  child: _body(
                    widget: widget,
                    currentLocale: state.userSetting.locale.value,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _body({
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
