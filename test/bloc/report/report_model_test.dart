import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.report} ${KGroupText.model} ', () {
    final fullJson = {
      ReportModelJsonField.id: KTestVariables.reportModel.id,
      ReportModelJsonField.email: KTestVariables.reportModel.email,
      ReportModelJsonField.message: KTestVariables.reportModel.message,
      ReportModelJsonField.date:
          KTestVariables.reportModel.date.toIso8601String(),
      ReportModelJsonField.card: KTestVariables.reportModel.card.getValue,
      ReportModelJsonField.reasonComplaint:
          _$ReasonComplaintEnumMap[KTestVariables.reportModel.reasonComplaint],
      ReportModelJsonField.cardId: KTestVariables.reportModel.cardId,
      ReportModelJsonField.userId: KTestVariables.reportModel.userId,
      ReportModelJsonField.status:
          _$ReportStatusEnumMap[KTestVariables.reportModel.status],
    };
    final nullableJson = {
      ReportModelJsonField.id: KTestVariables.reportModel.id,
      ReportModelJsonField.email: null,
      ReportModelJsonField.message: null,
      ReportModelJsonField.date:
          KTestVariables.reportModel.date.toIso8601String(),
      ReportModelJsonField.card: KTestVariables.reportModel.card.getValue,
      ReportModelJsonField.reasonComplaint:
          _$ReasonComplaintEnumMap[KTestVariables.reportModel.reasonComplaint],
      ReportModelJsonField.cardId: KTestVariables.reportModel.cardId,
      ReportModelJsonField.userId: KTestVariables.reportModel.userId,
      ReportModelJsonField.status: _$ReportStatusEnumMap[ReportStatus.isNew],
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final reportModel = ReportModel.fromJson(fullJson);

        expect(reportModel.id, KTestVariables.reportModel.id);
        expect(reportModel.email, KTestVariables.reportModel.email);
        expect(reportModel.date, KTestVariables.reportModel.date);
        expect(reportModel.card, KTestVariables.reportModel.card);
        expect(reportModel.message, KTestVariables.reportModel.message);
        expect(
          reportModel.reasonComplaint,
          KTestVariables.reportModel.reasonComplaint,
        );
        expect(reportModel.userId, KTestVariables.reportModel.userId);
        expect(reportModel.cardId, KTestVariables.reportModel.cardId);
        expect(reportModel.status, KTestVariables.reportModel.status);
      });
      test('${KGroupText.nullable} ', () {
        final reportModel = ReportModel.fromJson(nullableJson);

        expect(reportModel.id, KTestVariables.reportModel.id);
        expect(reportModel.email, null);
        expect(reportModel.date, KTestVariables.reportModel.date);
        expect(reportModel.card, KTestVariables.reportModel.card);
        expect(reportModel.message, null);
        expect(
          reportModel.reasonComplaint,
          KTestVariables.reportModel.reasonComplaint,
        );
        expect(reportModel.userId, KTestVariables.reportModel.userId);
        expect(reportModel.cardId, KTestVariables.reportModel.cardId);
        expect(reportModel.status, KTestVariables.reportModel.status);
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing
          ReportModelJsonField.email: KTestVariables.reportModel.email,
          ReportModelJsonField.message: KTestVariables.reportModel.message,
          ReportModelJsonField.date:
              KTestVariables.reportModel.date.toIso8601String(),
          ReportModelJsonField.card: KTestVariables.reportModel.card.getValue,
          ReportModelJsonField.reasonComplaint: _$ReasonComplaintEnumMap[
              KTestVariables.reportModel.reasonComplaint],
        };

        expect(
          () => ReportModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final reportModelJson = KTestVariables.reportModel.toJson();

        expect(reportModelJson, fullJson);
      });
      test('${KGroupText.nullable} ', () {
        final reportModelJson = KTestVariables.reportModel
            .copyWith(message: null, email: null)
            .toJson();

        expect(reportModelJson, nullableJson);
      });
    });
  });
}

const _$ReasonComplaintEnumMap = {
  ReasonComplaint.fraudOrSpam: 'fraudOrSpam',
  ReasonComplaint.fakeNewsOrDisinformation: 'fakeNewsOrDisinformation',
  ReasonComplaint.offensiveOrHatefulContent: 'offensiveOrHatefulContent',
  ReasonComplaint.other: 'other',
};

const _$ReportStatusEnumMap = {
  ReportStatus.isNew: 'isNew',
  ReportStatus.critical: 'critical',
  ReportStatus.resolved: 'resolved',
};
