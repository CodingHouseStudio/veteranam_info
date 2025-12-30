import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';
import '../helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.home} ${KScreenBlocName.dev}', () {
    setUp(homeWidgetTestRegister);
    group('${KGroupText.failure} ', () {
      var someFailure = SomeFailure.serverError;
      setUp(() {
        Config.roleValue = Config.business;
        when(mockFaqRepository.getQuestions()).thenAnswer((invocation) async {
          await KTestConstants.delay;
          return Left(
            someFailure,
          );
        });
      });
      testWidgets('${KGroupText.error} ', (tester) async {
        await homePumpAppHelper(
          tester,
        );

        await homeFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        someFailure = SomeFailure.network;
        await homePumpAppHelper(
          tester,
        );

        await homeFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        when(mockFaqRepository.getQuestions()).thenAnswer((invocation) async {
          await KTestConstants.delay;
          return const Left(SomeFailure.get);
        });
        await homePumpAppHelper(
          tester,
        );

        await homeFailureHelper(tester);
      });
    });
    // group('${KGroupText.getEmptyList} ', () {
    //   setUp(() {
    //     when(mockFaqRepository.getQuestions()).thenAnswer(
    //       (invocation) async => const Right([]),
    //     );
    //     when(mockFaqRepository.addMockQuestions()).thenAnswer(
    //       (invocation) {},
    //     );
    //     if (GetIt.I.isRegistered<IFaqRepository>()) {
    //       GetIt.I.unregister<IFaqRepository>();
    //     }
    //     GetIt.I.registerSingleton<IFaqRepository>(mockFaqRepository);
    //   });
    //   testWidgets('${KGroupText.mockButton} ', (tester) async {
    //     await homePumpAppHelper(
    //       // mockFeedbackRepository: mockFeedbackRepository,
    //       mockFaqRepository: mockFaqRepository,
    //       mockUserRepository: mockUserRepository,
    //       mockBuildRepository: mockBuildRepository, tester: tester,
    //       mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
    //       mockUrlRepository: mockUrlRepository,
    //       mockAuthencticationRepository: mockAuthenticationRepository,
    //       // mockAppAuthenticationRepository:
    //       // mockAppAuthenticationRepository,
    //     );

    //     await homeMockButtonHelper(tester);
    //   });
    // });
    group('${KGroupText.getList} ', () {
      setUp(() {
        Config.roleValue = Config.user;
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (invocation) async => Right(KTestVariables.questionModelItems),
        );

        when(
          mockUserRepository.updateUserSetting(
            userSetting: UserSetting.empty.copyWith(locale: Language.english),
          ),
        ).thenAnswer(
          (invocation) async => const Right(true),
        );
        when(
          mockUserRepository.updateUserSetting(
            userSetting: UserSetting.empty.copyWith(locale: Language.ukraine),
          ),
        ).thenAnswer(
          (invocation) async => const Right(true),
        );
      });

      testWidgets('${KGroupText.initial} ', (tester) async {
        await homePumpAppHelper(
          tester,
        );

        await homeInitialHelper(tester);
      });

      testWidgets('${KGroupText.network} ', (tester) async {
        await networkHelper(
          tester: tester,
          pumpApp: () async => homePumpAppHelper(
            tester,
          ),
        );

        verify(mockFaqRepository.getQuestions()).called(2);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await homePumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await homeInitialHelper(tester);
        });
        testWidgets('Nawbar Menu', (tester) async {
          await homePumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await homeChangeWindowSizeHelper(
            tester: tester,
            isDesk: false,
            isMobile: true,
            test: () async => nawbarMenuHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            ),
          );
        });

        group('${KGroupText.goTo} ', () {
          testWidgets('nawbar widget navigation ${KRoute.profile.name}',
              (tester) async {
            await homePumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
            );

            await homeChangeWindowSizeHelper(
              tester: tester,
              isMobile: true,
              isDesk: false,
              test: () async => nawbarNavigationHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
              ),
            );
          });
          group('${KGroupText.authenticated} ', () {
            setUp(
              () => when(
                mockAuthencticationRepository.currectAuthenticationStatus,
              ).thenAnswer(
                (realInvocation) => AuthenticationStatus.authenticated,
              ),
            );

            testWidgets('${KRoute.profile.name} ', (tester) async {
              await homePumpAppHelper(
                tester,
                mockGoRouter: mockGoRouter,
              );

              await nawbarProfileNavigationHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
              );
            });
            // testWidgets('${KRoute.profile.name} user photo', (tester) async {
            //   when(mockAuthenticationRepository.currentUser).thenAnswer(
            //     (realInvocation) => KTestVariables.user,
            //   );
            //   await provideMockedNetworkImages(() async {
            //     await homePumpAppHelper(
            //       tester: tester,
            //       mockGoRouter: mockGoRouter,
            //       mockAuthenticationRepository: mockAuthenticationRepository,
            //   mockBuildRepository:
            //mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider
            //,  mockBuildRepository,
            //   /mockAuthencticationRepository: mockAuthenticationRepository,
            /// mockFeedbackRepository: mockFeedbackRepository,
            //       mockFaqRepository: mockFaqRepository,
            //       mockAppAuthenticationRepository:
            //           mockAppAuthenticationRepository,
            //     );

            //     await nawbarProfileNavigationHelper(
            //       tester: tester,
            //       mockGoRouter: mockGoRouter,
            //     );
            //   });
            // });
          });
          testWidgets('screen cards rout', (tester) async {
            await homePumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
            );

            await cardsScreenHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });

          testWidgets('box widget navigation', (tester) async {
            await homePumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
            );

            await boxexHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });

          testWidgets('Footer widget navigation', (tester) async {
            await homePumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
            );

            await footerButtonsHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });

          testWidgets('${KRoute.feedback.name} ', (tester) async {
            await homePumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
            );

            await changeWindowSizeHelper(
              tester: tester,
              test: () async => footerFeedbackHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
              ),
            );
          });
          testWidgets('Privacy policy', (tester) async {
            await homePumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
            );

            await footerPrivacyPolicyHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
          group(
            '${KGroupText.authenticated} ',
            () {
              setUp(() {
                when(mockAuthencticationRepository.currectAuthenticationStatus)
                    .thenAnswer(
                  (realInvocation) => AuthenticationStatus.authenticated,
                );
                when(mockUserRepository.user).thenAnswer(
                  (realInvocation) =>
                      Stream.value(KTestVariables.userWithoutPhoto),
                );
              });
              testWidgets('${KRoute.profile.name} ', (tester) async {
                await homePumpAppHelper(
                  tester,
                  mockGoRouter: mockGoRouter,
                );

                await footerProfileHelper(
                  tester: tester,
                  mockGoRouter: mockGoRouter,
                );
              });
            },
          );
        });
      });
    });
  });
}
