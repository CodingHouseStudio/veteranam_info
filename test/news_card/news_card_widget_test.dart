import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/shared/shared_dart.dart';
import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.newsCard} ', () {
    setUp(newsCardTestWidgetRegister);
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(
          mockInformationRepository
              .getInformation(KTestVariables.informationModelItems.first.id),
        ).thenAnswer(
          (realInvocation) async => const Left(SomeFailure.serverError),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await newsCardPumpAppHelper(
          tester,
        );

        await newsCardInitialHelper(tester: tester, cardIsEmpty: true);
      });
    });
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(
          mockInformationRepository
              .getInformation(KTestVariables.informationModelItems.first.id),
        ).thenAnswer(
          (realInvocation) async =>
              Right(KTestVariables.informationModelItems.first),
        );
      });
      testWidgets('${KGroupText.initial} ', (tester) async {
        await newsCardPumpAppHelper(
          tester,
        );

        await newsCardInitialHelper(tester: tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await newsCardPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await newsCardInitialHelper(tester: tester);
        });
        group('${KGroupText.goTo} ', () {
          group('${KGroupText.failureGet} ', () {
            setUp(() {
              when(
                mockInformationRepository.getInformation(
                  KTestVariables.informationModelItems.first.id,
                ),
              ).thenAnswer(
                (realInvocation) async => const Left(SomeFailure.dataNotFound),
              );
            });
            testWidgets('Empty Card close', (tester) async {
              await newsCardPumpAppHelper(
                tester,
                mockGoRouter: mockGoRouter,
              );

              await cardEmptyCloseHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
                routeName: KRoute.information.name,
              );
            });
          });
          testWidgets('${KRoute.information.name} ', (tester) async {
            await newsCardPumpAppHelper(
              tester,
              mockGoRouter: mockGoRouter,
            );

            await cancelHelper(tester: tester, mockGoRouter: mockGoRouter);
          });
        });
      });
    });
  });
}
