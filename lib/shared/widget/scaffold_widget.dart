import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

/// COMMENT: Сlass adds common elements to screens
class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    required this.childWidgetsFunction,
    super.key,
    this.hasMic = true,
  });
  final List<Widget> Function({required bool isDesk}) childWidgetsFunction;
  final bool hasMic;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        final childWidgets = childWidgetsFunction(isDesk: isDesk)
          ..add(
            FooterWidget(
              isDesk: isDesk,
            ),
          );
        return Scaffold(
          // extendBodyBehindAppBar: true,
          appBar: NawbarWidget(
            isDesk: isDesk,
            hasMicrophone: hasMic,
          ),
          body: ListView.custom(
            key: KWidgetkeys.widget.shellRoute.scroll,
            padding: EdgeInsets.only(
              left: isDesk ? KPadding.kPaddingSize90 : KPadding.kPaddingSize16,
              right: isDesk ? KPadding.kPaddingSize90 : KPadding.kPaddingSize16,
              bottom:
                  isDesk ? KPadding.kPaddingSize40 : KPadding.kPaddingSize24,
            ),
            semanticChildCount: childWidgets.length,
            childrenDelegate: SliverChildListDelegate(childWidgets),
          ),
        );
      },
    );
  }
}
