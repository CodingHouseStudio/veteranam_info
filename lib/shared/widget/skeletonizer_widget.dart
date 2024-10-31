import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class SkeletonizerWidget extends StatelessWidget {
  const SkeletonizerWidget({
    required this.child,
    required this.isLoading,
    super.key,
  });
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: const ShimmerEffect(
        baseColor: AppColors.materialThemeWhite,
        highlightColor: AppColors.materialThemeKeyColorsNeutral,
      ),
      enabled: isLoading,
      child: child,
    );
  }
}
