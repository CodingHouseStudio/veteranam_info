import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton(as: ICitiesRepository)
class CitiesRepository implements ICitiesRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();
  @override
  Future<Either<SomeFailure, List<CityModel>>> getCities() async {
    try {
      final cities = await _firestoreService.getCities();

      return Right(cities);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }
}
