import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared_dart.dart';

// ignore: one_member_abstracts
abstract class ICitiesRepository {
  Future<Either<SomeFailure, List<CityModel>>> getCities();
}
