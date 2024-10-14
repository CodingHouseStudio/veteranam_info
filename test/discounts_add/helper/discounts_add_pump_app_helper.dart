import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> discountsAddPumpAppHelper({
  required IDiscountRepository mockDiscountRepository,
  required ICompanyRepository mockCompanyRepository,
  required ICitiesRepository mockCitiesRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerDiscountsAddBloc(
    mockDiscountRepository: mockDiscountRepository,
    mockCompanyRepository: mockCompanyRepository,
    mockCitiesRepository: mockCitiesRepository,
  );
  await tester.pumpApp(
    const DiscountsAddScreen(
      discount: null,
      discountId: null,
    ),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerDiscountsAddBloc({
  required IDiscountRepository mockDiscountRepository,
  required ICompanyRepository mockCompanyRepository,
  required ICitiesRepository mockCitiesRepository,
}) {
  final discountsAddBloc = DiscountsAddBloc(
    discountRepository: mockDiscountRepository,
    companyRepository: mockCompanyRepository,
    citiesRepository: mockCitiesRepository,
  );
  if (GetIt.I.isRegistered<DiscountsAddBloc>()) {
    GetIt.I.unregister<DiscountsAddBloc>();
  }
  GetIt.I.registerSingleton<DiscountsAddBloc>(discountsAddBloc);
}
