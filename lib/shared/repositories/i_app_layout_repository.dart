import 'package:veteranam/shared/constants/enum.dart';

abstract class IAppLayoutRepository {
  Stream<AppVersionEnum> get appVersionStream;
  AppVersionEnum get getCurrentAppVersion;

  void dispose();
}
