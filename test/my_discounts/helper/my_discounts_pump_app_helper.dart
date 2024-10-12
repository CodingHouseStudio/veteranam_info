import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> myDiscountsPumpAppHelper({
  required IDiscountRepository mockDiscountRepository,
  required ICompanyRepository mockCompanyRepository,
  required AuthenticationRepository mockAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerMyDiscountsBloc(
    mockDiscountRepository: mockDiscountRepository,
    mockCompanyRepository: mockCompanyRepository,
  );

  _registerAuthenticationBloc(
    mockAuthenticationRepository: mockAuthenticationRepository,
  );

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

void _registerAuthenticationBloc({
  required AuthenticationRepository mockAuthenticationRepository,
}) {
  final authenticationBloc = AuthenticationBloc(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<AuthenticationBloc>()) {
    GetIt.I.unregister<AuthenticationBloc>();
  }
  GetIt.I.registerSingleton<AuthenticationBloc>(authenticationBloc);
}
