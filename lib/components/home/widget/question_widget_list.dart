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
    return BlocBuilder<HomeWatcherBloc, HomeWatcherState>(
      builder: (context, state) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          primary: false,
          itemCount: state.loadingStatus == LoadingStatusHome.loaded
              ? state.questionModelItems.length
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
                  questionModel: state.questionModelItems.elementAt(index),
                  isDesk: isDesk,
                ),
              );
            } else {
              return Padding(
                key: ValueKey(KMockText.questionModel.id),
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
