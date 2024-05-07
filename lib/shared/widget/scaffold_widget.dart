import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    required this.childWidgetsFunction,
    super.key,
    this.hasMicrophone = true,
  });
  final List<Widget> Function({required bool isDesk}) childWidgetsFunction;
  final bool hasMicrophone;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScrollCubit, ScrollController>(
      builder: (context, _) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final isDesk = constraints.maxWidth >
                KPlatformConstants.minWidthThresholdTablet;
            final childWidget = childWidgetsFunction(isDesk: isDesk);
            final padding = EdgeInsets.symmetric(
              horizontal:
                  isDesk ? KPadding.kPaddingSize90 : KPadding.kPaddingSize16,
            );
            return Scaffold(
              body: CustomScrollView(
                key: KWidgetkeys.widget.scaffold.scroll,
                controller: _,
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
                        sliver: isDesk
                            ? SliverGrid(
                                key: KWidgetkeys.widget.footer.widget,
                                delegate: FooterWidget(
                                  isDesk: true,
                                ),
                                gridDelegate:
                                    // ignore: lines_longer_than_80_chars
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
                semanticChildCount: childWidget.length,
              ),
            );
          },
        );
      },
    );
  }
}
