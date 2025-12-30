import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/extension/extension_flutter_constants.dart';
import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';
import '../helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.discount} ', () {
    setUp(() {
      PlatformEnumFlutter.isWebDesktop = true;
      discountsWidgetTestRegister();
    });
    group('${KGroupText.failure} ', () {
      late StreamController<List<DiscountModel>> failureStream;
      setUp(() {
        failureStream = StreamController<List<DiscountModel>>()..add([]);
        when(
          mockDiscountRepository.getDiscountItems(
            showOnlyBusinessDiscounts: false,
            // reportIdItems: KTestVariables.reportItems.getIdCard,
          ),
        ).thenAnswer(
          (invocation) => failureStream.stream,
        );
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        await discountsPumpAppHelper(
          tester,
        );

        failureStream.addError(KGroupText.failureGet);
        await tester.pump(const Duration(seconds: 20));
        await failureStream.close();
        failureStream = StreamController<List<DiscountModel>>()..add([]);

        await loadingFailureHelper(
          tester: tester,
          card: DiscountsKeys.card,
          buttonMock: null,
          hasShimmer: true,
        );
      });
    });
    group('${KGroupText.getList} ', () {
      setUp(() {
        when(
          mockDiscountRepository.getDiscountItems(
            showOnlyBusinessDiscounts: false,
            // reportIdItems: KTestVariables.reportItems.getIdCard,
          ),
        ).thenAnswer(
          (invocation) => Stream.value(KTestVariables.discountModelItemsModify),
        );
        when(mockDiscountRepository.sendLink(KTestVariables.linkModel))
            .thenAnswer(
          (invocation) async => const Right(true),
        );
        when(mockDiscountRepository.sendEmail(KTestVariables.emailModel))
            .thenAnswer(
          (invocation) async => const Right(true),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountsPumpAppHelper(
          tester,
        );

        await discountsInitialHelper(tester);
      });

      loadingList(
        (tester) async => discountsPumpAppHelper(
          tester,
        ),
        // lastCard: DiscountsKeys.cardLast,
      );

      testWidgets('${KGroupText.network} ', (tester) async {
        await networkHelper(
          tester: tester,
          pumpApp: () async => discountsPumpAppHelper(
            tester,
          ),
        );

        verify(
          mockDiscountRepository.getDiscountItems(
            showOnlyBusinessDiscounts: false,
          ),
        ).called(1);
      });

      group('Loading Delay', () {
        setUp(() {
          KTest.testLoading = true;
        });
        testWidgets('Loading', (tester) async {
          await discountsPumpAppHelper(
            tester,
          );

          await discountsLoadingHelper(tester);
        });
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await discountsPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await discountsInitialHelper(tester);
        });
      });
    });
  });
}
