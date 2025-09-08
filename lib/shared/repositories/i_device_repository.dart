import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared_dart.dart';
import 'package:veteranam/shared/shared_flutter.dart';

abstract class IDeviceRepository {
  Future<Either<SomeFailure, DeviceInfoModel?>> getDevice();
  Future<Either<SomeFailure, String>> getDeviceId({
    PlatformEnum? platformValue,
  });

  Future<Either<SomeFailure, String?>> getFcm({
    PlatformEnum? platformValue,
  });

  void dispose();
}
