import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:veteranam/shared/shared.dart';

class InfoVersionWidget extends StatelessWidget {
  const InfoVersionWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildCubit, PackageInfo>(
      builder: (context, _) {
        return Text(
          ' v${_.version} ${isDesk ? '' : '\n'}'
          ' build ${_.buildNumber}',
          style: isDesk && KTest.testIsWeb
              ? AppTextStyle.materialThemeBodyLarge
              : AppTextStyle.materialThemeBodySmall,
        );
      },
    );
  }
}
