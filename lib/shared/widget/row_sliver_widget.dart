// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RowSliver extends MultiChildRenderObjectWidget {
  RowSliver({
    required this.left,
    required this.right,
    super.key,
  }) : super(children: [left, right]);

  final Widget left;
  final Widget right;

  @override
  _RenderRowSliverSliver createRenderObject(BuildContext context) {
    return _RenderRowSliverSliver();
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderRowSliverSliver renderObject,
  ) {}
}

extension _RowSliderParentDataExt on RenderSliver {
  /// Shortcut for [parentData]
  _RowSliverParentData get rowSliver => parentData! as _RowSliverParentData;
}

class _RowSliverParentData extends SliverPhysicalParentData
    with ContainerParentDataMixin<RenderSliver> {}

class _RenderRowSliverSliver extends RenderSliver
    with ContainerRenderObjectMixin<RenderSliver, _RowSliverParentData> {
  RenderSliver get left => _children.first;
  RenderSliver get right => _children.last;

  Iterable<RenderSliver> get _children sync* {
    var child = firstChild;
    while (child != null) {
      yield child;
      child = childAfter(child);
    }
  }

  @override
  void setupParentData(RenderSliver child) {
    if (child.parentData is! _RowSliverParentData) {
      child.parentData = _RowSliverParentData();
    }
  }

  @override
  void performLayout() {
    if (firstChild == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    final leftSize = (constraints.crossAxisExtent / 3) * 2;

    // Layout the left child with its calculated size
    left.layout(
      constraints.copyWith(crossAxisExtent: leftSize),
      parentUsesSize: true,
    );

    // Layout the right child with the remaining space
    right.layout(
      constraints.copyWith(
        crossAxisExtent: constraints.crossAxisExtent - leftSize,
      ),
      parentUsesSize: true,
    );

    // Position the right child to the right side
    right.rowSliver.paintOffset = Offset(leftSize, 0);

    // Calculate geometry based on children's layout extents
    final maxScrollExtent =
        max(left.geometry!.scrollExtent, right.geometry!.scrollExtent);
    geometry = SliverGeometry(
      scrollExtent: maxScrollExtent,
      paintExtent: left.geometry!.paintExtent,
      maxPaintExtent:
          max(left.geometry!.maxPaintExtent, right.geometry!.maxPaintExtent),
      maxScrollObstructionExtent: max(
        left.geometry!.maxScrollObstructionExtent,
        right.geometry!.maxScrollObstructionExtent,
      ),
      layoutExtent: left.geometry!.layoutExtent + right.geometry!.layoutExtent,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (!geometry!.visible) return;

    // Paint the left child
    context.paintChild(left, offset);

    // Calculate the offset for painting the right child
    final rightOffsetX = offset.dx + (constraints.crossAxisExtent / 3) * 2;
    final rightOffset = Offset(rightOffsetX, offset.dy);

    // Paint the right child
    context.paintChild(right, rightOffset);
  }

  @override
  bool hitTestChildren(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    for (final child in _childrenInHitTestOrder) {
      if (child.geometry!.visible) {
        final hit = child.hitTest(
          result,
          mainAxisPosition: mainAxisPosition,
          crossAxisPosition: crossAxisPosition - child.rowSliver.paintOffset.dx,
        );

        if (hit) return true;
      }
    }
    return false;
  }

  Iterable<RenderSliver> get _childrenInHitTestOrder sync* {
    var child = lastChild;
    while (child != null) {
      yield child;
      child = childBefore(child);
    }
  }

  @override
  void applyPaintTransform(RenderSliver child, Matrix4 transform) {
    child.rowSliver.applyPaintTransform(transform);
  }
}
