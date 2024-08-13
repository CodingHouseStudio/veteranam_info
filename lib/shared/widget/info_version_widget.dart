import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:veteranam/shared/shared.dart';

class InfoVersionWidget extends StatefulWidget {
  const InfoVersionWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  State<InfoVersionWidget> createState() => _InfoVersionWidgetState();
}

class _InfoVersionWidgetState extends State<InfoVersionWidget> {
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
    setState(() => packageInfo = info);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      ' v${packageInfo.version} ${widget.isDesk ? '' : '\n'}'
      ' build ${packageInfo.buildNumber}',
      style: widget.isDesk && KTest.testIsWeb
          ? AppTextStyle.materialThemeBodyLarge
          : AppTextStyle.materialThemeBodySmall,
    );
  }
}
