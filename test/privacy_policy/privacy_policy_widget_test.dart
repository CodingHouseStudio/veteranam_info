import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';
import '../text_dependency.dart';

import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.privacyPolicy} ', () {
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late IUrlRepository mockUrlRepository;
    setUp(
      () {
        KTest.cashe = false;
        mockAppAuthenticationRepository = MockAppAuthenticationRepository();

        when(
          mockAppAuthenticationRepository.currentUserSetting,
        ).thenAnswer(
          (realInvocation) => KTestText.userSetting,
        );

        mockUrlRepository = MockIUrlRepository();
        when(
          mockUrlRepository.launchUrl(
            url: KAppText.email,
            scheme: KAppText.emailScheme,
          ),
        ).thenAnswer(
          (realInvocation) async => const Right(true),
        );
      },
    );
    testWidgets('${KGroupText.intial} ', (tester) async {
      await privacyPolicyPumpAppHelper(
        tester: tester,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      );

      await privacyPolicyInitialHelper(tester);
    });
    testWidgets('Email Tap', (tester) async {
      await privacyPolicyPumpAppHelper(
        tester: tester,
        mockAppAuthenticationRepository: mockAppAuthenticationRepository,
      );

      await privacyPolicyEmailTapHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await privacyPolicyPumpAppHelper(
          tester: tester,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockGoRouter: mockGoRouter,
        );

        await privacyPolicyInitialHelper(tester);
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('${KRoute.home.name} ', (tester) async {
          await privacyPolicyPumpAppHelper(
            tester: tester,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockGoRouter: mockGoRouter,
          );

          await cancelHelper(tester: tester, mockGoRouter: mockGoRouter);
        });
      });
    });
  });
}
