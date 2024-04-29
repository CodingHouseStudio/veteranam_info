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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        return Scaffold(
          body: BlocBuilder<ScrollCubit, ScrollController>(
            builder: (context, _) {
              return CustomScrollView(
                key: KWidgetkeys.widget.shellRoute.scroll,
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.only(
                      left: isDesk
                          ? KPadding.kPaddingSize90
                          : KPadding.kPaddingSize16,
                      right: isDesk
                          ? KPadding.kPaddingSize90
                          : KPadding.kPaddingSize16,
                    ),
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
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        childWidgetsFunction(isDesk: isDesk),
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
                      bottom: KPadding.kPaddingSize40,
                    ),
                    sliver: DecoratedSliver(
                      decoration: KWidetTheme.boxDecorationCard,
                      sliver: SliverPadding(
                        padding: isDesk
                            ? const EdgeInsets.all(KPadding.kPaddingSize48)
                            : const EdgeInsets.symmetric(
                                vertical: KPadding.kPaddingSize32,
                                horizontal: KPadding.kPaddingSize16,
                              ),
                        sliver: FooterWidget(
                          key: KWidgetkeys.widget.footer.widget,
                          isDesk: isDesk,
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
                controller: _,
                semanticChildCount: childWidgetsFunction(isDesk: isDesk).length,
              );
            },
          ),
        );
      },
    );
  }
}
