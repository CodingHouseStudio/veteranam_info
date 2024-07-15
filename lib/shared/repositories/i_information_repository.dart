import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

abstract class IInformationRepository {
  Stream<List<InformationModel>> getInformationItems();
  Future<Either<SomeFailure, InformationModel>> getInformation(String id);
  void addMockInformationItems();
  // ignore: avoid_positional_boolean_parameters
  Future<Either<SomeFailure, bool>> updateLikeCount({
    required InformationModel informationModel,
    required bool isLiked,
  });
}
