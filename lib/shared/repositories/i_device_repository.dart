import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

abstract class IDeviceRepository {
  Future<Either<SomeFailure, DeviceInfoModel?>> getDevice({
    List<DeviceInfoModel?>? initialList,
  });
  Future<Either<SomeFailure, String>> getDeviceId();

  Future<Either<SomeFailure, String?>> getFcm();
}
