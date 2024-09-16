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
  group('${KScreenBlocName.home} ${KScreenBlocName.dev}', () {
    late AuthenticationRepository mockAuthenticationRepository;
    late IFaqRepository mockFaqRepository;
    late IUrlRepository mockUrlRepository;
    late AppInfoRepository mockBuildRepository;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
    // late IFeedbackRepository mockFeedbackRepository;
    // late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestText.dateTime;
      ExtendedDateTime.id = KTestText.feedbackModel.id;
      KPlatformConstants.isWebDesktop = true;
      mockFaqRepository = MockIFaqRepository();
      mockAuthenticationRepository = MockAuthenticationRepository();
      mockUrlRepository = MockIUrlRepository();
      mockBuildRepository = MockAppInfoRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      // mockAppAuthenticationRepository = MockAppAuthenticationRepository();

      when(mockAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => User.empty,
      );
      when(mockUrlRepository.copy(KAppText.email)).thenAnswer(
        (invocation) async => const Right(true),
      );
      when(mockBuildRepository.getBuildInfo()).thenAnswer(
        (invocation) async => AppInfoRepository.defaultValue,
      );
      // when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
      //   (realInvocation) => UserSetting.empty,
      // );
      // when(mockAppAuthenticationRepository.currentUser).thenAnswer(
      //   (realInvocation) => KTestText.user,
      // );
      when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      when(mockAuthenticationRepository.isAnonymouslyOrEmty()).thenAnswer(
        (realInvocation) => true,
      );
      when(
        mockUrlRepository.launchUrl(
          url: KAppText.instagram,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(
          true,
        ),
      );
      when(
        mockUrlRepository.launchUrl(
          url: KAppText.facebook,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(
          true,
        ),
      );
      when(
        mockUrlRepository.launchUrl(
          url: KAppText.linkedIn,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(
          true,
        ),
      );
      when(
        mockFirebaseRemoteConfigProvider
            .getString(AppVersionCubit.mobAppVersionKey),
      ).thenAnswer(
        (_) => KTestText.build,
      );
      // mockFeedbackRepository = MockIFeedbackRepository();
      // when(mockFeedbackRepository.sendFeedback(KTestText.feedbackModel))
      //     .thenAnswer(
      //   (invocation) async => const Right(true),
      // );
      // when(
      //   mockFeedbackRepository.checkUserNeedShowFeedback(KTestText.user.id),
      // ).thenAnswer(
      //   (invocation) async => const Right(true),
      // );
    });
    group('${KGroupText.failure} ', () {
      testWidgets('${KGroupText.error} ', (tester) async {
        Config.roleValue = Config.business;
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (invocation) async => Left(
            SomeFailure.serverError(
              error: null,
            ),
          ),
        );
        await homePumpAppHelper(
          // mockFeedbackRepository: mockFeedbackRepository,
          mockFaqRepository: mockFaqRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockBuildRepository: mockBuildRepository, tester: tester,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockUrlRepository: mockUrlRepository,
          // mockAppAuthenticationRepository:
          // mockAppAuthenticationRepository,
        );

        await homeFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureNetwork} ', (tester) async {
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (invocation) async => Left(SomeFailure.network(error: null)),
        );
        await homePumpAppHelper(
          // mockFeedbackRepository: mockFeedbackRepository,
          mockFaqRepository: mockFaqRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockBuildRepository: mockBuildRepository, tester: tester,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockUrlRepository: mockUrlRepository,
          // mockAppAuthenticationRepository:
          // mockAppAuthenticationRepository,
        );

        await homeFailureHelper(tester);
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (invocation) async => Left(SomeFailure.get(error: null)),
        );
        await homePumpAppHelper(
          // mockFeedbackRepository: mockFeedbackRepository,
          mockFaqRepository: mockFaqRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockBuildRepository: mockBuildRepository, tester: tester,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockUrlRepository: mockUrlRepository,
          // mockAppAuthenticationRepository:
          // mockAppAuthenticationRepository,
        );

        await homeFailureHelper(tester);
      });
    });
    group('${KGroupText.getEmptyList} ', () {
      setUp(() {
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (invocation) async => const Right([]),
        );
        when(mockFaqRepository.addMockQuestions()).thenAnswer(
          (invocation) {},
        );
        if (GetIt.I.isRegistered<IFaqRepository>()) {
          GetIt.I.unregister<IFaqRepository>();
        }
        GetIt.I.registerSingleton<IFaqRepository>(mockFaqRepository);
      });
      testWidgets('${KGroupText.mockButton} ', (tester) async {
        await homePumpAppHelper(
          // mockFeedbackRepository: mockFeedbackRepository,
          mockFaqRepository: mockFaqRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockBuildRepository: mockBuildRepository, tester: tester,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockUrlRepository: mockUrlRepository,
          // mockAppAuthenticationRepository:
          // mockAppAuthenticationRepository,
        );

        await homeMockButtonHelper(tester);
      });
    });
    group('${KGroupText.getList} ', () {
      setUp(() {
        Config.roleValue = Config.user;
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (invocation) async => Right(KTestText.questionModelItems),
        );
      });

      testWidgets('${KGroupText.intial} ', (tester) async {
        await homePumpAppHelper(
          // mockFeedbackRepository: mockFeedbackRepository,
          mockFaqRepository: mockFaqRepository,
          mockAuthenticationRepository: mockAuthenticationRepository,
          mockBuildRepository: mockBuildRepository, tester: tester,
          mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          mockUrlRepository: mockUrlRepository,
          // mockAppAuthenticationRepository:
          // mockAppAuthenticationRepository,
        );

        await homeInitialHelper(tester);
      });

      testWidgets('${KGroupText.network} ', (tester) async {
        await networkHelper(
          tester: tester,
          pumpApp: () async => homePumpAppHelper(
            mockFaqRepository: mockFaqRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            tester: tester,
            mockBuildRepository: mockBuildRepository,
            mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
            mockUrlRepository: mockUrlRepository,
          ),
        );

        verify(mockFaqRepository.getQuestions()).called(2);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.intial} ', (tester) async {
          await homePumpAppHelper(
            // mockFeedbackRepository: mockFeedbackRepository,
            mockFaqRepository: mockFaqRepository,
            mockAuthenticationRepository: mockAuthenticationRepository,
            mockBuildRepository: mockBuildRepository, tester: tester,
            mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
            mockGoRouter: mockGoRouter,
            mockUrlRepository: mockUrlRepository,
            // mockAppAuthenticationRepository:
            // mockAppAuthenticationRepository,
          );

          await homeInitialHelper(tester);
        });
        testWidgets('Nawbar Menu', (tester) async {
          await homePumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockAuthenticationRepository: mockAuthenticationRepository,
            mockBuildRepository: mockBuildRepository,
            mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
            // mockFeedbackRepository: mockFeedbackRepository,
            mockFaqRepository: mockFaqRepository,
            mockUrlRepository: mockUrlRepository,
            // mockAppAuthenticationRepository:
            // mockAppAuthenticationRepository,
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
              // mockFeedbackRepository: mockFeedbackRepository,
              mockFaqRepository: mockFaqRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
              mockBuildRepository: mockBuildRepository, tester: tester,
              mockFirebaseRemoteConfigProvider:
                  mockFirebaseRemoteConfigProvider,
              mockGoRouter: mockGoRouter,
              mockUrlRepository: mockUrlRepository,
              // mockAppAuthenticationRepository:
              // mockAppAuthenticationRepository,
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
          group("user isn't anonymously", () {
            setUp(
              () => when(mockAuthenticationRepository.isAnonymouslyOrEmty())
                  .thenAnswer(
                (realInvocation) => false,
              ),
            );
            testWidgets('${KRoute.profile.name} ', (tester) async {
              await homePumpAppHelper(
                // mockFeedbackRepository: mockFeedbackRepository,
                mockFaqRepository: mockFaqRepository,
                mockAuthenticationRepository: mockAuthenticationRepository,
                mockBuildRepository: mockBuildRepository, tester: tester,
                mockFirebaseRemoteConfigProvider:
                    mockFirebaseRemoteConfigProvider,
                mockGoRouter: mockGoRouter,
                mockUrlRepository: mockUrlRepository,
                // mockAppAuthenticationRepository:
                // mockAppAuthenticationRepository,
              );

              await nawbarProfileNavigationHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
              );
            });
            // testWidgets('${KRoute.profile.name} user photo', (tester) async {
            //   when(mockAuthenticationRepository.currentUser).thenAnswer(
            //     (realInvocation) => KTestText.user,
            //   );
            //   await provideMockedNetworkImages(() async {
            //     await homePumpAppHelper(
            //       tester: tester,
            //       mockGoRouter: mockGoRouter,
            //       mockAuthenticationRepository: mockAuthenticationRepository,
            //   mockBuildRepository:
            //mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider
            //,  mockBuildRepository,
            //   // mockFeedbackRepository: mockFeedbackRepository,
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
              // mockFeedbackRepository: mockFeedbackRepository,
              mockFaqRepository: mockFaqRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
              mockBuildRepository: mockBuildRepository, tester: tester,
              mockFirebaseRemoteConfigProvider:
                  mockFirebaseRemoteConfigProvider,
              mockGoRouter: mockGoRouter,
              mockUrlRepository: mockUrlRepository,
              // mockAppAuthenticationRepository:
              // mockAppAuthenticationRepository,
            );

            await cardsScreenHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });

          testWidgets('box widget navigation', (tester) async {
            await homePumpAppHelper(
              // mockFeedbackRepository: mockFeedbackRepository,
              mockFaqRepository: mockFaqRepository,
              mockAuthenticationRepository: mockAuthenticationRepository,
              mockBuildRepository: mockBuildRepository, tester: tester,
              mockFirebaseRemoteConfigProvider:
                  mockFirebaseRemoteConfigProvider,
              mockGoRouter: mockGoRouter,
              mockUrlRepository: mockUrlRepository,
              // mockAppAuthenticationRepository:
              // mockAppAuthenticationRepository,
            );

            await boxexHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });

          testWidgets('Footer widget navigation', (tester) async {
            await homePumpAppHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
              mockAuthenticationRepository: mockAuthenticationRepository,
              mockBuildRepository: mockBuildRepository,
              mockFirebaseRemoteConfigProvider:
                  mockFirebaseRemoteConfigProvider,
              // mockFeedbackRepository: mockFeedbackRepository,
              mockFaqRepository: mockFaqRepository,
              mockUrlRepository: mockUrlRepository,
              // mockAppAuthenticationRepository:
              // mockAppAuthenticationRepository,
            );

            await footerButtonsHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });

          testWidgets('${KRoute.feedback.name} ', (tester) async {
            await homePumpAppHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
              mockAuthenticationRepository: mockAuthenticationRepository,
              mockBuildRepository: mockBuildRepository,
              mockFirebaseRemoteConfigProvider:
                  mockFirebaseRemoteConfigProvider,
              // mockFeedbackRepository: mockFeedbackRepository,
              mockFaqRepository: mockFaqRepository,
              mockUrlRepository: mockUrlRepository,
              // mockAppAuthenticationRepository:
              // mockAppAuthenticationRepository,
            );

            await footerFeedbackHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
          testWidgets('Privacy policy', (tester) async {
            await homePumpAppHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
              mockAuthenticationRepository: mockAuthenticationRepository,
              mockBuildRepository: mockBuildRepository,
              mockFirebaseRemoteConfigProvider:
                  mockFirebaseRemoteConfigProvider,
              // mockFeedbackRepository: mockFeedbackRepository,
              mockFaqRepository: mockFaqRepository,
              mockUrlRepository: mockUrlRepository,
              // mockAppAuthenticationRepository:
              // mockAppAuthenticationRepository,
            );

            await footerPrivacyPolicyHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
          group(
            'User authentication',
            () {
              setUp(
                () => when(mockAuthenticationRepository.status).thenAnswer(
                  (realInvocation) =>
                      Stream.value(AuthenticationStatus.authenticated),
                ),
              );
              testWidgets('${KRoute.profile.name} ', (tester) async {
                await homePumpAppHelper(
                  tester: tester,
                  mockGoRouter: mockGoRouter,
                  mockAuthenticationRepository: mockAuthenticationRepository,
                  mockBuildRepository: mockBuildRepository,
                  mockFirebaseRemoteConfigProvider:
                      mockFirebaseRemoteConfigProvider,
                  mockFaqRepository: mockFaqRepository,
                  mockUrlRepository: mockUrlRepository,
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
