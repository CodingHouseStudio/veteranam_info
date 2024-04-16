import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:kozak/shared/shared.dart';

class LeftCardWidget extends StatelessWidget {
  const LeftCardWidget({
    required this.isDesk,
    required this.childWidget,
    super.key,
    this.image,
  });

  final bool isDesk;
  final Widget childWidget;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return isDesk
        ? ColoredBox(
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
                      child: SingleChildScrollView(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: KMinMaxSize.maxWidth800,
                            ),
                            child: buildChildWidget(),
                          ),
                        ),
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
          )
        : SingleChildScrollView(
            key: KWidgetkeys.widget.leftCard.mob,
            child: Padding(
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
    return Padding(
      key: KWidgetkeys.widget.leftCard.childWidget,
      padding: isDesk
          ? const EdgeInsets.only(
              top: KPadding.kPaddingSize24,
              bottom: KPadding.kPaddingSize92,
            )
          : const EdgeInsets.only(
              top: KPadding.kPaddingSize56,
              right: KPadding.kPaddingSize16,
              left: KPadding.kPaddingSize16,
            ),
      child: childWidget,
    );
  }
}
