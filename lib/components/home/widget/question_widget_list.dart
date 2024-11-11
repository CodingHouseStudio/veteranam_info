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
        LoadingStatus.loaded;
    final questionModelItems = isLoading
        ? List.generate(
            KDimensions.shimmerQuestionItems,
            (index) => KMockText.questionModel.copyWith(
              id: index.toString(),
            ),
          )
        : context.read<HomeWatcherBloc>().state.questionModelItems;

    return Column(
      children: List.generate(
        context.read<HomeWatcherBloc>().state.failure == null
            ? questionModelItems.length
            : 0,
        (index) {
          return Padding(
            padding: index != 0
                ? const EdgeInsets.only(
                    top: KPadding.kPaddingSize24,
                  )
                : EdgeInsets.zero,
            child: SkeletonizerWidget(
              isLoading: isLoading,
              child: QuestionWidget(
                key: KWidgetkeys.screen.home.faq,
                questionModel: questionModelItems.elementAt(index),
                isDesk: isDesk,
              ),
            ),
          );
        },
      ),
    );
  }
}
