import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/bloc/subscription_checkout/subscription_checkout_cubit.dart';
import 'package:veteranam/shared/services/subscription_service.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late UserRepository mockUserRepository;
late IDataPickerRepository mockDataPickerRepository;
late ICompanyRepository mockCompanyRepository;
late IDiscountRepository mockDiscountRepository;
late AuthenticationRepository mockAuthenticationRepository;
late SubscriptionCheckoutCubit mockSubscriptionCheckoutCubit;
late SubscriptionService mockSubscriptionService;
late StreamController<CompanyModel> companyStream;
// late XFile image;
void companyWidgetTestRegister() {
  Config.roleValue = Config.business;
  mockUserRepository = MockUserRepository();
  mockDataPickerRepository = MockIDataPickerRepository();
  mockCompanyRepository = MockICompanyRepository();
  mockDiscountRepository = MockIDiscountRepository();
  mockAuthenticationRepository = MockAuthenticationRepository();
  mockSubscriptionCheckoutCubit = MockSubscriptionCheckoutCubit();
  mockSubscriptionService = MockSubscriptionService();
  companyStream = StreamController()..add(KTestVariables.pureCompanyModel);
  // image = XFile(KTestVariables.imageModels.downloadURL);
  // mockAuthenticationRepository = MockAuthenticationRepository();

  when(mockUserRepository.currentUser).thenAnswer(
    (realInvocation) => KTestVariables.userWithoutPhoto,
  );
  when(mockUserRepository.currentUserSetting).thenAnswer(
    (realInvocation) => KTestVariables.userSettingModel,
  );

  when(mockCompanyRepository.currentUserCompany).thenAnswer(
    (realInvocation) => KTestVariables.pureCompanyModel,
  );
  when(mockCompanyRepository.company).thenAnswer(
    (realInvocation) => companyStream.stream,
  );
  when(
    mockCompanyRepository.createUpdateCompany(
      company: KTestVariables.fullCompanyModel,
      imageItem: KTestVariables.filePickerItem,
    ),
  ).thenAnswer(
    (realInvocation) async => const Right(true),
  );
  when(
    mockCompanyRepository.deleteCompany(),
  ).thenAnswer(
    (realInvocation) async => const Right(true),
  );
  when(
    mockDiscountRepository
        .companyHasDiscount(KTestVariables.pureCompanyModel.id),
  ).thenAnswer(
    (realInvocation) async => false,
  );

  // when(imagePickerValue.pickImage(source: ImageSource.gallery)).
  // thenAnswer(
  //   (realInvocation) async => image,
  // );

  when(
    mockDataPickerRepository.getImage,
  ).thenAnswer(
    (realInvocation) async => KTestVariables.filePickerItem,
  );

  when(mockAuthenticationRepository.status).thenAnswer(
    (realInvocation) => Stream.value(AuthenticationStatus.authenticated),
  );
  when(mockAuthenticationRepository.currectAuthenticationStatus).thenAnswer(
    (realInvocation) => AuthenticationStatus.authenticated,
  );
  when(mockAuthenticationRepository.logOut()).thenAnswer(
    (realInvocation) async => const Right(true),
  );
  when(mockAuthenticationRepository.deleteUser()).thenAnswer(
    (realInvocation) async => const Right(true),
  );

  when(mockSubscriptionCheckoutCubit.state).thenAnswer(
    (realInvocation) => const SubscriptionCheckoutState(
      status: SubscriptionCheckoutStatus.initial,
    ),
  );

  // when(mockAuthenticationRepository.isAuthenticated).thenAnswer(
  //   (realInvocation) => true,
  // );

  // when(mockUserRepository.isAnonymously).thenAnswer(
  //   (realInvocation) => false,
  // );

  _registerRepository();
}

void _registerRepository() {
  registerSingleton(mockUserRepository);
  registerSingleton(mockDataPickerRepository);
  registerSingleton(mockCompanyRepository);
  registerSingleton(mockDiscountRepository);
  registerSingleton(mockAuthenticationRepository);
  registerSingleton(mockSubscriptionCheckoutCubit);
  registerSingleton(mockSubscriptionService);
}
