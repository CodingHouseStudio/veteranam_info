import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.myDiscounts} ', () {
    late IDiscountRepository mockDiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      mockDiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      mockAuthenticationRepository = MockAuthenticationRepository();

      when(mockAppAuthenticationRepository.currentUser)
          .thenAnswer((invocation) => KTestText.profileUser);

      when(mockAuthenticationRepository.currentUserSetting)
          .thenAnswer((invocation) => KTestText.userSetting);
      when(
        mockDiscountRepository
            .deleteDiscountsById(KTestText.userDiscountModelItems.first.id),
      ).thenAnswer(
        (invocation) async => const Right(true),
      );
    });
    group('${KGroupText.failure} ', () {
      setUp(
        () {
          when(mockAuthenticationRepository.currentUser)
              .thenAnswer((invocation) => KTestText.userWithoutPhoto);
          when(
            mockDiscountRepository
                .getDiscountsByUserId(KTestText.profileUser.id),
          ).thenAnswer(
            (invocation) => Stream.error(KGroupText.failureGet),
          );
        },
      );
      testWidgets('${KGroupText.error} ', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await myDiscountFailureHelper(tester);
      });
    });

    group('${KGroupText.getEmptyList} with empty profile', () {
      setUp(() {
        when(mockAuthenticationRepository.currentUser)
            .thenAnswer((invocation) => KTestText.userAnonymous);
        when(
          mockDiscountRepository.getDiscountsByUserId(
            KTestText.profileUser.id,
          ),
        ).thenAnswer(
          (invocation) => Stream.value(KTestText.discountModelItems),
        );

        if (GetIt.I.isRegistered<IDiscountRepository>()) {
          GetIt.I.unregister<IDiscountRepository>();
        }
        GetIt.I.registerSingleton<IDiscountRepository>(
          mockDiscountRepository,
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );
        await myDiscountsEmptyProfilePageHelper(tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await myDiscountsPumpAppHelper(
            mockDiscountRepository: mockDiscountRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
          await myDiscountsEmptyProfilePageHelper(tester);
        });
        group(
          '${KGroupText.goTo} ',
          () {
            testWidgets('${KRoute.discountsAdd.name} ', (tester) async {
              await myDiscountsPumpAppHelper(
                mockDiscountRepository: mockDiscountRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
                mockAppAuthenticationRepository:
                    mockAppAuthenticationRepository,
                tester: tester,
                mockGoRouter: mockGoRouter,
              );

              await profileButtonDiscountsNavigationHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
              );
            });
          },
        );
      });
    });

    group('${KGroupText.getEmptyList} ', () {
      setUp(() {
        when(mockAuthenticationRepository.currentUser)
            .thenAnswer((invocation) => KTestText.userWithoutPhoto);

        when(
          mockDiscountRepository.getDiscountsByUserId(
            KTestText.profileUser.id,
          ),
        ).thenAnswer(
          (invocation) => Stream.value([]),
        );

        if (GetIt.I.isRegistered<IDiscountRepository>()) {
          GetIt.I.unregister<IDiscountRepository>();
        }
        GetIt.I.registerSingleton<IDiscountRepository>(
          mockDiscountRepository,
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await myDiscountsEmptyPageHelper(tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await myDiscountsPumpAppHelper(
            mockDiscountRepository: mockDiscountRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
          await myDiscountsEmptyPageHelper(tester);
        });
        group(
          '${KGroupText.goTo} ',
          () {
            testWidgets('${KRoute.discountsAdd.name} ', (tester) async {
              await myDiscountsPumpAppHelper(
                mockDiscountRepository: mockDiscountRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
                mockAppAuthenticationRepository:
                    mockAppAuthenticationRepository,
                tester: tester,
                mockGoRouter: mockGoRouter,
              );

              await addButtonDiscountsNavigationHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
              );
            });
          },
        );
      });
    });

    group('${KGroupText.getList} ', () {
      setUp(() {
        when(mockAuthenticationRepository.currentUser)
            .thenAnswer((invocation) => KTestText.userWithoutPhoto);
        when(
          mockDiscountRepository.getDiscountsByUserId(KTestText.profileUser.id),
        ).thenAnswer(
          (invocation) => Stream.value(KTestText.userDiscountModelItemsWidget),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await myDiscountsInitialHelper(tester);
      });

      testWidgets('Delete discount', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockAppAuthenticationRepository: mockAppAuthenticationRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await deleteDiscountHelper(tester);
      });
      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await myDiscountsPumpAppHelper(
            mockDiscountRepository: mockDiscountRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await myDiscountsInitialHelper(tester);
        });

        loadingList(
          (tester) async => myDiscountsPumpAppHelper(
            mockDiscountRepository: mockDiscountRepository,
            mockAppAuthenticationRepository: mockAppAuthenticationRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
          ),
          // lastCard: KWidgetkeys.screen.discounts.cardLast,
        );
        group(
          '${KGroupText.goTo} ',
          () {
            testWidgets('${KRoute.discountsAdd.name} ', (tester) async {
              await myDiscountsPumpAppHelper(
                mockDiscountRepository: mockDiscountRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
                mockAppAuthenticationRepository:
                    mockAppAuthenticationRepository,
                tester: tester,
                mockGoRouter: mockGoRouter,
              );

              await addDiscountsNavigationHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
              );
            });
          },
        );
      });
    });
  });
}
