import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/app.dart';
// ignore: unused_import
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.app} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    late IHomeRepository mockHomeRepository;
    late IDiscountRepository mockDiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late IReportRepository mockReportRepository;
    setUp(() {
      // KPlatformConstants.testIsWeb = true;
      mockAuthenticationRepository = MockAuthenticationRepository();
      mockDiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      mockHomeRepository = MockIHomeRepository();
      when(mockAuthenticationRepository.userSetting).thenAnswer(
        (realInvocation) => Stream.value(UserSetting.empty),
      );
      when(mockAuthenticationRepository.status).thenAnswer(
        (realInvocation) => Stream.value(AuthenticationStatus.anonymous),
      );
      when(mockAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => User.empty,
      );
      when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
      when(mockHomeRepository.getQuestions()).thenAnswer(
        (invocation) async => Right(KTestText.questionModelItems),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestText.user,
      );

      mockReportRepository = MockIReportRepository();
      when(
        mockReportRepository.getCardReportById(
          cardEnum: CardEnum.discount,
          userId: KTestText.user.id,
        ),
      ).thenAnswer(
        (invocation) async => Right(KTestText.reportItems),
      );

      when(mockDiscountRepository.userCanSendLink(KTestText.user.id))
          .thenAnswer(
        (invocation) async => const Right(true),
      );
      when(
        mockDiscountRepository.getDiscountItems(
          reportIdItems: KTestText.reportItems.getIdCard,
        ),
      ).thenAnswer(
        (invocation) => Stream.value(KTestText.discountModelItemsModify),
      );
    });

    void registerAuthenticationBloc() {
      final authenticationBloc = AuthenticationBloc(
        authenticationRepository: mockAuthenticationRepository,
      );
      if (GetIt.I.isRegistered<AuthenticationBloc>()) {
        GetIt.I.unregister<AuthenticationBloc>();
      }
      GetIt.I.registerSingleton<AuthenticationBloc>(authenticationBloc);
    }

    void registerHomeBloc() {
      final homeBloc = HomeWatcherBloc(homeRepository: mockHomeRepository);
      if (GetIt.I.isRegistered<HomeWatcherBloc>()) {
        GetIt.I.unregister<HomeWatcherBloc>();
      }
      GetIt.I.registerSingleton<HomeWatcherBloc>(homeBloc);
    }

    void registerDiscountLinkCubit() {
      final authenticationBloc = DiscountLinkCubit(
        discountRepository: mockDiscountRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
      if (GetIt.I.isRegistered<DiscountLinkCubit>()) {
        GetIt.I.unregister<DiscountLinkCubit>();
      }
      GetIt.I.registerSingleton<DiscountLinkCubit>(authenticationBloc);
    }

    void registerDiscountBloc() {
      final discountBloc = DiscountWatcherBloc(
        discountRepository: mockDiscountRepository,
        reportRepository: mockReportRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
      if (GetIt.I.isRegistered<DiscountWatcherBloc>()) {
        GetIt.I.unregister<DiscountWatcherBloc>();
      }
      GetIt.I.registerSingleton<DiscountWatcherBloc>(discountBloc);
    }

    testWidgets('${KGroupText.intial} ', (tester) async {
      registerAuthenticationBloc();
      registerHomeBloc();
      registerDiscountBloc();
      registerDiscountLinkCubit();
      await tester.pumpWidget(const App());

      await tester.pumpAndSettle();

      expect(
        find.byKey(KWidgetkeys.screen.app.screen),
        findsOneWidget,
      );
    });
  });
}
