import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discount_card/bloc/discount_card_watcher_bloc.dart';
import 'package:veteranam/components/discount_card/view/diiscount_card_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

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
