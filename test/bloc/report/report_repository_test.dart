import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  group('${KScreenBlocName.report} ${KGroupText.repository} ', () {
    late IReportRepository mockReportRepository;
    late FirestoreService mockFirestoreService;
    setUp(() {
      mockFirestoreService = MockFirestoreService();
      when(mockFirestoreService.addReport(KTestText.reportModel)).thenAnswer(
        (_) async {},
      );

      when(
        mockFirestoreService.addReport(KTestText.reportModelIncorect),
      ).thenThrow(FirebaseException(plugin: KGroupText.failureSend));
      when(
        mockFirestoreService.addReport(
          KTestText.reportModelIncorect.copyWith(
            message: KTestText.fieldEmpty,
            reasonComplaint: ReasonComplaint.other,
          ),
        ),
      ).thenThrow(FirebaseException(plugin: KGroupText.failureSend));
      if (GetIt.I.isRegistered<FirestoreService>()) {
        GetIt.I.unregister<FirestoreService>();
      }
      GetIt.I.registerSingleton(mockFirestoreService);
      mockReportRepository = ReportRepository();
    });
    test('${KGroupText.successfulSet} Report', () async {
      expect(
        await mockReportRepository.sendReport(KTestText.reportModel),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
    test('${KGroupText.failureSend} Report', () async {
      expect(
        await mockReportRepository.sendReport(KTestText.reportModelIncorect),
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
    test('${KGroupText.failureSend} firebase Report', () async {
      expect(
        await mockReportRepository.sendReport(
          KTestText.reportModelIncorect.copyWith(
            message: KTestText.fieldEmpty,
            reasonComplaint: ReasonComplaint.other,
          ),
        ),
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
  });
}
