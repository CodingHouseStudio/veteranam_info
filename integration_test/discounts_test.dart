import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:veteranam/components/discounts/bloc/config/discount_config_cubit.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import 'constants.dart';
import 'helpers/helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // This is run before all tests
  setUpAll(setUpGlobalIntegration);

  tearDownAll(tearDownGlobalItegration);

  testWidgets('Discounts Screeen Email Dialog Test', (tester) async {
    await tester.pumpApp(tester);

    expect(find.byKey(HomeKeys.screen), findsOneWidget);

    expect(find.byKey(HomeKeys.discountsBox), findsOneWidget);

    await tester.tap(find.byKey(HomeKeys.discountsBox));

    await tester.pumpAndSettle();

    expect(find.byKey(DiscountsKeys.screen), findsOneWidget);

    await scrollingHelperInt(
      tester: tester,
      offset: KTestConstants.scrollingDown,
    );

    expect(find.byKey(DiscountsKeys.card), findsWidgets);

    expect(find.byKey(DiscountCardKeys.button), findsWidgets);

    await tester.tap(find.byKey(DiscountCardKeys.button).first);

    await tester.pumpAndSettle();

    expect(find.byKey(DiscountKeys.screen), findsOneWidget);

    expect(find.byKey(DiscountKeys.shareButton), findsOneWidget);

    await tester.tap(find.byKey(DiscountKeys.shareButton));

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(DiscountKeys.backButton));

    await tester.pumpAndSettle();

    expect(find.byKey(DiscountsKeys.screen), findsOneWidget);

    expect(find.byKey(DiscountKeys.screen), findsNothing);

    final firebaseRemoteConfigProvider =
        GetIt.I.get<FirebaseRemoteConfigProvider>();

    for (var i = 0;
        i <
            firebaseRemoteConfigProvider
                .getInt(DiscountConfigCubit.emailScrollKey);
        i++) {
      await scrollingHelperInt(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      if (find.byKey(ScaffoldKeys.loadingButton).evaluate().isNotEmpty) {
        await tester.tap(find.byKey(ScaffoldKeys.loadingButton).first);

        await tester.pumpAndSettle();
      }
    }

    expect(find.byKey(UserEmailDialogKeys.dialog), findsOneWidget);

    expect(find.byKey(UserEmailDialogKeys.field), findsOneWidget);

    await tester.enterText(
      find.byKey(UserEmailDialogKeys.field),
      KTestVariables.userEmail,
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(UserEmailDialogKeys.button));

    await tester.pumpAndSettle();

    expect(find.byKey(UserEmailDialogKeys.dialog), findsNothing);
  });
}
