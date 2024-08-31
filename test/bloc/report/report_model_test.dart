import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.report} ${KGroupText.model} ', () {
    final fullJson = {
      ReportModelJsonField.id: KTestText.reportModel.id,
      // ReportModelJsonField.email: KTestText.reportModel.email,
      ReportModelJsonField.message: KTestText.reportModel.message,
      ReportModelJsonField.date: KTestText.reportModel.date.toIso8601String(),
      ReportModelJsonField.card: _$CardEnumEnumMap[KTestText.reportModel.card],
      ReportModelJsonField.reasonComplaint:
          _$ReasonComplaintEnumMap[KTestText.reportModel.reasonComplaint],
      ReportModelJsonField.cardId: KTestText.reportModel.cardId,
      ReportModelJsonField.userId: KTestText.reportModel.userId,
      ReportModelJsonField.status:
          _$ReportStatusEnumMap[KTestText.reportModel.status],
    };
    final nullableJson = {
      ReportModelJsonField.id: KTestText.reportModel.id,
      // ReportModelJsonField.email: KTestText.reportModel.email,
      ReportModelJsonField.message: null,
      ReportModelJsonField.date: KTestText.reportModel.date.toIso8601String(),
      ReportModelJsonField.card: _$CardEnumEnumMap[KTestText.reportModel.card],
      ReportModelJsonField.reasonComplaint:
          _$ReasonComplaintEnumMap[KTestText.reportModel.reasonComplaint],
      ReportModelJsonField.cardId: KTestText.reportModel.cardId,
      ReportModelJsonField.userId: KTestText.reportModel.userId,
      ReportModelJsonField.status: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final reportModel = ReportModel.fromJson(fullJson);

        expect(reportModel.id, KTestText.reportModel.id);
        // expect(reportModel.email, KTestText.reportModel.email);
        expect(reportModel.date, KTestText.reportModel.date);
        expect(reportModel.card, KTestText.reportModel.card);
        expect(reportModel.message, KTestText.reportModel.message);
        expect(
          reportModel.reasonComplaint,
          KTestText.reportModel.reasonComplaint,
        );
        expect(reportModel.userId, KTestText.reportModel.userId);
        expect(reportModel.cardId, KTestText.reportModel.cardId);
        expect(reportModel.status, KTestText.reportModel.status);
      });
      test('${KGroupText.nullable} ', () {
        final reportModel = ReportModel.fromJson(nullableJson);

        expect(reportModel.id, KTestText.reportModel.id);
        // expect(reportModel.email, KTestText.reportModel.email);
        expect(reportModel.date, KTestText.reportModel.date);
        expect(reportModel.card, KTestText.reportModel.card);
        expect(reportModel.message, null);
        expect(
          reportModel.reasonComplaint,
          KTestText.reportModel.reasonComplaint,
        );
        expect(reportModel.userId, KTestText.reportModel.userId);
        expect(reportModel.cardId, KTestText.reportModel.cardId);
        expect(reportModel.status, KTestText.reportModel.status);
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing
          // ReportModelJsonField.email: KTestText.reportModel.email,
          ReportModelJsonField.message: KTestText.reportModel.message,
          ReportModelJsonField.date:
              KTestText.reportModel.date.toIso8601String(),
          ReportModelJsonField.card:
              _$CardEnumEnumMap[KTestText.reportModel.card],
          ReportModelJsonField.reasonComplaint:
              _$ReasonComplaintEnumMap[KTestText.reportModel.reasonComplaint],
        };

        expect(
          () => ReportModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final reportModelJson = KTestText.reportModel.toJson();

        expect(reportModelJson, fullJson);
      });
      // test('${KGroupText.nullable} ', () {
      //   final reportModelJson =
      //       KTestText.reportModel.copyWith(message: null).toJson();

      //   expect(reportModelJson, nullableJson);
      // });
    });
  });
}

const _$ReasonComplaintEnumMap = {
  ReasonComplaint.fraudOrSpam: 'fraudOrSpam',
  ReasonComplaint.fakeNewsOrDisinformation: 'fakeNewsOrDisinformation',
  ReasonComplaint.offensiveOrHatefulContent: 'offensiveOrHatefulContent',
  ReasonComplaint.other: 'other',
};

const _$CardEnumEnumMap = {
  CardEnum.funds: 'funds',
  CardEnum.discount: 'discount',
  CardEnum.information: 'information',
};

const _$ReportStatusEnumMap = {
  ReportStatus.isNew: 'isNew',
  ReportStatus.critical: 'critical',
  ReportStatus.resolved: 'resolved',
};
