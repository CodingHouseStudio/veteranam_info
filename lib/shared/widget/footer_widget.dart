import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class FooterDescWidget extends StatelessWidget {
  const FooterDescWidget({required this.isDesktop, super.key});
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: KWidgetkeys.widget.footer.widget,
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
                children: List.generate(KAppText.buttonsText.length, (index) {
                  return Expanded(
                    child: _FooterDescImplementationWidget(
                      columnIndex: index,
                    ),
                  );
                }),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSizeSM,
                  vertical: KPadding.kPaddingSizeML,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      KAppText.logo,
                      key: KWidgetkeys.widget.footer.logo,
                      style: AppTextStyle.titleM,
                    ),
                    KSizedBox.kHeightSizedBoxSM,
                    Column(
                      children:
                          List.generate(KAppText.buttonsText.length, (index) {
                        return Container(
                          margin: const EdgeInsets.only(
                            bottom: KPadding.kPaddingSize24,
                          ),
                          child: _FooterDescImplementationWidget(
                            columnIndex: index,
                            isDesktop: false,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            if (isDesktop) KSizedBox.kHeightSizedBoxML,
            Row(
              children: [
                IconWidget(
                  key: KWidgetkeys.widget.footer.likedInIcon,
                  icon: KIcon.linkedIn,
                ),
                KSizedBox.kWidthSizedBoxSM,
                IconWidget(
                  key: KWidgetkeys.widget.footer.instagramIcon,
                  icon: KIcon.instagram,
                ),
                KSizedBox.kWidthSizedBoxSM,
                IconWidget(
                  key: KWidgetkeys.widget.footer.facebookIcon,
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
    this.isDesktop = true,
  });
  final int columnIndex;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final buttonsText = KAppText.buttonsText.elementAt(columnIndex);
    final routes = KAppText.routes.elementAt(columnIndex);
    final buttonsKey =
        KWidgetkeys.widget.footer.buttonsKey.elementAt(columnIndex);
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
          child: TextButton(
            key: buttonsKey.elementAt(index),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                buttonsText.elementAt(index) +
                    (!isDesktop &&
                            buttonsText
                                .elementAt(index)
                                .contains(KAppText.footerContact)
                        ? '\n${KMockText.emial}'
                        : ''),
                style: isDesktop
                    ? AppTextStyle.lableML
                    : columnIndex == 0
                        ? AppTextStyle.lableM
                        : AppTextStyle.lableXS,
              ),
            ),
            onPressed: () => context.go(routes.elementAt(index)),
          ),
        );
      }),
    );
  }
}
