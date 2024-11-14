// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RowSliver extends MultiChildRenderObjectWidget {
  // Constructor for the RowSliver widget
  RowSliver({
    required this.left,
    required this.right,
    required this.leftWidthPercent,
    super.key,
  }) : super(children: [left, right]);

  final Widget left; // Left widget to display
  final Widget right; // Right widget to display
  final double
      leftWidthPercent; // Percentage of width allocated to the left widget

  // Creates the render object for this widget
  @override
  _RenderRowSliver createRenderObject(BuildContext context) {
    return _RenderRowSliver(leftWidthPercent: leftWidthPercent);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderRowSliver renderObject,
  ) {}
}

// Extension to get custom parent data for RowSliver
extension _RowSliderParentDataExt on RenderSliver {
  _RowSliverParentData get rowSliver => parentData! as _RowSliverParentData;
}

// Custom parent data class to hold additional data for each sliver child
class _RowSliverParentData extends SliverPhysicalParentData
    with ContainerParentDataMixin<RenderSliver> {}

class _RenderRowSliver extends RenderSliver
    with ContainerRenderObjectMixin<RenderSliver, _RowSliverParentData> {
  // Constructor to initialize the width percentage for the left widget
  _RenderRowSliver({required double leftWidthPercent})
      : _leftWidthPercent = leftWidthPercent;

  final double _leftWidthPercent;

  // Get references to the left and right children
  RenderSliver get left => firstChild!;
  RenderSliver get right => lastChild!;

  // Sets up the parent data for the sliver children
  @override
  void setupParentData(RenderSliver child) {
    if (child.parentData is! _RowSliverParentData) {
      child.parentData = _RowSliverParentData();
    }
  }

  // Perform layout calculations for the sliver children
  @override
  void performLayout() {
    if (firstChild == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    // Calculate the size for the left child based on the width percentage
    final leftSize = constraints.crossAxisExtent * _leftWidthPercent;
    final remainingWidth = constraints.crossAxisExtent - leftSize;

    // Layout both children with the respective sizes
    left.layout(
      constraints.copyWith(crossAxisExtent: leftSize),
      parentUsesSize: true,
    );
    right.layout(
      constraints.copyWith(crossAxisExtent: remainingWidth),
      parentUsesSize: true,
    );

    // Calculate the maximum scroll extent based on the children
    final maxScrollExtent =
        max(left.geometry!.scrollExtent, right.geometry!.scrollExtent);
    final paintExtent = min(constraints.remainingPaintExtent, maxScrollExtent);

    // Set the sliver geometry based on the calculations
    geometry = SliverGeometry(
      scrollExtent: maxScrollExtent,
      paintExtent: paintExtent,
      layoutExtent: paintExtent,
      maxPaintExtent: maxScrollExtent,
      cacheExtent: maxScrollExtent,
    );
  }

  // Paint the children to the canvas
  @override
  void paint(PaintingContext context, Offset offset) {
    if (!geometry!.visible) return;

    // Paint the left child first, then the right child with a horizontal offset
    context
      ..paintChild(left, offset)
      ..paintChild(
        right,
        offset.translate(constraints.crossAxisExtent * _leftWidthPercent, 0),
      );
  }

  // Check if the touch event hit any of the children
  @override
  bool hitTestChildren(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    final children = [left, right]; // Check both children
    for (final child in children) {
      if (child.geometry!.visible) {
        var adjustedCrossAxisPosition = crossAxisPosition;

        // For the right child, adjust the position based on the left
        // widget's width
        if (child == right) {
          adjustedCrossAxisPosition -=
              constraints.crossAxisExtent * _leftWidthPercent;
        }

        // Now check if the touch is inside the child
        if (child.hitTest(
          result,
          mainAxisPosition: mainAxisPosition,
          crossAxisPosition: adjustedCrossAxisPosition,
        )) {
          return true;
        }
      }
    }
    return false;
  }

  // Apply the paint transform for the child slivers
  @override
  void applyPaintTransform(RenderSliver child, Matrix4 transform) {
    child.rowSliver.applyPaintTransform(transform);
  }
}
