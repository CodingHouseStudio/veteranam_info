import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ScaffoldWidget extends StatefulWidget {
  const ScaffoldWidget({
    required this.mainChildWidgetsFunction,
    this.titleChildWidgetsFunction,
    super.key,
    this.mainDeskPadding,
  });
  final List<Widget> Function({required bool isDesk})?
      titleChildWidgetsFunction;
  final List<Widget> Function({required bool isDesk}) mainChildWidgetsFunction;
  final EdgeInsetsGeometry? mainDeskPadding;

  @override
  State<ScaffoldWidget> createState() => _ScaffoldWidgetState();
}

class _ScaffoldWidgetState extends State<ScaffoldWidget> {
  late ScrollController controller;
  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        final mainChildWidget = widget.mainChildWidgetsFunction(isDesk: isDesk);
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
              if (widget.titleChildWidgetsFunction != null)
                SliverPadding(
                  padding: padding,
                  sliver: SliverList.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemBuilder: (context, index) {
                      return widget.titleChildWidgetsFunction!(isDesk: isDesk)
                          .elementAt(index);
                    },
                    itemCount: widget
                        .titleChildWidgetsFunction!(isDesk: isDesk).length,
                  ),
                ),
              SliverPadding(
                padding: isDesk && widget.mainDeskPadding != null
                    ? padding.add(widget.mainDeskPadding!)
                    : padding,
                sliver: SliverList.builder(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  itemBuilder: (context, index) {
                    return mainChildWidget.elementAt(index);
                  },
                  itemCount: mainChildWidget.length,
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
            controller: controller,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
