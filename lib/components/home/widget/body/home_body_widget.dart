import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesk =
            KPlatformConstants.changeToDescWidget(constraints.maxWidth);
        return Column(
          children: [
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
            BlocBuilder<HomeWatcherBloc, HomeWatcherState>(
              builder: (context, state) {
                switch (state) {
                  case HomeWatcherStateInitial():
                    return const CircularProgressIndicator.adaptive();
                  case HomeWatcherStateLoading():
                    return const CircularProgressIndicator.adaptive();
                  case HomeWatcherStateSuccess():
                    final questionModelItems = state.questionModelItems;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.all(KPadding.kPaddingSize16),
                          child: Text(
                            context.l10n.faq,
                            key: KWidgetkeys.screen.home.questionListTitle,
                            style: isDesk
                                ? AppTextStyle.text96
                                : AppTextStyle.text48,
                          ),
                        ),
                        if (questionModelItems.isNotEmpty)
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: questionModelItems.length,
                            itemBuilder: (context, index) => ListQuestionWidget(
                              questionModelItem: questionModelItems[index],
                              isDesk: isDesk,
                            ),
                          )
                        else
                          TextButton(
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
                          ),
                      ],
                    );

                  case HomeWatcherStateFailure():
                  default:
                    return const CircularProgressIndicator.adaptive();
                }
              },
            ),
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
      },
    );
  }
}
