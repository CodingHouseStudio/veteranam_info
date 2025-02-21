import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(env: [Config.mobile])
class IosAppTrackingRepository {
  IosAppTrackingRepository();
  Future<Either<SomeFailure, TrackingStatus>> getStatus() async =>
      eitherFutureHelper(
        () async {
          final statusValue =
              await AppTrackingTransparency.trackingAuthorizationStatus;
          return Right(statusValue);
        },
        methodName: 'request',
        className: ErrorText.iosAppTrackingRepository,
      );
  Future<Either<SomeFailure, TrackingStatus>>
      requestTrackingAuthorization() async => eitherFutureHelper(
            () async => Right(
              await AppTrackingTransparency.requestTrackingAuthorization(),
            ),
            methodName: 'request',
            className: ErrorText.iosAppTrackingRepository,
          );
}
