import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discountCard} ', () {
    late IDiscountRepository mockDiscountRepository;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
    late IUrlRepository mockUrlRepository;
    late IReportRepository mockReportRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      mockDiscountRepository = MockIDiscountRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      mockUrlRepository = MockIUrlRepository();
      mockReportRepository = MockIReportRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      Config.testIsWeb = false;
      Config.roleValue = Config.business;

      when(
        mockUrlRepository.copy(
          KTestVariables.fullDiscount.phoneNumber!,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );

      when(
        mockUrlRepository.launchUrl(
          url: KTestVariables.fullDiscount.phoneNumber!,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
    });
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(
          mockFirebaseRemoteConfigProvider.getBool(
            RemoteConfigKey.showOnlyBusinessDiscounts,
          ),
        ).thenAnswer(
          (realInvocation) => true,
        );
        when(
          mockDiscountRepository.getDiscount(
            id: KTestVariables.id,
            showOnlyBusinessDiscounts: true,
          ),
        ).thenAnswer(
          (realInvocation) async => const Left(SomeFailure.serverError),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockUrlRepository: mockUrlRepository,
          mockReportRepository: mockReportRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        );

        await discountInitialHelper(tester: tester, cardIsEmpty: true);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockUrlRepository: mockUrlRepository,
            mockReportRepository: mockReportRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
            mockGoRouter: mockGoRouter,
          );

          await discountInitialHelper(tester: tester, cardIsEmpty: true);
        });
      });
    });
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(
          mockFirebaseRemoteConfigProvider.getBool(
            RemoteConfigKey.showOnlyBusinessDiscounts,
          ),
        ).thenAnswer(
          (realInvocation) => false,
        );
        when(
          mockDiscountRepository.getDiscount(
            id: KTestVariables.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer(
          (realInvocation) async => Right(KTestVariables.fullDiscount),
        );
        Config.roleValue = Config.business;
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
          mockUrlRepository: mockUrlRepository,
          mockReportRepository: mockReportRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        );

        await discountInitialHelper(tester: tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockUrlRepository: mockUrlRepository,
            mockReportRepository: mockReportRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockDiscountRepository: mockDiscountRepository,
            mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          );

          await discountInitialHelper(tester: tester);
        });
      });
    });
  });
}
