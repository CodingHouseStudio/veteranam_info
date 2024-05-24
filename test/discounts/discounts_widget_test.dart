import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';
import 'discount_widget/discount_filter_helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discounts} ', () {
    late IDiscountRepository mockDiscountRepository;
    late DiscountWatcherBloc discountBloc;
    setUp(() {
      mockDiscountRepository = MockIDiscountRepository();
      when(mockDiscountRepository.getDiscountItems()).thenAnswer(
        (invocation) => Stream.value(KTestText.discountModelItems),
      );
    });
    void registerDiscountBloc() {
      discountBloc = DiscountWatcherBloc(
        discountRepository: mockDiscountRepository,
      );
      if (GetIt.I.isRegistered<DiscountWatcherBloc>()) {
        GetIt.I.unregister<DiscountWatcherBloc>();
      }
      GetIt.I.registerSingleton<DiscountWatcherBloc>(discountBloc);
    }

    testWidgets('${KGroupText.intial} ', (tester) async {
      registerDiscountBloc();
      await tester.pumpApp(const DiscountsScreen());

      expect(
        find.byKey(KWidgetkeys.screen.discounts.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        registerDiscountBloc();
        await tester.pumpApp(
          const DiscountsScreen(),
          mockGoRouter: mockGoRouter,
        );

        expect(
          find.byKey(KWidgetkeys.screen.discounts.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        await scrollingHelper(
          tester: tester,
          offset: KTestConstants.scrollingDown,
        );

        await scrollingHelper(
          tester: tester,
          itemKey: KWidgetkeys.screen.discounts.button,
          offset: KTestConstants.scrollingUp200,
        );

        expect(
          find.byKey(KWidgetkeys.screen.discounts.button),
          findsOneWidget,
        );

        await changeWindowSizeHelper(
          tester: tester,
          test: () async {
            expect(
              find.byKey(KWidgetkeys.screen.discounts.buttonIcon),
              findsOneWidget,
            );

            await changeWindowSizeHelper(
              tester: tester,
              test: () async {
                expect(
                  find.byKey(KWidgetkeys.screen.discounts.buttonMock),
                  findsNothing,
                );

                expect(
                  find.byKey(KWidgetkeys.screen.discounts.card),
                  findsOneWidget,
                );

                await discountFilterHelper(tester);
              },
            );
          },
        );
      });
    });
  });
}
