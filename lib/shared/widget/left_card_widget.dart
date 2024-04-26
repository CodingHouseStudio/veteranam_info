import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:kozak/shared/shared.dart';

class LeftCardWidget extends StatelessWidget {
  const LeftCardWidget({
    required this.widgetList,
    super.key,
    this.image,
  });

  final List<Widget> Function({required bool isDesk}) widgetList;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        return Scaffold(
          appBar: NawbarWidget(
            isDesk: isDesk,
          ),
          backgroundColor: isDesk ? AppColors.blackWhite : AppColors.white,
          body: buildChildWidget(
            isDesk
                ? ColoredBox(
                    key: KWidgetkeys.widget.leftCard.desk,
                    color: AppColors.blackWhite,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: KWidgetTheme.boxDecorationWhite,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: KPadding.kPaddingSize80,
                                left: KPadding.kPaddingSize96,
                                top: KPadding.kPaddingSize24,
                                bottom: KPadding.kPaddingSize92,
                              ),
                              child: Column(
                                crossAxisAlignment: isDesk
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.center,
                                children: widgetList(isDesk: isDesk),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: image != null
                              ? CachedNetworkImage(
                                  key: KWidgetkeys.widget.leftCard.image,
                                  imageUrl: KMockText.image,
                                  placeholder: (context, url) =>
                                      Image.asset(''),
                                  errorWidget: (context, url, error) =>
                                      KIcon.error,
                                  fit: BoxFit.fill,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  )
                : ColoredBox(
                    color: AppColors.white,
                    child: Padding(
                      key: KWidgetkeys.widget.leftCard.mob,
                      padding: const EdgeInsets.only(
                        top: KPadding.kPaddingSize56,
                        right: KPadding.kPaddingSize16,
                        left: KPadding.kPaddingSize16,
                        bottom: KPadding.kPaddingSize24,
                      ),
                      child: Column(
                        children: widgetList(isDesk: isDesk),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget buildChildWidget(Widget childWidget) {
    return ListView(
      key: KWidgetkeys.widget.shellRoute.scroll,
      padding: const EdgeInsets.only(top: KPadding.kPaddingSize40),
      children: [childWidget],
    );
  }
}
