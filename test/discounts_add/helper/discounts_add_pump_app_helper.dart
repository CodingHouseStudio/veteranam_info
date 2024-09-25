import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> discountsAddPumpAppHelper({
  required IDiscountRepository mockDiscountRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerDiscountsAddBloc(
    mockDiscountRepository: mockDiscountRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  await tester.pumpApp(
    const DiscountsAddScreen(),
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
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final discountsAddBloc = DiscountsAddBloc(
    discountRepository: mockDiscountRepository,
    appAuthenticationBloc: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<DiscountsAddBloc>()) {
    GetIt.I.unregister<DiscountsAddBloc>();
  }
  GetIt.I.registerSingleton<DiscountsAddBloc>(discountsAddBloc);
}
