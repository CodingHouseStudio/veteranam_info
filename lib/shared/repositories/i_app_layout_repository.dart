import 'package:veteranam/shared/constants/enum.dart';

abstract class IAppLayoutRepository {
  Stream<AppVersionEnum> get sizeStream;
  AppVersionEnum get getCurrentAppVersion;
  void dispose();
}
