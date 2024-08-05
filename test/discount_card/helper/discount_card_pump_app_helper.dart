import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> discountCardPumpAppHelper({
  required WidgetTester tester,
  required IDiscountRepository mockDiscountRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerDiscountCardBloc(mockDiscountRepository: mockDiscountRepository);
  await tester.pumpApp(
    DiscountCardDialog(
      id: KTestText.discountModelItems.first.id,
    ),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discountCard.dialog),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerDiscountCardBloc({
  required IDiscountRepository mockDiscountRepository,
}) {
  final discountCardBloc = DiscountCardWatcherBloc(
    discountRepository: mockDiscountRepository,
  );
  if (GetIt.I.isRegistered<DiscountCardWatcherBloc>()) {
    GetIt.I.unregister<DiscountCardWatcherBloc>();
  }
  GetIt.I.registerSingleton<DiscountCardWatcherBloc>(discountCardBloc);
}
