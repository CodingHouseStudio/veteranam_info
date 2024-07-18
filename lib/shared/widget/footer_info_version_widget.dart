import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:veteranam/shared/shared.dart';

class FooterInfoVersionWidget extends StatefulWidget {
  const FooterInfoVersionWidget({super.key});

  @override
  State<FooterInfoVersionWidget> createState() =>
      _FooterInfoVersionWidgetState();
}

class _FooterInfoVersionWidgetState extends State<FooterInfoVersionWidget> {
  late PackageInfo packageInfo;

  @override
  void initState() {
    packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown',
      buildSignature: 'Unknown',
      installerStore: 'Unknown',
    );
    _initPackageInfo();
    super.initState();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      ' v${packageInfo.version} build ${packageInfo.buildNumber}',
      style: AppTextStyle.materialThemeBodyLarge,
    );
  }
}
