import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared_dart.dart';

abstract class IReportRepository {
  Future<Either<SomeFailure, bool>> sendReport(ReportModel report);
  Future<Either<SomeFailure, List<ReportModel>>> getCardReportById({
    required CardEnum cardEnum,
    required String userId,
  });
}
