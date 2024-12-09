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
  });
  final Widget child;
  final bool isLoading;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: baseColor ?? AppColors.materialThemeWhite,
        highlightColor:
            highlightColor ?? AppColors.materialThemeKeyColorsNeutral,
      ),
      enabled: !KTest.isTest && isLoading,
      child: child,
    );
  }
}
