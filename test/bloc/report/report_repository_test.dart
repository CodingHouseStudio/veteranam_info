import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.report} ${KGroupText.repository} ', () {
    late IReportRepository mockReportRepository;
    late FirestoreService mockFirestoreService;
    setUp(() {
      mockFirestoreService = MockFirestoreService();
    });
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(mockFirestoreService.addReport(KTestText.reportModel)).thenAnswer(
          (_) async {},
        );
        when(
          mockFirestoreService.getCardReportByUserId(
            cardEnum: CardEnum.discount,
            userId: KTestText.user.id,
          ),
        ).thenAnswer(
          (_) async => KTestText.reportItems,
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);
        mockReportRepository = ReportRepository();
      });
      test('${KGroupText.successfulSet} ', () async {
        expect(
          await mockReportRepository.sendReport(KTestText.reportModel),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('${KGroupText.successfulGet} ', () async {
        expect(
          await mockReportRepository.getCardReportById(
            cardEnum: CardEnum.discount,
            userId: KTestText.user.id,
          ),
          isA<Right<SomeFailure, List<ReportModel>>>()
              .having((e) => e.value, 'value', KTestText.reportItems),
        );
      });
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockFirestoreService.addReport(KTestText.reportModelIncorect),
        ).thenThrow(Exception(KGroupText.failureSend));
        when(
          mockFirestoreService.getCardReportByUserId(
            cardEnum: CardEnum.discount,
            userId: KTestText.user.id,
          ),
        ).thenThrow(Exception(KGroupText.failureGet));

        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);
        mockReportRepository = ReportRepository();
      });
      test('${KGroupText.failureSend} ', () async {
        expect(
          await mockReportRepository.sendReport(KTestText.reportModelIncorect),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('${KGroupText.failureGet} ', () async {
        expect(
          await mockReportRepository.getCardReportById(
            cardEnum: CardEnum.discount,
            userId: KTestText.user.id,
          ),
          isA<Left<SomeFailure, List<ReportModel>>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
    });
    group('${KGroupText.firebaseFailure} ', () {
      setUp(() {
        when(
          mockFirestoreService.addReport(
            KTestText.reportModelIncorect.copyWith(
              message: KTestText.fieldEmpty,
              reasonComplaint: ReasonComplaint.other,
            ),
          ),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureSend));
        when(
          mockFirestoreService.getCardReportByUserId(
            cardEnum: CardEnum.discount,
            userId: KTestText.user.id,
          ),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureGet));
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);
        mockReportRepository = ReportRepository();
      });
      test('${KGroupText.failureSend} ', () async {
        expect(
          await mockReportRepository.sendReport(
            KTestText.reportModelIncorect.copyWith(
              message: KTestText.fieldEmpty,
              reasonComplaint: ReasonComplaint.other,
            ),
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('${KGroupText.failureGet} ', () async {
        expect(
          await mockReportRepository.getCardReportById(
            cardEnum: CardEnum.discount,
            userId: KTestText.user.id,
          ),
          isA<Left<SomeFailure, List<ReportModel>>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
    });
  });
}
