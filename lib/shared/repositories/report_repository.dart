// import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

@Singleton(
  as: IReportRepository, env: [Config.user],
  // signalsReady: true,
)
class ReportRepository implements IReportRepository {
  ReportRepository({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;
  final FirestoreService _firestoreService;

  @override
  Future<Either<SomeFailure, bool>> sendReport(ReportModel report) async {
    return eitherFutureHelper(
      () async {
        await _firestoreService.addReport(report);
        return const Right(true);
      },
      methodName: 'Report(sendReport)',
      className: ErrorText.repositoryKey,
      data: 'Report Model: $report',
    );
  }

  @override
  Future<Either<SomeFailure, List<ReportModel>>> getCardReportById({
    required CardEnum cardEnum,
    required String userId,
  }) async {
    return eitherFutureHelper(
      () async {
        final userDiscountsItems =
            await _firestoreService.getCardReportByUserId(
          cardEnum: cardEnum,
          userId: userId,
        );

        return Right(userDiscountsItems);
      },
      methodName: 'Report(getCardReportById)',
      className: ErrorText.repositoryKey,
      data: 'Card Enum ${cardEnum.getValue}| User ID: $userId',
    );
  }
}
