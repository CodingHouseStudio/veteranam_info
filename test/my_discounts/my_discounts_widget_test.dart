import 'dart:async';

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
  group('${KScreenBlocName.myDiscounts} ', () {
    late IDiscountRepository mockDiscountRepository;
    late AuthenticationRepository mockAuthenticationRepository;
    late ICompanyRepository mockCompanyRepository;
    late StreamController<CompanyModel> companyStream;
    setUp(() {
      Config.roleValue = Config.business;
      mockDiscountRepository = MockIDiscountRepository();
      mockCompanyRepository = MockICompanyRepository();
      mockAuthenticationRepository = MockAuthenticationRepository();
      companyStream = StreamController();

      when(mockAuthenticationRepository.currentUserSetting)
          .thenAnswer((invocation) => KTestText.userSetting);
      for (var i = 0; i < 3; i++) {
        when(
          mockDiscountRepository.deleteDiscountsById(
            KTestText.userDiscountModelItems.elementAt(i).id,
          ),
        ).thenAnswer(
          (invocation) async => const Right(true),
        );
        when(
          mockDiscountRepository.deactivateDiscount(
            discountModel: KTestText.userDiscountModelItems.elementAt(i),
          ),
        ).thenAnswer(
          (invocation) async => const Right(true),
        );
      }
      when(mockCompanyRepository.company).thenAnswer(
        (realInvocation) => companyStream.stream,
      );
    });
    group('${KGroupText.failure} ', () {
      setUp(
        () {
          when(
            mockCompanyRepository.currentUserCompany,
          ).thenAnswer(
            (_) => KTestText.fullCompanyModel,
          );
          companyStream.add(KTestText.fullCompanyModel);

          when(mockAuthenticationRepository.currentUser)
              .thenAnswer((invocation) => KTestText.userWithoutPhoto);
          when(
            mockDiscountRepository
                .getDiscountsByCompanyId(KTestText.fullCompanyModel.id),
          ).thenAnswer(
            (invocation) => Stream.error(KGroupText.failureGet),
          );
        },
      );
      testWidgets('${KGroupText.error} ', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await myDiscountFailureHelper(tester);
      });
    });
    group('Get Small List', () {
      setUp(
        () {
          when(
            mockCompanyRepository.currentUserCompany,
          ).thenAnswer(
            (_) => KTestText.fullCompanyModel,
          );
          companyStream.add(KTestText.fullCompanyModel);

          when(mockAuthenticationRepository.currentUser)
              .thenAnswer((invocation) => KTestText.userWithoutPhoto);
          when(
            mockDiscountRepository
                .getDiscountsByCompanyId(KTestText.fullCompanyModel.id),
          ).thenAnswer(
            (invocation) =>
                Stream.value(KTestText.discountModelItems.sublist(0, 3)),
          );
        },
      );
      testWidgets('End List', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await myDiscountsEndListHelper(tester);
      });
    });

    group('${KGroupText.getEmptyList} with empty profile', () {
      setUp(() {
        when(
          mockCompanyRepository.currentUserCompany,
        ).thenAnswer(
          (_) => KTestText.pureCompanyModel,
        );
        companyStream.add(KTestText.pureCompanyModel);
        when(mockAuthenticationRepository.currentUser)
            .thenAnswer((invocation) => KTestText.userAnonymous);
        when(
          mockDiscountRepository.getDiscountsByCompanyId(
            KTestText.pureCompanyModel.id,
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
          mockCompanyRepository: mockCompanyRepository,
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
            mockCompanyRepository: mockCompanyRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
          await myDiscountsEmptyProfilePageHelper(tester);
        });
        group('${KGroupText.goTo} ', () {
          testWidgets('${KRoute.profile.name} ', (tester) async {
            await myDiscountsPumpAppHelper(
              mockDiscountRepository: mockDiscountRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
              mockCompanyRepository: mockCompanyRepository,
              tester: tester,
              mockGoRouter: mockGoRouter,
            );

            await profileButtonDiscountsNavigationHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
        });
      });
    });

    group('${KGroupText.getEmptyList} ', () {
      setUp(() {
        when(
          mockCompanyRepository.currentUserCompany,
        ).thenAnswer(
          (_) => KTestText.fullCompanyModel,
        );
        companyStream.add(KTestText.fullCompanyModel);
        when(mockAuthenticationRepository.currentUser)
            .thenAnswer((invocation) => KTestText.userWithoutPhoto);

        when(
          mockDiscountRepository.getDiscountsByCompanyId(
            KTestText.fullCompanyModel.id,
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
          mockCompanyRepository: mockCompanyRepository,
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
            mockCompanyRepository: mockCompanyRepository,
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
                mockCompanyRepository: mockCompanyRepository,
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
        when(
          mockCompanyRepository.currentUserCompany,
        ).thenAnswer(
          (_) => KTestText.fullCompanyModel,
        );
        companyStream.add(KTestText.fullCompanyModel);
        when(mockAuthenticationRepository.currentUser)
            .thenAnswer((invocation) => KTestText.userWithoutPhoto);
        when(
          mockDiscountRepository
              .getDiscountsByCompanyId(KTestText.fullCompanyModel.id),
        ).thenAnswer(
          (invocation) => Stream.value(KTestText.userDiscountModelItemsWidget),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await myDiscountsInitialHelper(tester);
      });

      testWidgets('Delete discount', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
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
            mockCompanyRepository: mockCompanyRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await myDiscountsInitialHelper(tester);
        });

        loadingList(
          (tester) async => myDiscountsPumpAppHelper(
            mockDiscountRepository: mockDiscountRepository,
            mockCompanyRepository: mockCompanyRepository,
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
                mockCompanyRepository: mockCompanyRepository,
                tester: tester,
                mockGoRouter: mockGoRouter,
              );

              companyStream.add(
                KTestText.fullCompanyModel.copyWith(id: KTestText.secondId),
              );

              await addDiscountsNavigationHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
              );
            });
            testWidgets('Edit discount ', (tester) async {
              await myDiscountsPumpAppHelper(
                mockDiscountRepository: mockDiscountRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
                mockCompanyRepository: mockCompanyRepository,
                tester: tester,
                mockGoRouter: mockGoRouter,
              );

              await editButtonDiscountsNavigationHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
              );
            });
            // testWidgets('Delete discount dialog confirm button pop',
            //     (tester) async {
            //   await myDiscountsPumpAppHelper(
            //     mockDiscountRepository: mockDiscountRepository,
            //     mockAuthenticationRepository: mockAuthenticationRepository,
            //     mockCompanyRepository: mockCompanyRepository,
            //     tester: tester,
            //     mockGoRouter: mockGoRouter,
            //   );

            //   await myDiscountConfirmButtonlHelper(
            //     tester: tester,
            //     mockGoRouter: mockGoRouter,
            //   );
            // });
            testWidgets('Delete discount dialog confirm button pop(Mob)',
                (tester) async {
              await myDiscountsPumpAppHelper(
                mockDiscountRepository: mockDiscountRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
                mockCompanyRepository: mockCompanyRepository,
                tester: tester,
                mockGoRouter: mockGoRouter,
              );

              await changeWindowSizeHelper(
                tester: tester,
                size: KTestConstants.windowVerySmallSize,
                test: () async => myDiscountConfirmButtonlHelper(
                  tester: tester,
                  mockGoRouter: mockGoRouter,
                ),
              );
            });
            testWidgets('Delete discount desk dialog unconfirm button pop',
                (tester) async {
              await myDiscountsPumpAppHelper(
                mockDiscountRepository: mockDiscountRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
                mockCompanyRepository: mockCompanyRepository,
                tester: tester,
                mockGoRouter: mockGoRouter,
              );
              await myDiscountUnconfirmButtonlHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
                icon: false,
                deskOpen: true,
              );
            });
            testWidgets('Delete discount mob dialog cancel icon pop',
                (tester) async {
              await myDiscountsPumpAppHelper(
                mockDiscountRepository: mockDiscountRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
                mockCompanyRepository: mockCompanyRepository,
                tester: tester,
                mockGoRouter: mockGoRouter,
              );

              await myDiscountUnconfirmButtonlHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
                icon: true,
              );
            });
          },
        );
      });
    });
    tearDown(() async => companyStream.close());
  });
}
