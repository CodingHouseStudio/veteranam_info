import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/company/bloc/company_form_bloc.dart';
import 'package:veteranam/components/company/view/company_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> companyPumpAppHelper({
  required WidgetTester tester,
  required UserRepository mockUserRepository,
  required IDataPickerRepository mockDataPickerRepository,
  required ICompanyRepository mockCompanyRepository,
  required IDiscountRepository mockDiscountRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerUserWatcherBloc(mockUserRepository);

  _registerCompanyWatcherBloc(
    mockCompanyRepository,
  );

  _registerCompanyFormBloc(
    mockCompanyRepository: mockCompanyRepository,
    mockDataPickerRepository: mockDataPickerRepository,
    mockDiscountRepository: mockDiscountRepository,
  );

  await tester.pumpApp(const CompanyScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.company.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerUserWatcherBloc(
  UserRepository mockUserRepository,
) {
  final userWatcherBloc = UserWatcherBloc(
    userRepository: mockUserRepository,
  );
  if (GetIt.I.isRegistered<UserWatcherBloc>()) {
    GetIt.I.unregister<UserWatcherBloc>();
  }
  GetIt.I.registerSingleton<UserWatcherBloc>(userWatcherBloc);
}

void _registerCompanyWatcherBloc(
  ICompanyRepository mockCompanyRepository,
) {
  final companyWatcherBloc = CompanyWatcherBloc(
    companyRepository: mockCompanyRepository,
  );
  if (GetIt.I.isRegistered<CompanyWatcherBloc>()) {
    GetIt.I.unregister<CompanyWatcherBloc>();
  }
  GetIt.I.registerSingleton<CompanyWatcherBloc>(companyWatcherBloc);
}

void _registerCompanyFormBloc({
  required ICompanyRepository mockCompanyRepository,
  required IDataPickerRepository mockDataPickerRepository,
  required IDiscountRepository mockDiscountRepository,
}) {
  final companyFormBloc = CompanyFormBloc(
    companyRepository: mockCompanyRepository,
    dataPickerRepository: mockDataPickerRepository,
    discountRepository: mockDiscountRepository,
  );
  if (GetIt.I.isRegistered<CompanyFormBloc>()) {
    GetIt.I.unregister<CompanyFormBloc>();
  }
  GetIt.I.registerSingleton<CompanyFormBloc>(companyFormBloc);
}
