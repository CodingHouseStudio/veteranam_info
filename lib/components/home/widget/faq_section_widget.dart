import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FAQSectionDeskWidget extends StatelessWidget {
  const FAQSectionDeskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverCrossAxisGroup(
      slivers: [
        SliverCrossAxisExpanded(
          flex: 2,
          sliver: SliverPadding(
            padding: EdgeInsets.only(top: KPadding.kPaddingSize24),
            sliver: SliverToBoxAdapter(
              child: _GetFAQSection(
                isDesk: true,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: KSizedBox.kWidthSizedBox8,
        ),
        SliverCrossAxisExpanded(
          flex: 3,
          sliver: _FaqListWidget(
            isDesk: true,
          ),
        ),
      ],
    );
  }
}

class FaqSectionMobWidget extends StatelessWidget {
  const FaqSectionMobWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: _GetFAQSection(
            isDesk: false,
          ),
        ),
        _FaqListWidget(
          isDesk: false,
        ),
      ],
    );
  }
}

class _FaqListWidget extends StatelessWidget {
  const _FaqListWidget({required this.isDesk});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserWatcherBloc, UserWatcherState, Language>(
      selector: (state) => state.userSetting.locale,
      builder: (context, language) {
        return BlocBuilder<HomeWatcherBloc, HomeWatcherState>(
          builder: (context, state) {
            if (state.loadingStatus.isLoading) {
              return SliverPrototypeExtentList.builder(
                prototypeItem: mockQuestionWidget,
                itemBuilder: (context, index) => mockQuestionWidget,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                itemCount: KDimensions.shimmerQuestionItems,
              );
            } else {
              return SliverList.builder(
                itemBuilder: (context, index) => Padding(
                  key: ValueKey(KMockText.questionModel.id),
                  padding: const EdgeInsets.only(
                    top: KPadding.kPaddingSize24,
                  ),
                  child: QuestionWidget(
                    key: HomeKeys.faq,
                    questionModel: state.questionModelItems.elementAt(index),
                    isDesk: isDesk,
                  ),
                ),
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                itemCount: state.questionModelItems.length,
              );
            }
          },
        );
      },
    );
  }

  Widget get mockQuestionWidget => Padding(
        key: ValueKey(KMockText.questionModel.id),
        padding: const EdgeInsets.only(
          top: KPadding.kPaddingSize24,
        ),
        child: SkeletonizerWidget(
          key: HomeKeys.faqSkeletonizer,
          isLoading: true,
          child: QuestionWidget(
            questionModel: KMockText.questionModel,
            isDesk: isDesk,
          ),
        ),
      );
}

class _GetFAQSection extends StatelessWidget {
  const _GetFAQSection({
    required this.isDesk,
  });

  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.answersYourQuestions,
          key: HomeKeys.faqTitle,
          style: isDesk
              ? AppTextStyle.materialThemeDisplayLarge
              : AppTextStyle.materialThemeDisplaySmall,
        ),
        if (isDesk) KSizedBox.kHeightSizedBox16 else KSizedBox.kHeightSizedBox8,
        Text(
          context.l10n.questionSubtitle,
          key: HomeKeys.faqSubtitle,
          style: isDesk
              ? AppTextStyle.materialThemeBodyLarge
              : AppTextStyle.materialThemeBodyMedium,
        ),
        KSizedBox.kHeightSizedBox16,
        DoubleButtonWidget(
          widgetKey: HomeKeys.faqButton,
          text: context.l10n.writeMessage,
          onPressed: () => context.goNamed(KRoute.feedback.name),
          isDesk: isDesk,
        ),
      ],
    );
  }
}
