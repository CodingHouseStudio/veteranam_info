import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/my_discounts/bloc/my_discounts_watcher_bloc.dart';
import 'package:veteranam/components/my_discounts/view/my_discounts_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> myDiscountsPumpAppHelper({
  required IDiscountRepository mockDiscountRepository,
  required ICompanyRepository mockCompanyRepository,
  required UserRepository mockUserRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerMyDiscountsBloc(
    mockDiscountRepository: mockDiscountRepository,
    mockCompanyRepository: mockCompanyRepository,
  );

  _registerUserWatcherBloc(
    mockUserRepository: mockUserRepository,
  );

  _registerCompanyWatcherBloc(mockCompanyRepository: mockCompanyRepository);

  await tester.pumpApp(
    const MyDiscountsScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.myDiscounts.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerMyDiscountsBloc({
  required IDiscountRepository mockDiscountRepository,
  required ICompanyRepository mockCompanyRepository,
}) {
  final myDiscountsWatcherBloc = MyDiscountsWatcherBloc(
    discountRepository: mockDiscountRepository,
    companyRepository: mockCompanyRepository,
  );
  if (GetIt.I.isRegistered<MyDiscountsWatcherBloc>()) {
    GetIt.I.unregister<MyDiscountsWatcherBloc>();
  }
  GetIt.I.registerSingleton<MyDiscountsWatcherBloc>(
    myDiscountsWatcherBloc,
  );
}

void _registerUserWatcherBloc({
  required UserRepository mockUserRepository,
}) {
  final userWatcherBloc = UserWatcherBloc(
    userRepository: mockUserRepository,
  );
  if (GetIt.I.isRegistered<UserWatcherBloc>()) {
    GetIt.I.unregister<UserWatcherBloc>();
  }
  GetIt.I.registerSingleton<UserWatcherBloc>(userWatcherBloc);
}

void _registerCompanyWatcherBloc({
  required ICompanyRepository mockCompanyRepository,
}) {
  final companyWatcherBloc = CompanyWatcherBloc(
    companyRepository: mockCompanyRepository,
  );
  if (GetIt.I.isRegistered<CompanyWatcherBloc>()) {
    GetIt.I.unregister<CompanyWatcherBloc>();
  }
  GetIt.I.registerSingleton<CompanyWatcherBloc>(companyWatcherBloc);
}
