import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: ICitiesRepository)
class CitiesRepository implements ICitiesRepository {
  CitiesRepository({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;
  final FirestoreService _firestoreService;
  @override
  Future<Either<SomeFailure, List<CityModel>>> getCities() async {
    return eitherFutureHelper(
      () async {
        final cities = await _firestoreService.getCities();

        final srotedCities = cities
          ..sort(
            (a, b) => a.name.uk.compareUkrain(b.name.uk),
          );

        return Right(srotedCities);
      },
      methodName: 'Cities(getCities)',
      className: ErrorText.repositoryKey,
    );
  }
}
