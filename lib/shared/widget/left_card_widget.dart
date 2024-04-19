import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:kozak/shared/shared.dart';

class LeftCardWidget extends StatelessWidget {
  const LeftCardWidget({
    required this.isDesk,
    required this.widgetList,
    super.key,
    this.image,
  });

  final bool isDesk;
  final List<Widget> widgetList;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return isDesk
        ? SafeArea(
            child: ColoredBox(
              key: KWidgetkeys.widget.leftCard.desk,
              color: AppColors.blackWhite,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: KPadding.kPaddingSize40,
                      ),
                      child: Container(
                        decoration: KWidetTheme.boxDecorationWhite,
                        child: Center(
                          child: buildChildWidget(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: image != null
                        ? CachedNetworkImage(
                            key: KWidgetkeys.widget.leftCard.image,
                            imageUrl: KMockText.image,
                            placeholder: (context, url) => Image.asset(''),
                            errorWidget: (context, url, error) => KIcon.error,
                            fit: BoxFit.fill,
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
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
              ),
              child: buildChildWidget(),
            ),
          );
  }

  Widget buildChildWidget() {
    return ListView.custom(
      key: KWidgetkeys.widget.shellRoute.scroll,
      padding: isDesk
          ? const EdgeInsets.only(
              top: KPadding.kPaddingSize24,
              bottom: KPadding.kPaddingSize92,
              left: KPadding.kPaddingSize96,
              right: KPadding.kPaddingSize80,
            )
          : null,
      childrenDelegate: SliverChildListDelegate(
        widgetList
            .map(
              (widget) => Align(
                alignment: isDesk ? Alignment.centerLeft : Alignment.center,
                child: widget,
              ),
            )
            .toList(),
      ),
    );
  }
}
