import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

abstract class IUrlRepository {
  Future<Either<SomeFailure, bool>> share(String url);
  Future<Either<SomeFailure, bool>> launchUrl({
    required String url,
    String? scheme,
  });
  Future<Either<SomeFailure, bool>> copy(String text);
}
