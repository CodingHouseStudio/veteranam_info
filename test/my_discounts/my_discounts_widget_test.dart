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
    late UserRepository mockUserRepository;
    late ICompanyRepository mockCompanyRepository;
    late AuthenticationRepository mockAuthenticationRepository;
    late StreamController<CompanyModel> companyStream;
    setUp(() {
      Config.roleValue = Config.business;
      mockDiscountRepository = MockIDiscountRepository();
      mockCompanyRepository = MockICompanyRepository();
      mockUserRepository = MockUserRepository();
      mockAuthenticationRepository = MockAuthenticationRepository();

      companyStream = StreamController();

      when(mockUserRepository.currentUserSetting)
          .thenAnswer((invocation) => KTestVariables.userSetting);
      for (var i = 0; i < 3; i++) {
        when(
          mockDiscountRepository.deleteDiscountsById(
            KTestVariables.userDiscountModelItems.elementAt(i).id,
          ),
        ).thenAnswer(
          (invocation) async => const Right(true),
        );
        when(
          mockDiscountRepository.deactivateDiscount(
            discountModel: KTestVariables.userDiscountModelItems.elementAt(i),
          ),
        ).thenAnswer(
          (invocation) async => const Right(true),
        );
      }
      when(mockCompanyRepository.company).thenAnswer(
        (realInvocation) => companyStream.stream,
      );
      when(mockAuthenticationRepository.currectAuthenticationStatus).thenAnswer(
        (realInvocation) => AuthenticationStatus.authenticated,
      );
    });
    group('${KGroupText.failure} ', () {
      late StreamController<List<DiscountModel>> failureStream;
      setUp(
        () {
          failureStream = StreamController<List<DiscountModel>>()..add([]);
          when(
            mockCompanyRepository.currentUserCompany,
          ).thenAnswer(
            (_) => KTestVariables.fullCompanyModel,
          );
          companyStream.add(KTestVariables.fullCompanyModel);

          when(mockUserRepository.currentUser)
              .thenAnswer((invocation) => KTestVariables.userWithoutPhoto);
          when(
            mockDiscountRepository
                .getDiscountsByCompanyId(KTestVariables.fullCompanyModel.id),
          ).thenAnswer(
            (invocation) => failureStream.stream,
          );
        },
      );

      testWidgets('${KGroupText.error} ', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
          mockUserRepository: mockUserRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        failureStream.addError(KGroupText.failureGet);
        await tester.pump(const Duration(seconds: 20));
        await failureStream.close();
        failureStream = StreamController<List<DiscountModel>>()..add([]);

        await myDiscountFailureHelper(tester);
      });
      // tearDown(
      //   () async => failureStream.close(),
      // );
    });
    group('Get Small List', () {
      setUp(
        () {
          when(
            mockCompanyRepository.currentUserCompany,
          ).thenAnswer(
            (_) => KTestVariables.fullCompanyModel,
          );
          companyStream.add(KTestVariables.fullCompanyModel);

          when(mockUserRepository.currentUser)
              .thenAnswer((invocation) => KTestVariables.userWithoutPhoto);
          when(
            mockDiscountRepository
                .getDiscountsByCompanyId(KTestVariables.fullCompanyModel.id),
          ).thenAnswer(
            (invocation) =>
                Stream.value(KTestVariables.discountModelItems.sublist(0, 3)),
          );
        },
      );
      testWidgets('End List', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
          mockUserRepository: mockUserRepository,
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
          (_) => KTestVariables.pureCompanyModel,
        );
        companyStream.add(KTestVariables.pureCompanyModel);
        when(mockUserRepository.currentUser)
            .thenAnswer((invocation) => KTestVariables.userAnonymous);
        when(
          mockDiscountRepository.getDiscountsByCompanyId(
            KTestVariables.pureCompanyModel.id,
          ),
        ).thenAnswer(
          (invocation) => Stream.value(KTestVariables.discountModelItems),
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
          mockUserRepository: mockUserRepository,
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
            mockUserRepository: mockUserRepository,
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
              mockUserRepository: mockUserRepository,
              mockCompanyRepository: mockCompanyRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
              tester: tester,
              mockGoRouter: mockGoRouter,
            );

            await profileButtonDiscountsNavigationHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });

          testWidgets('${KRoute.company.name} ', (tester) async {
            await myDiscountsPumpAppHelper(
              mockDiscountRepository: mockDiscountRepository,
              mockUserRepository: mockUserRepository,
              mockCompanyRepository: mockCompanyRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
              tester: tester,
              mockGoRouter: mockGoRouter,
            );

            await nawbarBusinessProfileNavigationHelper(
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
          (_) => KTestVariables.fullCompanyModel,
        );
        companyStream.add(KTestVariables.fullCompanyModel);
        when(mockUserRepository.currentUser)
            .thenAnswer((invocation) => KTestVariables.userWithoutPhoto);

        when(
          mockDiscountRepository.getDiscountsByCompanyId(
            KTestVariables.fullCompanyModel.id,
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
          mockUserRepository: mockUserRepository,
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
            mockUserRepository: mockUserRepository,
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
                mockUserRepository: mockUserRepository,
                mockCompanyRepository: mockCompanyRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
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
          (_) => KTestVariables.fullCompanyModel,
        );
        companyStream.add(KTestVariables.fullCompanyModel);
        when(mockUserRepository.currentUser)
            .thenAnswer((invocation) => KTestVariables.userWithoutPhoto);
        when(
          mockDiscountRepository
              .getDiscountsByCompanyId(KTestVariables.fullCompanyModel.id),
        ).thenAnswer(
          (invocation) =>
              Stream.value(KTestVariables.userDiscountModelItemsWidget),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
          mockUserRepository: mockUserRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          tester: tester,
        );

        await myDiscountsInitialHelper(tester);
      });

      testWidgets('Delete discount', (tester) async {
        await myDiscountsPumpAppHelper(
          mockDiscountRepository: mockDiscountRepository,
          mockCompanyRepository: mockCompanyRepository,
          mockUserRepository: mockUserRepository,
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
            mockUserRepository: mockUserRepository,
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
            mockUserRepository: mockUserRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
          ),
          // lastCard: DiscountsKeys.cardLast,
        );
        group(
          '${KGroupText.goTo} ',
          () {
            testWidgets('${KRoute.discountsAdd.name} ', (tester) async {
              await myDiscountsPumpAppHelper(
                mockDiscountRepository: mockDiscountRepository,
                mockUserRepository: mockUserRepository,
                mockCompanyRepository: mockCompanyRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
                tester: tester,
                mockGoRouter: mockGoRouter,
              );

              companyStream.add(
                KTestVariables.fullCompanyModel
                    .copyWith(id: KTestVariables.secondId),
              );

              await addDiscountsNavigationHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
              );
            });
            testWidgets('Edit discount ', (tester) async {
              await myDiscountsPumpAppHelper(
                mockDiscountRepository: mockDiscountRepository,
                mockUserRepository: mockUserRepository,
                mockCompanyRepository: mockCompanyRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
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
                mockUserRepository: mockUserRepository,
                mockCompanyRepository: mockCompanyRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
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
                mockUserRepository: mockUserRepository,
                mockCompanyRepository: mockCompanyRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
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
                mockUserRepository: mockUserRepository,
                mockCompanyRepository: mockCompanyRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
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
