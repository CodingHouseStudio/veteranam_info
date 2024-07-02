import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

// ignore: one_member_abstracts
abstract class IReportRepository {
  Future<Either<SomeFailure, bool>> sendReport(ReportModel report);
}
