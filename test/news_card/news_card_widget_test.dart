import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';
import '../test_dependency.dart';

import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.newsCard} ', () {
    late IInformationRepository mockInformationRepository;
    setUp(() {
      mockInformationRepository = MockIInformationRepository();
    });
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(
          mockInformationRepository
              .getInformation(KTestText.informationModelItems.first.id),
        ).thenAnswer(
          (realInvocation) async =>
              Left(SomeFailure.serverError(error: KGroupText.failure)),
        );
      });
      testWidgets('${KGroupText.intial} ', (tester) async {
        await newsCardPumpAppHelper(
          tester: tester,
          mockNewsRepository: mockInformationRepository,
        );

        await newsCardInitialHelper(tester: tester, cardIsEmpty: true);
      });
    });
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(
          mockInformationRepository
              .getInformation(KTestText.informationModelItems.first.id),
        ).thenAnswer(
          (realInvocation) async =>
              Right(KTestText.informationModelItems.first),
        );
      });
      testWidgets('${KGroupText.intial} ', (tester) async {
        await newsCardPumpAppHelper(
          tester: tester,
          mockNewsRepository: mockInformationRepository,
        );

        await newsCardInitialHelper(tester: tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.intial} ', (tester) async {
          await newsCardPumpAppHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
            mockNewsRepository: mockInformationRepository,
          );

          await newsCardInitialHelper(tester: tester);
        });
        group('${KGroupText.goTo} ', () {
          group('${KGroupText.failureGet} ', () {
            setUp(() {
              when(
                mockInformationRepository
                    .getInformation(KTestText.informationModelItems.first.id),
              ).thenAnswer(
                (realInvocation) async =>
                    Left(SomeFailure.notFound(error: KGroupText.failure)),
              );
            });
            testWidgets('Empty Card close', (tester) async {
              await newsCardPumpAppHelper(
                tester: tester,
                mockGoRouter: mockGoRouter,
                mockNewsRepository: mockInformationRepository,
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
              tester: tester,
              mockGoRouter: mockGoRouter,
              mockNewsRepository: mockInformationRepository,
            );

            await cancelHelper(tester: tester, mockGoRouter: mockGoRouter);
          });
        });
      });
    });
  });
}
