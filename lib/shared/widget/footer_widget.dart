import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class FooterDescWidget extends StatelessWidget {
  const FooterDescWidget({required this.isDesktop, super.key});
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: KWidgetkeys.footerKeys.widget,
      decoration: KWidetTheme.boxDecorationCard,
      child: Padding(
        padding: isDesktop
            ? const EdgeInsets.all(KPadding.kPaddingSizeXL)
            : const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSizeSM,
                vertical: KPadding.kPaddingSizeML,
              ),
        child: Column(
          children: [
            if (isDesktop)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _FooterDescImplementationWidget(
                      columnIndex: 0,
                      isDesktop: isDesktop,
                    ),
                  ),
                  Expanded(
                    child: _FooterDescImplementationWidget(
                      columnIndex: 1,
                      isDesktop: isDesktop,
                    ),
                  ),
                  Expanded(
                    child: _FooterDescImplementationWidget(
                      columnIndex: 2,
                      isDesktop: isDesktop,
                    ),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    KAppText.logo,
                    key: KWidgetkeys.footerKeys.logo,
                    style: AppTextStyle.titleM,
                  ),
                  KSizedBox.kHeightSizedBoxSM,
                  _FooterDescImplementationWidget(
                    columnIndex: 0,
                    isDesktop: isDesktop,
                  ),
                  KSizedBox.kHeightSizedBoxSM,
                  _FooterDescImplementationWidget(
                    columnIndex: 1,
                    isDesktop: isDesktop,
                  ),
                  KSizedBox.kHeightSizedBoxSM,
                  _FooterDescImplementationWidget(
                    columnIndex: 2,
                    isDesktop: isDesktop,
                  ),
                ],
              ),
            if (isDesktop)
              KSizedBox.kHeightSizedBoxML
            else
              KSizedBox.kHeightSizedBoxSM,
            Row(
              children: [
                IconWidget(
                  key: KWidgetkeys.footerKeys.likedInIcon,
                  icon: KIcon.linkedIn,
                ),
                KSizedBox.kWidthSizedBoxSM,
                IconWidget(
                  key: KWidgetkeys.footerKeys.instagramIcon,
                  icon: KIcon.instagram,
                ),
                KSizedBox.kWidthSizedBoxSM,
                IconWidget(
                  key: KWidgetkeys.footerKeys.facebookIcon,
                  icon: KIcon.facebook,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterDescImplementationWidget extends StatelessWidget {
  const _FooterDescImplementationWidget({
    required this.columnIndex,
    required this.isDesktop,
  });
  final int columnIndex;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final buttonsText = KAppText.buttonsText.elementAt(columnIndex);
    final routes = KAppText.routes.elementAt(columnIndex);
    final buttonsKey = KWidgetkeys.footerKeys.buttonsKey.elementAt(columnIndex);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(buttonsText.length, (index) {
        late var topMargin = 0.0;
        if (index > 0) {
          topMargin =
              isDesktop ? KPadding.kPaddingSizeML : KPadding.kPaddingSizeSM;
        }
        return Container(
          margin: EdgeInsets.only(top: topMargin),
          child: ButtonWidget(
            key: buttonsKey.elementAt(index),
            text: buttonsText.elementAt(index) +
                (!isDesktop &&
                        buttonsText
                            .elementAt(index)
                            .contains(KAppText.footerContact)
                    ? '\n${KMockText.emial}'
                    : ''),
            textStyle: isDesktop
                ? AppTextStyle.lableML
                : columnIndex == 0
                    ? AppTextStyle.lableM
                    : AppTextStyle.lableXS,
            onPressed: () => context.go(routes.elementAt(index)),
            padding: EdgeInsets.zero,
          ),
        );
      }),
    );
  }
}
