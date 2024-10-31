import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared_dart.dart';

abstract class IUrlRepository {
  Future<Either<SomeFailure, bool>> share(String url, {bool? useSiteUrl});
  Future<Either<SomeFailure, bool>> launchUrl({
    required String url,
    String? scheme,
  });
  Future<Either<SomeFailure, bool>> copy(String text);
}
