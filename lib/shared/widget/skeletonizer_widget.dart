import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
