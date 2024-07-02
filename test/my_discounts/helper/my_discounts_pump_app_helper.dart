import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> myDiscountsPumpAppHelper({
  required IDiscountRepository mockDiscountRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerMyDiscountsBloc(
    mockDiscountRepository: mockDiscountRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
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
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final myDiscountsWatcherBloc = MyDiscountsWatcherBloc(
    discountRepository: mockDiscountRepository,
    iAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<MyDiscountsWatcherBloc>()) {
    GetIt.I.unregister<MyDiscountsWatcherBloc>();
  }
  GetIt.I.registerSingleton<MyDiscountsWatcherBloc>(
    myDiscountsWatcherBloc,
  );
}
