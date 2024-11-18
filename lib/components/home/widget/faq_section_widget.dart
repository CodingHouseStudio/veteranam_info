import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/components/home/home.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FAQSectionDeskWidget extends StatelessWidget {
  const FAQSectionDeskWidget({
    required this.isDesk,
    required this.isTablet,
    super.key,
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

class FaqSectionMobWidget extends SingleChildRenderObjectWidget {
  FaqSectionMobWidget({
    required this.isTablet,
    required this.padding,
    super.key,
  }) : super(
          child: BlocBuilder<HomeWatcherBloc, HomeWatcherState>(
            buildWhen: (previous, current) =>
                previous.loadingStatus != current.loadingStatus,
            builder: (context, state) {
              return SliverList.builder(
                itemBuilder: (context, index) {
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
                },
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                itemCount: 3 +
                    (state.loadingStatus == LoadingStatusHome.loaded
                        ? state.questionModelItems.length
                        : KDimensions.shimmerQuestionItems),
              );
            },
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
