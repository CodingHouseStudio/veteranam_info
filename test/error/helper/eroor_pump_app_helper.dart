import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> errorPumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpWidget(
    BlocProvider(
      create: (context) =>
          GetIt.I.get<AuthenticationBloc>()..add(AuthenticationInitialized()),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) => mockGoRouter == null
            ? MaterialApp(
                localizationsDelegates: const [
                  locale,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                locale: state.userSetting.locale.value,
                supportedLocales: locale.supportedLocales,
                home: const ErrorScreen(),
              )
            : MaterialApp(
                localizationsDelegates: const [
                  locale,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                locale: state.userSetting.locale.value,
                supportedLocales: locale.supportedLocales,
                home: const ErrorScreen(),
              ),
      ),
    ),
  );

  expect(
    find.byKey(KWidgetkeys.screen.error.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
