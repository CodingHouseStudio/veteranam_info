import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class SkeletonizerWidget extends StatelessWidget {
  const SkeletonizerWidget({
    required this.child,
    required this.isLoading,
    super.key,
    this.baseColor,
    this.highlightColor,
    this.isSliver = false,
  });
  final Widget child;
  final bool isLoading;
  final Color? baseColor;
  final Color? highlightColor;
  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverSkeletonizer(
        effect: ShimmerEffect(
          baseColor: baseColor ?? AppColors.materialThemeWhite,
          highlightColor:
              highlightColor ?? AppColors.materialThemeKeyColorsNeutral,
        ),
        enabled: !KTest.isInterationTest && !KTest.isTest && isLoading,
        child: child,
      );
    } else {
      return Skeletonizer(
        effect: ShimmerEffect(
          baseColor: baseColor ?? AppColors.materialThemeWhite,
          highlightColor:
              highlightColor ?? AppColors.materialThemeKeyColorsNeutral,
        ),
        enabled: !KTest.isInterationTest && !KTest.isTest && isLoading,
        child: child,
      );
    }
  }
}
