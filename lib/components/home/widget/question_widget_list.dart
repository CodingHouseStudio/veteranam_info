import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class QuestionWidgetList extends StatelessWidget {
  const QuestionWidgetList({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.read<HomeWatcherBloc>().state.loadingStatus !=
        LoadingStatusHome.loaded;
    final questionModelItems = isLoading
        ? List.generate(
            KDimensions.shimmerQuestionItems,
            (index) => KMockText.questionModel.copyWith(
              id: index.toString(),
            ),
          )
        : context.read<HomeWatcherBloc>().state.questionModelItems;

    return BlocBuilder<HomeWatcherBloc, HomeWatcherState>(
      builder: (context, state) {
        final listLength = state.questionModelItems.length;
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          primary: false,
          itemCount: state.loadingStatus == LoadingStatusHome.loaded
              ? listLength
              : KDimensions.shimmerQuestionItems,
          itemBuilder: (context, index) {
            if (state.loadingStatus == LoadingStatusHome.loaded) {
              return Padding(
                key: ValueKey(state.questionModelItems.elementAt(index).id),
                padding: index != 0
                    ? const EdgeInsets.only(
                        top: KPadding.kPaddingSize24,
                      )
                    : EdgeInsets.zero,
                child: QuestionWidget(
                  key: KWidgetkeys.screen.home.faq,
                  questionModel: questionModelItems.elementAt(index),
                  isDesk: isDesk,
                ),
              );
            } else {
              return Padding(
                padding: index != 0
                    ? const EdgeInsets.only(
                        top: KPadding.kPaddingSize24,
                      )
                    : EdgeInsets.zero,
                child: SkeletonizerWidget(
                  isLoading: !KTest.isTest,
                  child: QuestionWidget(
                    key: KWidgetkeys.screen.home.faqSkeletonizer,
                    questionModel: KMockText.questionModel,
                    isDesk: isDesk,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
