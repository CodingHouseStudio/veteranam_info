import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:veteranam/components/home/home.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class BoxWidgetList extends StatefulWidget {
  const BoxWidgetList({
    required this.isDesk,
    required this.isTablet,
    super.key,
  });
  final bool isDesk;
  final bool isTablet;

  @override
  State<BoxWidgetList> createState() => _BoxWidgetListState();
}

class _BoxWidgetListState extends State<BoxWidgetList> {
  late GlobalKey aboutProjectKey;
  @override
  void initState() {
    super.initState();
    aboutProjectKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isDesk)
          KSizedBox.kHeightSizedBox36
        else
          KSizedBox.kHeightSizedBox16,
        _ProdBoxWidgets(
          isDesk: widget.isDesk,
          isTablet: widget.isTablet,
          aboutProjectKey: aboutProjectKey,
        ),
        KSizedBox.kHeightSizedBox16,
        if (Config.isDevelopment) _DevBoxWidgets(isTablet: widget.isTablet),
        SizedBox(
          key: aboutProjectKey,
          height: KSize.kPixel48,
        ),
      ],
    );
  }
}

class _ProdBoxWidgets extends StatelessWidget {
  const _ProdBoxWidgets({
    required this.isDesk,
    required this.isTablet,
    required this.aboutProjectKey,
  });

  final bool isDesk;
  final bool isTablet;
  final GlobalKey aboutProjectKey;

  @override
  Widget build(BuildContext context) {
    if (isTablet) {
      return IntrinsicHeight(
        child: Row(
          spacing: KPadding.kPaddingSize24,
          children: [
            Expanded(
              flex: isDesk ? 3 : 2,
              child: HomeBoxWidget(
                aboutProjectKey: aboutProjectKey,
                isDesk: isDesk,
                isTablet: true,
              ),
            ),
            const _HomeRightBoxWidgets(),
          ],
        ),
      );
    } else {
      return Column(
        spacing: KPadding.kPaddingSize16,
        children: [
          HomeBoxWidget(
            aboutProjectKey: aboutProjectKey,
            isDesk: false,
            isTablet: false,
          ),
          const DiscountBoxwWidget(
            key: HomeKeys.discountsBox,
            isTablet: false,
          ),
          const DoubleBox(
            isTablet: false,
          ),
        ],
      );
    }
  }
}

class _HomeRightBoxWidgets extends StatelessWidget {
  const _HomeRightBoxWidgets();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 2,
      child: Column(
        spacing: KPadding.kPaddingSize16,
        children: [
          Expanded(
            flex: 3,
            child: DiscountBoxwWidget(
              key: HomeKeys.discountsBox,
              isTablet: true,
            ),
          ),
          Expanded(
            flex: 2,
            child: DoubleBox(
              useSoaccer: true,
              isTablet: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _DevBoxWidgets extends StatelessWidget {
  const _DevBoxWidgets({
    required this.isTablet,
  });

  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    if (isTablet) {
      return Row(
        spacing: KPadding.kPaddingSize24,
        children: [
          Expanded(
            child: BoxWidget(
              key: HomeKeys.informationBox,
              text: context.l10n.information,
              onTap: () => context.goNamed(KRoute.information.name),
              isDesk: true,
              icon: KIcon.globe,
            ),
          ),
          Expanded(
            child: BoxWidget(
              key: HomeKeys.storyBox,
              text: context.l10n.stories,
              onTap: () => context.goNamed(KRoute.stories.name),
              isDesk: true,
              icon: KIcon.messageSquare,
            ),
          ),
          Expanded(
            child: BoxWidget(
              key: HomeKeys.workBox,
              text: context.l10n.work,
              onTap: () => context.goNamed(KRoute.work.name),
              isDesk: true,
              icon: KIcon.briefcase,
            ),
          ),
        ],
      );
    } else {
      return Column(
        spacing: KPadding.kPaddingSize16,
        children: [
          BoxWidget(
            key: HomeKeys.informationBox,
            text: context.l10n.information,
            onTap: () => context.goNamed(KRoute.information.name),
            isDesk: false,
            icon: KIcon.globe,
          ),
          BoxWidget(
            key: HomeKeys.storyBox,
            text: context.l10n.stories,
            onTap: () => context.goNamed(KRoute.stories.name),
            isDesk: false,
            icon: KIcon.messageSquare,
          ),
          BoxWidget(
            key: HomeKeys.workBox,
            text: context.l10n.work,
            onTap: () => context.goNamed(KRoute.work.name),
            isDesk: false,
            icon: KIcon.briefcase,
          ),
        ],
      );
    }
  }
}

class DoubleBox extends StatelessWidget {
  const DoubleBox({
    required this.isTablet,
    super.key,
    this.useSoaccer = false,
  });
  final bool isTablet;
  final bool useSoaccer;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: KPadding.kPaddingSize16,
      children: [
        _InvestorBox(
          isTablet: isTablet,
          useSoaccer: useSoaccer,
        ),
        _FeedbackBox(
          isTablet: isTablet,
          useSoaccer: useSoaccer,
        ),
      ],
    );
  }
}

class _InvestorBox extends StatelessWidget {
  const _InvestorBox({
    required this.isTablet,
    this.useSoaccer = false,
  });

  final bool isTablet;
  final bool useSoaccer;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: isTablet ? 5 : 4,
      child: BoxWidget(
        key: HomeKeys.investorsBox,
        text: context.l10n.investors,
        onTap: () => context.goNamed(KRoute.support.name),
        isDesk: true,
        iconHasBackground: false,
        useSoaccer: useSoaccer,
        background: AppColors.materialThemeKeyColorsNeutralVariant,
        iconText: context.l10n.supportVeterans,
        textStyle: isTablet
            ? AppTextStyle.materialThemeHeadlineSmall
            : AppTextStyle.materialThemeTitleLarge,
        padding: isTablet
            ? null
            : const EdgeInsets.only(
                top: KPadding.kPaddingSize16,
                right: KPadding.kPaddingSize16,
                bottom: KPadding.kPaddingSize8,
                left: KPadding.kPaddingSize16,
              ),
      ),
    );
  }
}

class _FeedbackBox extends StatelessWidget {
  const _FeedbackBox({
    required this.isTablet,
    this.useSoaccer = false,
  });

  final bool isTablet;
  final bool useSoaccer;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: BoxWidget(
        key: HomeKeys.feedbackBox,
        text: context.l10n.contacts,
        onTap: () => context.goNamed(KRoute.feedback.name),
        isDesk: true,
        icon: KIcon.fileText,
        iconHasBackground: false,
        useSoaccer: useSoaccer,
        iconText: context.l10n.haveQuestions,
        textStyle: isTablet
            ? AppTextStyle.materialThemeHeadlineSmall
            : AppTextStyle.materialThemeTitleLarge,
        padding: isTablet
            ? null
            : const EdgeInsets.only(
                top: KPadding.kPaddingSize16,
                right: KPadding.kPaddingSize16,
                bottom: KPadding.kPaddingSize8,
                left: KPadding.kPaddingSize16,
              ),
      ),
    );
  }
}
