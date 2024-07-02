import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> discountsPumpAppHelper({
  required WidgetTester tester,
  required IDiscountRepository mockDiscountRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerDiscountBloc(mockDiscountRepository: mockDiscountRepository);
  await tester.pumpApp(const DiscountsScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.discounts.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerDiscountBloc({
  required IDiscountRepository mockDiscountRepository,
}) {
  final discountBloc = DiscountWatcherBloc(
    discountRepository: mockDiscountRepository,
  );
  if (GetIt.I.isRegistered<DiscountWatcherBloc>()) {
    GetIt.I.unregister<DiscountWatcherBloc>();
  }
  GetIt.I.registerSingleton<DiscountWatcherBloc>(discountBloc);
}
