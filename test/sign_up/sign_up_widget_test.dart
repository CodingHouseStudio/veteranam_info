import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';
import 'widget/login_navigation_helper.dart';
import 'widget/widget.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.signUp} ', () {
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late SignUpBloc signUpBloc;
    setUp(() {
      {
        ExtendedDateTime.customTime = KTestText.feedbackModel.timestamp;
        mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
        when(
          mockAppAuthenticationRepository.signUp(
            email: KTestText.useremail,
            password: KTestText.passwordCorrect,
          ),
        ).thenAnswer(
          (invocation) async => const Right(true),
        );
      }
    });

    void registerSignUpkBloc() {
      signUpBloc = SignUpBloc(
        iAppAuthenticationRepository: mockAppAuthenticationRepository,
      );
      if (GetIt.I.isRegistered<SignUpBloc>()) {
        GetIt.I.unregister<SignUpBloc>();
      }
      GetIt.I.registerSingleton<SignUpBloc>(signUpBloc);
    }

    testWidgets('${KGroupText.intial} ', (tester) async {
      await tester.pumpApp(
        const SignUpScreen(),
        withoutShellRoute: true,
        fullPath: KRoute.signUp.path,
      );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      expect(
        find.byKey(KWidgetkeys.screen.signUp.bottomButtons),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.button),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.card),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.fields),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.loginButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.loginText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.title),
        findsOneWidget,
      );

      await leftCardHelper(tester);

      await emailPasswordFieldsHelper(tester: tester, showPassword: false);

      await signUpBottomButtonsHelper(tester);
    });
    testWidgets('Write incorrect email', (tester) async {
      registerSignUpkBloc();
      await tester.pumpApp(
        const SignUpScreen(),
        withoutShellRoute: true,
        fullPath: KRoute.signUp.path,
      );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      expect(
        find.byKey(KWidgetkeys.screen.signUp.fields),
        findsOneWidget,
      );

      await emailPasswordFieldsEmHelper(
        tester: tester,
        email: KTestText.useremailIncorrect,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.signUp.button));

      await tester.pumpAndSettle();

      await emailPasswordFieldsHelper(
        tester: tester,
        showPassword: false,
      );
    });

    testWidgets('Write correct email and hide password', (tester) async {
      registerSignUpkBloc();
      await tester.pumpApp(
        const SignUpScreen(),
        withoutShellRoute: true,
        fullPath: KRoute.signUp.path,
      );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await emailPasswordFieldsEmHelper(
        tester: tester,
        email: KTestText.useremail,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.signUp.button));

      await tester.pumpAndSettle();

      await emailPasswordFieldsHelper(tester: tester, showPassword: true);

      await emailPasswordFieldsHidePasHelper(tester);

      await emailPasswordFieldsHelper(tester: tester, showPassword: false);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await tester.pumpApp(
          const SignUpScreen(),
          withoutShellRoute: true,
          mockGoRouter: mockGoRouter,
          fullPath: KRoute.signUp.path,
        );

        expect(
          find.byKey(KWidgetkeys.screen.signUp.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.screen.signUp.bottomButtons),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.signUp.button),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.signUp.card),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.signUp.fields),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.signUp.loginButton),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.signUp.loginText),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.signUp.title),
          findsOneWidget,
        );

        await leftCardHelper(tester);

        await emailPasswordFieldsHelper(tester: tester, showPassword: false);

        await signUpBottomButtonsHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('Navigate to ${KScreenBlocName.signUp}', (tester) async {
          await tester.pumpApp(
            const SignUpScreen(),
            withoutShellRoute: true,
            mockGoRouter: mockGoRouter,
            fullPath: KRoute.login.path,
          );

          expect(
            find.byKey(KWidgetkeys.screen.signUp.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await loginNavigationHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        testWidgets('Write correct email and incorect password',
            (tester) async {
          registerSignUpkBloc();
          await tester.pumpApp(
            const SignUpScreen(),
            withoutShellRoute: true,
            fullPath: KRoute.signUp.path,
            mockGoRouter: mockGoRouter,
          );

          expect(
            find.byKey(KWidgetkeys.screen.signUp.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await signUpFieldsHelper(
            tester: tester,
            password: KTestText.passwordIncorrect,
            email: KTestText.useremail,
            dataIsCorrect: false,
            mockGoRouter: mockGoRouter,
          );
        });

        testWidgets(
            'Write correct email and password and Navigate'
            ' to ${KScreenBlocName.home}', (tester) async {
          registerSignUpkBloc();
          await tester.pumpApp(
            const SignUpScreen(),
            withoutShellRoute: true,
            fullPath: KRoute.signUp.path,
            mockGoRouter: mockGoRouter,
          );

          expect(
            find.byKey(KWidgetkeys.screen.signUp.screen),
            findsOneWidget,
          );

          await tester.pumpAndSettle();

          await signUpFieldsHelper(
            tester: tester,
            password: KTestText.passwordCorrect,
            email: KTestText.useremail,
            dataIsCorrect: true,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}
