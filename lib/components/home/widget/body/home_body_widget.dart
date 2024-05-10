import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

part '../box_widget_list.dart';
part '../feedback_widget_list.dart';

class HomeBodyWidget extends StatefulWidget {
  const HomeBodyWidget({
    super.key,
  });

  @override
  State<HomeBodyWidget> createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController messageController;
  late GlobalKey feedbackKey;
  late GlobalKey feedbackBoxKey;
  @override
  void initState() {
    feedbackKey = GlobalKey();
    feedbackBoxKey = GlobalKey();
    nameController = TextEditingController();
    emailController = TextEditingController();
    messageController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedbackBloc, FeedbackState>(
      listener: (context, state) {
        if (state.formState == FeedbackEnum.clear) {
          nameController.clear();
          emailController.clear();
          messageController.clear();
        }
      },
      buildWhen: (previous, current) =>
          previous.formState != current.formState ||
          previous.failure != current.failure,
      builder: (context, state) =>
          BlocBuilder<HomeWatcherBloc, HomeWatcherState>(
        builder: (context, _) => ScaffoldWidget(
          hasMicrophone: false,
          mainChildWidgetsFunction: ({required isDesk}) {
            final childWidgets =
                _boxWidgetList(context: context, isDesk: isDesk);

            switch (_) {
              case HomeWatcherStateInitial():
                childWidgets.add(const CircularProgressIndicator.adaptive());
              case HomeWatcherStateLoading():
                childWidgets.add(const CircularProgressIndicator.adaptive());
              case HomeWatcherStateSuccess():
                final questionModelItems = _.questionModelItems;

                childWidgets.addAll([
                  if (questionModelItems.isNotEmpty)
                    ...List.generate(
                        questionModelItems.isNotEmpty
                            ? questionModelItems.length
                            : 1, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: index != 0 ? KPadding.kPaddingSize24 : 0,
                        ),
                        child: QuestionWidget(
                          questionModel: questionModelItems.elementAt(index),
                          isDesk: isDesk,
                        ),
                      );
                    })
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
                ]);

              case HomeWatcherStateFailure():
                childWidgets.add(const CircularProgressIndicator.adaptive());
            }

            return childWidgets
              ..addAll(
                _feedbackWidgetList(
                  context: context,
                  isDesk: isDesk,
                  nameController: nameController,
                  emailController: emailController,
                  messageController: messageController,
                  feedbackKey: feedbackKey,
                  feedbackBoxKey: feedbackBoxKey,
                ),
              );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
