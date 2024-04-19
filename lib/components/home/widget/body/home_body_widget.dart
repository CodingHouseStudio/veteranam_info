import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeWatcherBloc, HomeWatcherState>(
      builder: (context, state) {
        switch (state) {
          case HomeWatcherStateInitial():
            return const CircularProgressIndicator.adaptive();
          case HomeWatcherStateLoading():
            return const CircularProgressIndicator.adaptive();
          case HomeWatcherStateSuccess():
            final questionModelItems = state.questionModelItems;
            return ScaffoldWithNavBar(
              hasMic: false,
              childWidgetsFunction: ({required isDesk}) => [
                if (isDesk)
                  KSizedBox.kHeightSizedBox24
                else
                  KSizedBox.kHeightSizedBox16,
                BoxesWidget(
                  isDesk: isDesk,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox160
                else
                  KSizedBox.kHeightSizedBox40,
                Padding(
                  padding: const EdgeInsets.all(
                    KPadding.kPaddingSize16,
                  ),
                  child: Text(
                    context.l10n.faq,
                    key: KWidgetkeys.screen.home.questionListTitle,
                    style: isDesk ? AppTextStyle.text96 : AppTextStyle.text48,
                  ),
                ),
                ...List.generate(
                    questionModelItems.isNotEmpty
                        ? questionModelItems.length
                        : 1, (index) {
                  if (questionModelItems.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: index != 0 ? KPadding.kPaddingSize24 : 0,
                      ),
                      child: QuestionWidget(
                        questionModel: questionModelItems.elementAt(index),
                        isDesk: isDesk,
                      ),
                    );
                  } else {
                    return TextButton(
                      key: KWidgetkeys.screen.home.buttonMock,
                      onPressed: () {
                        GetIt.I.get<IHomeRepository>().addMockQuestions();
                        context
                            .read<HomeWatcherBloc>()
                            .add(const HomeWatcherEvent.started());
                      },
                      child: Text(
                        context.l10n.getMockData,
                        style: AppTextStyle.text32,
                      ),
                    );
                  }
                }),
                if (isDesk)
                  KSizedBox.kHeightSizedBox160
                else
                  KSizedBox.kHeightSizedBox40,
                FeedbackWidget(
                  isDesk: isDesk,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox160
                else
                  KSizedBox.kHeightSizedBox10,
              ],
            );

          case HomeWatcherStateFailure():
          default:
            return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }
}
