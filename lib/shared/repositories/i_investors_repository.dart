import 'package:dartz/dartz.dart';
import 'package:kozak/shared/shared.dart';

abstract class IInvestorsRepository {
  Future<Either<SomeFailure, List<FundModel>>> getFunds();
  void addMockFunds();
}
