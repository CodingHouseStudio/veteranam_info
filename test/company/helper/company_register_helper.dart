import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/company/bloc/company_form_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late UserRepository mockUserRepository;
late IDataPickerRepository mockDataPickerRepository;
late ICompanyRepository mockCompanyRepository;
late IDiscountRepository mockDiscountRepository;
late AuthenticationRepository mockAuthenticationRepository;
late StreamController<CompanyModel> companyStream;
// late XFile image;
void companyWidgetTestRegister() {
  Config.roleValue = Config.business;
  mockUserRepository = MockUserRepository();
  mockDataPickerRepository = MockIDataPickerRepository();
  mockCompanyRepository = MockICompanyRepository();
  mockDiscountRepository = MockIDiscountRepository();
  mockAuthenticationRepository = MockAuthenticationRepository();
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
    mockCompanyRepository.updateCompany(
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

  // when(mockAuthenticationRepository.isAuthenticated).thenAnswer(
  //   (realInvocation) => true,
  // );

  // when(mockUserRepository.isAnonymously).thenAnswer(
  //   (realInvocation) => false,
  // );

  _registerBloc();
}

void _registerBloc() {
  // UserWatcherBloc
  registerFactory<UserWatcherBloc>(
    () => UserWatcherBloc(
      userRepository: mockUserRepository,
    ),
  );

  // CompanyWatcherBloc
  registerFactory<CompanyWatcherBloc>(
    () => CompanyWatcherBloc(
      companyRepository: mockCompanyRepository,
    ),
  );

  // CompanyFormBloc
  registerFactory<CompanyFormBloc>(
    () => CompanyFormBloc(
      companyRepository: mockCompanyRepository,
      dataPickerRepository: mockDataPickerRepository,
      discountRepository: mockDiscountRepository,
    ),
  );

  // AuthenticationBloc
  registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(
      authenticationRepository: mockAuthenticationRepository,
    ),
  );
}
