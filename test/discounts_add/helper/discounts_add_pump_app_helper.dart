import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discounts_add/bloc/discounts_add_bloc.dart';
import 'package:veteranam/components/discounts_add/view/discounts_add_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> discountsAddPumpAppHelper({
  required IDiscountRepository mockDiscountRepository,
  required ICompanyRepository mockCompanyRepository,
  required ICitiesRepository mockCitiesRepository,
  required WidgetTester tester,
  DiscountModel? discount,
  String? discountId,
  MockGoRouter? mockGoRouter,
}) async {
  _registerDiscountsAddBloc(
    mockDiscountRepository: mockDiscountRepository,
    mockCompanyRepository: mockCompanyRepository,
    mockCitiesRepository: mockCitiesRepository,
  );

  _registerCompanyWatcherBloc(mockCompanyRepository);

  await tester.pumpApp(
    DiscountsAddScreen(
      discount: discount,
      discountId: discountId,
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
