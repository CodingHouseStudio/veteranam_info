import 'package:dartz/dartz.dart';
import 'package:kozak/shared/shared.dart';

// ignore: one_member_abstracts
abstract class IReportRepository {
  Future<Either<SomeFailure, bool>> sendReport(ReportModel report);
}
