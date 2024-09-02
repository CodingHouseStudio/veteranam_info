import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared.dart';

class InfoVersionWidget extends StatelessWidget {
  const InfoVersionWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildCubit, BuildState>(
      builder: (context, _) {
        return Text(
          ' v${_.build.version} ${isDesk ? '' : '\n'}'
          ' build ${_.build.buildNumber}',
          style: isDesk && KTest.testIsWeb
              ? AppTextStyle.materialThemeBodyLarge
              : AppTextStyle.materialThemeBodySmall,
        );
      },
    );
  }
}
