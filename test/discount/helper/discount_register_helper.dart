import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discount/bloc/discount_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IDiscountRepository mockDiscountRepository;
late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
late IUrlRepository mockUrlRepository;
late IReportRepository mockReportRepository;
late IAppAuthenticationRepository mockAppAuthenticationRepository;
void discountWidgetTestRegister() {
  mockDiscountRepository = MockIDiscountRepository();
  mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
  mockUrlRepository = MockIUrlRepository();
  mockReportRepository = MockIReportRepository();
  mockAppAuthenticationRepository = MockIAppAuthenticationRepository();

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

  when(
    mockUrlRepository.share(
      '/discounts/${KTestVariables.id}',
    ),
  ).thenAnswer(
    (realInvocation) async => const Right(true),
  );

  when(
    mockAppAuthenticationRepository.currentUser,
  ).thenAnswer(
    (realInvocation) => KTestVariables.userWithoutPhoto,
  );

  _registerBloc();
}

void _registerBloc() {
  // DiscountWatcherBloc
  registerFactoryParam<DiscountWatcherBloc, DiscountModel?, String?>(
    (discount, discountId) => DiscountWatcherBloc(
      discountRepository: mockDiscountRepository,
      discount: discount,
      discountId: discountId,
      firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
    ),
  );

  // UrlCubit
  registerFactory<UrlCubit>(
    () => UrlCubit(
      urlRepository: mockUrlRepository,
    ),
  );

  // ReportBloc
  registerFactoryParam<ReportBloc, String, CardEnum>(
    (cardId, card) => ReportBloc(
      reportRepository: mockReportRepository,
      appAuthenticationRepository: mockAppAuthenticationRepository,
      cardId: cardId,
      card: card,
    ),
  );
}
