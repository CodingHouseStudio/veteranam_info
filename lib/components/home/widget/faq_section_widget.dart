import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/components/home/home.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FaqSectionWidget extends StatelessWidget {
  const FaqSectionWidget({
    required this.isDesk,
    required this.padding,
    required this.isTablet,
    super.key,
  });
  final bool isDesk;
  final bool isTablet;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return SliverPadding(
        padding: padding,
        sliver: SliverToBoxAdapter(
          child: _FAQSectionDeskWidget(
            isDesk: isDesk,
            isTablet: isTablet,
          ),
        ),
      );
    } else {
      return _FaqSectionMobWidget(
        isTablet: isTablet,
        padding: padding,
      );
    }
  }
}

class _FAQSectionDeskWidget extends StatelessWidget {
  const _FAQSectionDeskWidget({
    required this.isDesk,
    required this.isTablet,
  });
  final bool isDesk;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _GetFAQSection(
            isDesk: true,
          ),
        ),
        KSizedBox.kWidthSizedBox8,
        Expanded(
          flex: 3,
          child: QuestionWidgetList(
            isDesk: true,
          ),
        ),
      ],
    );
  }
}

class _FaqSectionMobWidget extends SingleChildRenderObjectWidget {
  _FaqSectionMobWidget({
    required this.isTablet,
    required this.padding,
  }) : super(
          child: _FaqSectionMobWidgetImplementation(
            isTablet: isTablet,
          ),
        );

  final bool isTablet;
  final EdgeInsets padding;

  @override
  RenderSliverPadding createRenderObject(BuildContext context) {
    return RenderSliverPadding(
      padding: padding,
      textDirection: Directionality.of(context),
    );
  }
}

class _FaqSectionMobWidgetImplementation extends StatelessWidget {
  const _FaqSectionMobWidgetImplementation({required this.isTablet});
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeWatcherBloc, HomeWatcherState>(
      buildWhen: (previous, current) =>
          previous.loadingStatus != current.loadingStatus,
      builder: (context, state) {
        return SliverList.builder(
          itemBuilder: (context, index) => _FaqSectionItemWidget(
            state: state,
            index: index,
            isTablet: isTablet,
          ),
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          itemCount: 3 +
              (state.loadingStatus == LoadingStatusHome.loaded
                  ? state.questionModelItems.length
                  : KDimensions.shimmerQuestionItems),
        );
      },
    );
  }
}

class _FaqSectionItemWidget extends StatelessWidget {
  const _FaqSectionItemWidget({
    required this.state,
    required this.index,
    required this.isTablet,
  });
  final HomeWatcherState state;
  final int index;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return const _GetFAQSection(
        isDesk: false,
      );
    }
    if (index == 1) {
      if (isTablet) {
        return KSizedBox.kHeightSizedBox40;
      } else {
        return KSizedBox.kHeightSizedBox24;
      }
    }
    if (index == 2) {
      return const QuestionWidgetList(
        isDesk: false,
      );
    }
    return QuestionWidgetItem(
      state: state,
      index: index - 3,
      isDesk: false,
    );
  }
}

class _GetFAQSection extends StatelessWidget {
  const _GetFAQSection({
    required this.isDesk,
  });

  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.l10n.answersYourQuestions,
          key: KWidgetkeys.screen.home.faqTitle,
          style: isDesk
              ? AppTextStyle.materialThemeDisplayLarge
              : AppTextStyle.materialThemeDisplaySmall,
        ),
        if (isDesk) KSizedBox.kHeightSizedBox16 else KSizedBox.kHeightSizedBox8,
        Text(
          context.l10n.questionSubtitle,
          key: KWidgetkeys.screen.home.faqSubtitle,
          style: isDesk
              ? AppTextStyle.materialThemeBodyLarge
              : AppTextStyle.materialThemeBodyMedium,
        ),
        KSizedBox.kHeightSizedBox16,
        DoubleButtonWidget(
          widgetKey: KWidgetkeys.screen.home.faqButton,
          text: context.l10n.writeMessage,
          onPressed: () => context.goNamed(KRoute.feedback.name),
          isDesk: isDesk,
        ),
      ],
    );
  }
}
