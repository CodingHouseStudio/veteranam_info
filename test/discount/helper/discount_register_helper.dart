import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

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

  _registerRepository();
}

void _registerRepository() {
  registerSingleton(mockDiscountRepository);
  registerSingleton(mockFirebaseRemoteConfigProvider);
  registerSingleton(mockUrlRepository);
  registerSingleton(mockReportRepository);
  registerSingleton(mockAppAuthenticationRepository);
}
