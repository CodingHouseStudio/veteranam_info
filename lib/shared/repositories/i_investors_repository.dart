import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

abstract class IInvestorsRepository {
  Future<Either<SomeFailure, List<FundModel>>> getFunds();
  void addMockFunds();
}
