import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    final buttonsText = [
      [
        context.l10n.aboutUs,
        context.l10n.forInvestors,
        context.l10n.contact,
      ],
      [
        context.l10n.stories,
        context.l10n.discountsCoupons,
        context.l10n.myProfile,
      ],
      [
        context.l10n.work,
        context.l10n.information,
        context.l10n.consultationOnline,
      ],
    ];
    return Container(
      key: KWidgetkeys.widget.footer.widget,
      decoration: KWidetTheme.boxDecorationCard,
      child: Padding(
        padding: isDesk
            ? const EdgeInsets.all(KPadding.kPaddingSize48)
            : const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize16,
                vertical: KPadding.kPaddingSize32,
              ),
        child: Column(
          children: [
            if (isDesk)
              Row(
                children: List.generate(buttonsText.length, (index) {
                  return Expanded(
                    child: _FooterImplementationWidget(
                      columnIndex: index,
                      buttonsText: buttonsText.elementAt(index),
                    ),
                  );
                }),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize16,
                  vertical: KPadding.kPaddingSize32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.logo,
                      key: KWidgetkeys.widget.footer.logo,
                      style: AppTextStyle.text24,
                    ),
                    KSizedBox.kHeightSizedBox24,
                    Column(
                      children: List.generate(buttonsText.length, (index) {
                        return Container(
                          margin: const EdgeInsets.only(
                            bottom: KPadding.kPaddingSize24,
                          ),
                          child: _FooterImplementationWidget(
                            columnIndex: index,
                            isDesktop: false,
                            buttonsText: buttonsText.elementAt(index),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            if (isDesk) KSizedBox.kHeightSizedBox48,
            Row(
              children: [
                IconWidget(
                  key: KWidgetkeys.widget.footer.likedInIcon,
                  icon: KIcon.linkedIn,
                ),
                KSizedBox.kWidthSizedBox24,
                IconWidget(
                  key: KWidgetkeys.widget.footer.instagramIcon,
                  icon: KIcon.instagram,
                ),
                KSizedBox.kWidthSizedBox24,
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

class _FooterImplementationWidget extends StatelessWidget {
  const _FooterImplementationWidget({
    required this.columnIndex,
    required this.buttonsText,
    this.isDesktop = true,
  });
  final int columnIndex;
  final bool isDesktop;
  final List<String> buttonsText;

  @override
  Widget build(BuildContext context) {
    final routes = KAppText.routes.elementAt(columnIndex);
    final buttonsKey =
        KWidgetkeys.widget.footer.buttonsKey.elementAt(columnIndex);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(buttonsText.length, (index) {
        late var topMargin = 0.0;
        if (index > 0) {
          topMargin =
              isDesktop ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16;
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
                                .contains(context.l10n.contact)
                        ? '\n${KMockText.emial}'
                        : ''),
                style: isDesktop
                    ? AppTextStyle.text32
                    : columnIndex == 0
                        ? AppTextStyle.text24
                        : AppTextStyle.text14,
              ),
            ),
            onPressed: () => context.go(routes.elementAt(index)),
          ),
        );
      }),
    );
  }
}
