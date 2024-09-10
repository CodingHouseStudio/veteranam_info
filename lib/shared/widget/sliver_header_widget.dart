import 'package:flutter/material.dart';

class SliverHeaderWidget extends SliverPersistentHeaderDelegate {
  const SliverHeaderWidget({
    required this.childWidget,
    required this.maxMinHeight,
    this.rebuildValues,
  });
  final Widget Function({
    required double shrinkOffset,
    required bool overlapsContent,
  }) childWidget;
  final double maxMinHeight;
  final dynamic rebuildValues;

  @override
  double get maxExtent => maxMinHeight;

  @override
  double get minExtent => maxMinHeight;

  //Rebuild screen only when isDesk value change
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate is SliverHeaderWidget &&
      (rebuildValues != oldDelegate.rebuildValues);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return childWidget(
      shrinkOffset: shrinkOffset,
      overlapsContent: overlapsContent,
    );
  }
}
