import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discount} ', () {
    late IDiscountRepository mockDiscountRepository;
    setUp(() {
      mockDiscountRepository = MockIDiscountRepository();
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(mockDiscountRepository.getDiscountItems()).thenAnswer(
          (invocation) => Stream.error(Exception(KGroupText.failureGet)),
        );
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        await discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
        );

        await loadingFailureHelper(
          tester: tester,
          card: KWidgetkeys.screen.discounts.card,
          buttonMock: KWidgetkeys.screen.discounts.buttonMock,
        );
      });
    });
    group('${KGroupText.getEmptyList} ', () {
      setUp(() {
        when(mockDiscountRepository.getDiscountItems()).thenAnswer(
          (invocation) => Stream.value([]),
        );
        when(mockDiscountRepository.addMockDiscountItems()).thenAnswer(
          (invocation) {},
        );
        if (GetIt.I.isRegistered<IDiscountRepository>()) {
          GetIt.I.unregister<IDiscountRepository>();
        }
        GetIt.I.registerSingleton<IDiscountRepository>(mockDiscountRepository);
      });
      testWidgets('${KGroupText.mockButton} ', (tester) async {
        await discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
        );

        await mockButtonHelper(
          tester: tester,
          card: KWidgetkeys.screen.discounts.card,
          buttonMock: KWidgetkeys.screen.discounts.buttonMock,
        );
      });
    });
    group('${KGroupText.getList} ', () {
      setUp(() {
        when(mockDiscountRepository.getDiscountItems()).thenAnswer(
          (invocation) => Stream.value(KTestText.discountModelItems),
        );
      });
      testWidgets('${KGroupText.intial} ', (tester) async {
        await discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
        );

        await discountInitialHelper(tester);
      });

      loadingListSeparate(
        pumpApp: (tester) async => discountsPumpAppHelper(
          tester: tester,
          mockDiscountRepository: mockDiscountRepository,
        ),
        lastCard: KWidgetkeys.screen.discounts.cardLast,
      );

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.intial} ', (tester) async {
          await discountsPumpAppHelper(
            tester: tester,
            mockDiscountRepository: mockDiscountRepository,
            mockGoRouter: mockGoRouter,
          );

          await discountInitialHelper(tester);
        });
        group('${KGroupText.goTo} ', () {
          testWidgets('nawbar widget navigation', (tester) async {
            await discountsPumpAppHelper(
              tester: tester,
              mockDiscountRepository: mockDiscountRepository,
              mockGoRouter: mockGoRouter,
            );

            await myDIscountHelper(
              tester: tester,
              mockGoRouter: mockGoRouter,
            );
          });
        });
      });
    });
  });
}
