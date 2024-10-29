import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared_dart.dart';

abstract class IDeviceRepository {
  Future<Either<SomeFailure, DeviceInfoModel?>> getDevice({
    List<DeviceInfoModel>? initialList,
  });
  Future<Either<SomeFailure, String>> getDeviceId({
    PlatformEnum? platformValue,
  });

  Future<Either<SomeFailure, String?>> getFcm({
    PlatformEnum? platformValue,
  });
}
