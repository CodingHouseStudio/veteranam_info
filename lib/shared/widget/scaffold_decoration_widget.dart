import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ScaffoldDecorationWidget extends StatelessWidget {
  const ScaffoldDecorationWidget({
    required this.mainChildWidgetsFunction,
    this.mainDecoration,
    this.titleChildWidgetsFunction,
    super.key,
    this.mainPadding,
    this.mainDecorationPadding,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk}) mainChildWidgetsFunction;
  final EdgeInsetsGeometry Function({
    required bool isDesk,
    required double maxWidth,
  })? mainPadding;
  final EdgeInsetsGeometry Function({required bool isDesk})?
      mainDecorationPadding;
  final BoxDecoration? mainDecoration;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        final mainChildWidget = mainChildWidgetsFunction(isDesk: isDesk);
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
                  ),
                ),
              ),
              if (titleChildWidgetsFunction != null)
                SliverPadding(
                  padding: padding,
                  sliver: SliverList.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemBuilder: (context, index) {
                      return titleChildWidgetsFunction!(isDesk: isDesk)
                          .elementAt(index);
                    },
                    itemCount:
                        titleChildWidgetsFunction!(isDesk: isDesk).length,
                  ),
                ),
              SliverPadding(
                padding: mainPadding != null
                    ? mainPadding!(
                        isDesk: isDesk,
                        maxWidth: constraints.maxWidth,
                      ).add(padding)
                    : padding,
                sliver: DecoratedSliver(
                  decoration: mainDecoration ?? const BoxDecoration(),
                  sliver: SliverPadding(
                    padding: mainDecorationPadding != null
                        ? mainDecorationPadding!(isDesk: isDesk)
                        : EdgeInsets.zero,
                    sliver: SliverList.builder(
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      itemBuilder: (context, index) {
                        return mainChildWidget.elementAt(index);
                      },
                      itemCount: mainChildWidget.length,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: padding.copyWith(
                  bottom: KPadding.kPaddingSize40,
                ),
                sliver: DecoratedSliver(
                  decoration: context.widgetTheme.boxDecorationCard,
                  sliver: SliverPadding(
                    padding: isDesk
                        ? const EdgeInsets.all(KPadding.kPaddingSize48)
                        : const EdgeInsets.symmetric(
                            vertical: KPadding.kPaddingSize32,
                            horizontal: KPadding.kPaddingSize16,
                          ),
                    sliver: isDesk
                        ? SliverGrid(
                            key: KWidgetkeys.widget.footer.widget,
                            delegate: FooterWidget(
                              isDesk: true,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: KMinMaxSize.maxHeight50,
                              mainAxisSpacing: KPadding.kPaddingSize32,
                            ),
                          )
                        : SliverList(
                            delegate: FooterWidget(
                              isDesk: false,
                            ),
                          ),
                  ),
                ),
              ),
            ],
            semanticChildCount: mainChildWidget.length,
            controller: ScrollController(),
          ),
        );
      },
    );
  }
}
