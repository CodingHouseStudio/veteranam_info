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
            return Column(
              children: [
                KSizedBox.kHeightSizedBox30,
                if (state.questionModelItems.isNotEmpty)
                  ListQuestionWidget(
                    questionModelItems: state.questionModelItems,
                  )
                else
                  TextButton(
                    key: KWidgetkeys.screen.home.buttonMock,
                    onPressed: () =>
                        GetIt.I.get<IHomeRepository>().addMockQuestions(),
                    child: Text(
                      context.l10n.getMockData,
                    ),
                  ),
                KSizedBox.kHeightSizedBox30,
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
