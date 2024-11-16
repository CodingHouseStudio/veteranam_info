import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.report} ${KGroupText.repository} ', () {
    late IReportRepository reportRepository;
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
        reportRepository =
            ReportRepository(firestoreService: mockFirestoreService);
      });
      test('${KGroupText.successfulSet} ', () async {
        expect(
          await reportRepository.sendReport(KTestText.reportModel),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('${KGroupText.successfulGet} ', () async {
        expect(
          await reportRepository.getCardReportById(
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

        reportRepository =
            ReportRepository(firestoreService: mockFirestoreService);
      });
      test('${KGroupText.failureSend} ', () async {
        expect(
          await reportRepository.sendReport(KTestText.reportModelIncorect),
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
          await reportRepository.getCardReportById(
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

        reportRepository =
            ReportRepository(firestoreService: mockFirestoreService);
      });
      test('${KGroupText.failureSend} ', () async {
        expect(
          await reportRepository.sendReport(
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
          await reportRepository.getCardReportById(
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
