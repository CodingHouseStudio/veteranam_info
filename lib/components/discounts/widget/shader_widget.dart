import 'package:flutter/material.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class ShaderWidget extends StatelessWidget {
  const ShaderWidget({
    required this.isDesk,
    required this.child, // required this.onResetValue,

    super.key,
  });

  final bool isDesk;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return isDesk
        ? ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  AppColors.materialThemeWhite,
                  AppColors.materialThemeWhite.withOpacity(0.03),
                ],
                stops: const [0.8, 1],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: child,
          )
        : child;
    //     ),
    //   ],
    // );
  }
}
