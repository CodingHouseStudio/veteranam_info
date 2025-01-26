import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IDiscountRepository mockDiscountRepository;
late UserRepository mockUserRepository;
late ICompanyRepository mockCompanyRepository;
late AuthenticationRepository mockAuthenticationRepository;
late StreamController<CompanyModel> companyStream;
void myDiscountsWidgetTestRegister() {
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

  _registerRepository();
}

void _registerRepository() {
  registerSingleton(mockDiscountRepository);
  registerSingleton(mockUserRepository);
  registerSingleton(mockCompanyRepository);
  registerSingleton(mockAuthenticationRepository);
}
