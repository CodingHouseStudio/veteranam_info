import 'package:flutter/widgets.dart';
import 'package:sliver_center/sliver_center.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class SliverCenterWidget extends StatelessWidget {
  const SliverCenterWidget({
    required this.appVersionEnum,
    required this.sliver,
    super.key,
    this.getTabletPadding = false,
  });
  final AppVersionEnum appVersionEnum;
  final Widget sliver;
  final bool getTabletPadding;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: getTabletPadding
          ? appVersionEnum.paddingWithTablet
          : appVersionEnum.padding,
      sliver: appVersionEnum.isDesk
          ? SliverConstrainedCrossAxis(
              maxExtent: KPlatformConstants.maxWidthThresholdDesk,
              sliver: SliverCenter(sliver: sliver),
            )
          : sliver,
    );
  }
}

// /// This sliver work only if parent is
// /// CustomScrollView without any other widgets
// class SliverCenter extends SingleChildRenderObjectWidget {
//   const SliverCenter({
//     required Widget sliver,
//     required this.appVersionEnum,
//     super.key,
//   }) : super(child: sliver);
//   final AppVersionEnum appVersionEnum;

//   @override
//   RenderSliver createRenderObject(BuildContext context) {
//     return _RenderSliverCenter(appVersionEnum: appVersionEnum);
//   }

//   @override
//   void updateRenderObject(
//     BuildContext context,
//     // ignore: library_private_types_in_public_api
//     _RenderSliverCenter renderObject,
//   ) {
//     renderObject.appVersionEnum = appVersionEnum;
//   }

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(
//       DiagnosticsProperty<AppVersionEnum>('appVersionEnum', appVersionEnum),
//     );
//   }
// }

// // RenderObject class for SliverCenter
// class _RenderSliverCenter extends RenderSliver
//     with RenderObjectWithChildMixin<RenderSliver> {
//   _RenderSliverCenter({required AppVersionEnum appVersionEnum})
//       : _appVersionEnum = appVersionEnum;

//   AppVersionEnum _appVersionEnum;

//   bool leftPaddingAdded = false;

//   AppVersionEnum get appVersionEnum => _appVersionEnum;

//   set appVersionEnum(AppVersionEnum value) {
//     if (_appVersionEnum != value) {
//       _appVersionEnum = value;
//       markNeedsLayout();
//     }
//   }

//   @override
//   void setupParentData(RenderObject child) {
//     if (child.parentData is! SliverPhysicalParentData) {
//       child.parentData = SliverPhysicalParentData();
//     }
//   }

//   @override
//   void performLayout() {
//     if (child == null) {
//       geometry = SliverGeometry.zero;
//       return;
//     }

//     child!.layout(constraints, parentUsesSize: true);

//     final childGeometry = child!.geometry;
//     // Ensure the offset is clamped within the valid range
//     if (childGeometry != null) {
//       geometry = SliverGeometry(
//         scrollExtent: childGeometry.scrollExtent,
//         paintExtent: childGeometry.paintExtent,
//         maxPaintExtent: childGeometry.maxPaintExtent,
//         layoutExtent: childGeometry.layoutExtent,
//       );
//     }
//   }

//   @override
//   void paint(PaintingContext context, Offset offset) {
//     if (child != null) {
//       center();
//       final parentData = child!.parentData;
//       if (parentData is SliverPhysicalParentData) {
//         context.paintChild(
//           child!,
//           offset + (parentData.paintOffset),
//         );
//       }
//     }
//   }

//   @override
//   bool hitTestSelf({
//     required double mainAxisPosition,
//     required double crossAxisPosition,
//   }) {
//     return false;
//   }

//   @override
//   bool hitTestChildren(
//     SliverHitTestResult result, {
//     required double mainAxisPosition,
//     required double crossAxisPosition,
//   }) {
//     if (child == null) {
//       return false;
//     }

//     final parentData = child!.parentData;
//     if (parentData is SliverPhysicalParentData) {
//       final adjustedCrossAxisPosition =
//           crossAxisPosition - parentData.paintOffset.dx;

//       return child!.hitTest(
//         result,
//         mainAxisPosition: mainAxisPosition,
//         crossAxisPosition: adjustedCrossAxisPosition,
//       );
//     }
//     return false;
//   }

//   @override
//   void applyPaintTransform(RenderObject child, Matrix4 transform) {
//     final childParentData = child.parentData;
//     if (child.parentData is SliverPhysicalParentData) {
//       (childParentData! as SliverPhysicalParentData)
//           .applyPaintTransform(transform);
//     }
//   }

//   void center() {
//     if (child != null) {
//       if (_appVersionEnum.isDesk) {
//         final deskPadding = _appVersionEnum.horizontalPadding * 2;

//         if ((constraints.crossAxisExtent - deskPadding) >
//             KPlatformConstants.maxWidthThresholdDesk) {
//           final parentData = child!.parentData;
//           if (parentData is SliverPhysicalParentData) {
//             final parentConstaints = parent?.constraints;
//             if (parentConstaints != null &&
//                 parentConstaints is BoxConstraints) {
//               final parentSize = parentConstaints.maxWidth;

//               final horizontalPadding = parentSize -
//                   KPlatformConstants.maxWidthThresholdDesk -
//                   deskPadding;
//               parentData.paintOffset = Offset(horizontalPadding / 2, 0);
//               leftPaddingAdded = true;
//               return;
//             }
//           }
//         }
//       }
//       if (leftPaddingAdded) {
//         final parentData = child!.parentData;
//         if (parentData is SliverPhysicalParentData) {
//           parentData.paintOffset = Offset.zero;
//           leftPaddingAdded = false;
//         }
//       }
//     }
//   }
// }
