import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';
import 'widget/widget.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.login} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    late LoginBloc loginBloc;
    setUp(() {
      ExtendedDateTime.customTime = KTestText.feedbackModel.timestamp;
      mockAuthenticationRepository = MockAuthenticationRepository();
      when(
        mockAuthenticationRepository.logIn(
          email: KTestText.userEmail,
          password: KTestText.passwordCorrect,
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
      when(
        mockAuthenticationRepository.logIn(
          email: KTestText.userEmail,
          password: KTestText.passwordCorrect,
        ),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
      when(
        mockAuthenticationRepository.logIn(
          email: KTestText.useremailWrong,
          password: KTestText.passwordWrong,
        ),
      ).thenAnswer(
        (invocation) async => const Left(SomeFailure.serverError()),
      );
    });

    void registerLoginBloc() {
      loginBloc = LoginBloc(
        authenticationRepository: mockAuthenticationRepository,
      );
      if (GetIt.I.isRegistered<LoginBloc>()) {
        GetIt.I.unregister<LoginBloc>();
      }
      GetIt.I.registerSingleton<LoginBloc>(loginBloc);
    }

    testWidgets('${KGroupText.intial} ', (tester) async {
      await tester.pumpApp(
        const LoginScreen(),
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.bottomButtons),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.button),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.card),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp,
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.fields),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.signUpButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.signUpText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.title),
        findsOneWidget,
      );

      expect(find.byKey(KWidgetkeys.screen.login.failureMessage), findsNothing);

      await leftCardHelper(tester);

      await emailPasswordFieldsHelper(tester: tester, showPassword: false);

      await signUpBottomButtonsHelper(tester);
    });
    testWidgets('Write incorrect email', (tester) async {
      registerLoginBloc();
      await tester.pumpApp(
        const LoginScreen(),
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      expect(
        find.byKey(KWidgetkeys.screen.login.fields),
        findsOneWidget,
      );

      await emailPasswordFieldsEmHelper(
        tester: tester,
        email: KTestText.useremailIncorrect,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.login.button));

      await tester.pumpAndSettle();

      await emailPasswordFieldsHelper(
        tester: tester,
        showPassword: false,
      );

      expect(find.byKey(KWidgetkeys.screen.login.failureMessage), findsNothing);
    });

    testWidgets('Write correct email and hide password', (tester) async {
      registerLoginBloc();
      await tester.pumpApp(
        const LoginScreen(),
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await emailPasswordFieldsEmHelper(
        tester: tester,
        email: KTestText.userEmail,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.login.button));

      await tester.pumpAndSettle();

      await emailPasswordFieldsHelper(tester: tester, showPassword: true);

      await emailPasswordFieldsHidePasHelper(tester);

      await emailPasswordFieldsHelper(tester: tester, showPassword: false);
    });

    testWidgets(
        'Write correct email and incorect password and'
        ' tap submited', (tester) async {
      registerLoginBloc();
      await tester.pumpApp(
        const LoginScreen(),
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await loginFieldsHelper(
        tester: tester,
        password: KTestText.passwordIncorrect,
        email: KTestText.userEmail,
        dataIsCorrect: false,
      );

      expect(find.byKey(KWidgetkeys.screen.login.failureMessage), findsNothing);
    });

    testWidgets(
        'Write correct email and password and'
        ' tap submited', (tester) async {
      registerLoginBloc();
      await tester.pumpApp(
        const LoginScreen(),
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await loginFieldsHelper(
        tester: tester,
        password: KTestText.passwordCorrect,
        email: KTestText.userEmail,
        dataIsCorrect: true,
      );

      expect(find.byKey(KWidgetkeys.screen.login.failureMessage), findsNothing);
    });

    testWidgets(
        'Write wrong email and password and'
        ' tap submited', (tester) async {
      registerLoginBloc();
      await tester.pumpApp(
        const LoginScreen(),
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await loginFieldsHelper(
        tester: tester,
        password: KTestText.passwordWrong,
        email: KTestText.useremailWrong,
        dataIsCorrect: true,
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.failureMessage),
        findsOneWidget,
      );
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await tester.pumpApp(
          const LoginScreen(),
          mockGoRouter: mockGoRouter,
        );

        expect(
          find.byKey(KWidgetkeys.screen.login.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        await scrollingHelper(
          tester: tester,
          offset: KTestConstants.scrollingDown,
        );

        expect(
          find.byKey(KWidgetkeys.screen.login.bottomButtons),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.login.button),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.login.card),
          findsOneWidget,
        );

        await scrollingHelper(
          tester: tester,
          offset: KTestConstants.scrollingUp,
        );

        expect(
          find.byKey(KWidgetkeys.screen.login.fields),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.login.signUpButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.login.signUpText),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.login.title),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.login.failureMessage),
          findsNothing,
        );

        await leftCardHelper(tester);

        await emailPasswordFieldsHelper(tester: tester, showPassword: false);

        await signUpBottomButtonsHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('Navigate to ${KScreenBlocName.signUp}', (tester) async {
          await tester.pumpApp(
            const LoginScreen(),
            mockGoRouter: mockGoRouter,
          );

          expect(
            find.byKey(KWidgetkeys.screen.login.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await singUpNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
