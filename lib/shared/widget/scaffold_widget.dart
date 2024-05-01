import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    required this.childWidgetsFunction,
    super.key,
    this.hasMicrophone = true,
    this.childSliverLast,
    this.childSliverFirst,
  });
  final List<Widget> Function({required bool isDesk}) childWidgetsFunction;
  final bool hasMicrophone;
  final Widget Function({required bool isDesk})? childSliverLast;
  final Widget Function({required bool isDesk})? childSliverFirst;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        final childWidget = childWidgetsFunction(isDesk: isDesk);
        final padding = EdgeInsets.symmetric(
          horizontal:
              isDesk ? KPadding.kPaddingSize90 : KPadding.kPaddingSize16,
        );
        return Scaffold(
          body: CustomScrollView(
            key: KWidgetkeys.widget.scaffold.scroll,
            slivers: [
              SliverPadding(
                padding: padding,
                sliver: SliverPersistentHeader(
                  delegate: NawbarWidget(
                    isDesk: isDesk,
                    hasMicrophone: hasMicrophone,
                  ),
                ),
              ),
              if (childSliverFirst != null)
                SliverPadding(
                  padding: padding,
                  sliver: childSliverFirst!(isDesk: isDesk),
                ),
              SliverPadding(
                padding: EdgeInsets.only(
                  left: isDesk
                      ? KPadding.kPaddingSize90
                      : KPadding.kPaddingSize16,
                  right: isDesk
                      ? KPadding.kPaddingSize90
                      : KPadding.kPaddingSize16,
                ),
                sliver: SliverList.builder(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  itemBuilder: (context, index) {
                    return childWidget.elementAt(index);
                  },
                  itemCount: childWidget.length,
                ),
              ),
              if (childSliverLast != null)
                SliverPadding(
                  padding: padding,
                  sliver: childSliverLast!(isDesk: isDesk),
                ),
              SliverPadding(
                padding: padding.copyWith(
                  bottom: KPadding.kPaddingSize40,
                ),
                sliver: DecoratedSliver(
                  decoration: KWidgetTheme.boxDecorationCard(context),
                  sliver: SliverPadding(
                    padding: isDesk
                        ? const EdgeInsets.all(KPadding.kPaddingSize48)
                        : const EdgeInsets.symmetric(
                            vertical: KPadding.kPaddingSize32,
                            horizontal: KPadding.kPaddingSize16,
                          ),
                    sliver: SliverGrid(
                      key: KWidgetkeys.widget.footer.widget,
                      delegate: FooterWidget(
                        isDesk: isDesk,
                      ),
                      gridDelegate: isDesk
                          ? const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: KMinMaxSize.maxHeight50,
                              mainAxisSpacing: KPadding.kPaddingSize32,
                            )
                          : const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisExtent: KMinMaxSize.maxHeight50,
                            ),
                    ),
                  ),
                ),
              ),
            ],
            semanticChildCount: childWidget.length,
          ),
        );
      },
    );
  }
}
