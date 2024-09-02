import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton(order: -2)
class BuildRepository {
  static PackageInfo defaultValue = PackageInfo(
    appName: KAppText.unknown,
    packageName: KAppText.unknown,
    version: KAppText.unknown,
    buildNumber: KAppText.unknown,
    buildSignature: KAppText.unknown,
    installerStore: KAppText.unknown,
  );

  Future<PackageInfo> getBuildInfo() async {
    try {
      return PackageInfo.fromPlatform(baseUrl: '${Uri.base.origin}/');
    } catch (e) {
      return defaultValue;
    }
  }
}
