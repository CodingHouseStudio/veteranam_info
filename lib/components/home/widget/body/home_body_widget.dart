import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

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
          childWidgetsFunction: ({required isDesk}) {
            final childWidgets = <Widget>[
              if (isDesk)
                KSizedBox.kHeightSizedBox24
              else
                KSizedBox.kHeightSizedBox16,
              if (isDesk)
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: HomeBoxWidget(
                        isDesk: isDesk,
                      ),
                    ),
                    KSizedBox.kWidthSizedBox24,
                    Expanded(
                      child: Column(
                        children: [
                          BoxWidget(
                            key: KWidgetkeys.screen.home.discountsBox,
                            text: context.l10n.discountsCoupons,
                            onTap: () => context.goNamedWithScroll(
                              KRoute.discounts.name,
                            ),
                            isDesk: isDesk,
                          ),
                          if (isDesk)
                            KSizedBox.kHeightSizedBox24
                          else
                            KSizedBox.kHeightSizedBox16,
                          BoxWidget(
                            key: KWidgetkeys.screen.home.workBox,
                            text: context.l10n.work,
                            onTap: () =>
                                context.goNamedWithScroll(KRoute.work.name),
                            isDesk: isDesk,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else ...[
                HomeBoxWidget(
                  isDesk: isDesk,
                ),
                KSizedBox.kHeightSizedBox16,
                BoxWidget(
                  key: KWidgetkeys.screen.home.discountsBox,
                  text: context.l10n.discountsCoupons,
                  onTap: () => context.goNamedWithScroll(
                    KRoute.discounts.name,
                  ),
                  isDesk: isDesk,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox24
                else
                  KSizedBox.kHeightSizedBox16,
                BoxWidget(
                  key: KWidgetkeys.screen.home.workBox,
                  text: context.l10n.work,
                  onTap: () => context.goNamedWithScroll(KRoute.work.name),
                  isDesk: isDesk,
                ),
              ],
              if (isDesk)
                KSizedBox.kHeightSizedBox24
              else
                KSizedBox.kHeightSizedBox16,
              if (isDesk)
                Row(
                  children: [
                    Expanded(
                      child: BoxWidget(
                        key: KWidgetkeys.screen.home.informationBox,
                        text: context.l10n.information,
                        onTap: () => context.goNamedWithScroll(
                          KRoute.information.name,
                        ),
                        isDesk: isDesk,
                      ),
                    ),
                    KSizedBox.kWidthSizedBox24,
                    Expanded(
                      child: BoxWidget(
                        key: KWidgetkeys.screen.home.storyBox,
                        text: context.l10n.stories,
                        onTap: () =>
                            context.goNamedWithScroll(KRoute.story.name),
                        isDesk: isDesk,
                      ),
                    ),
                    KSizedBox.kWidthSizedBox24,
                    Expanded(
                      child: BoxWidget(
                        key: KWidgetkeys.screen.home.investorsBox,
                        text: context.l10n.investors,
                        onTap: () => context.goNamedWithScroll(
                          KRoute.investors.name,
                        ),
                        isDesk: isDesk,
                      ),
                    ),
                  ],
                )
              else ...[
                BoxWidget(
                  key: KWidgetkeys.screen.home.informationBox,
                  text: context.l10n.information,
                  onTap: () => context.goNamedWithScroll(
                    KRoute.information.name,
                  ),
                  isDesk: isDesk,
                ),
                KSizedBox.kHeightSizedBox16,
                BoxWidget(
                  key: KWidgetkeys.screen.home.storyBox,
                  text: context.l10n.stories,
                  onTap: () => context.goNamedWithScroll(KRoute.story.name),
                  isDesk: isDesk,
                ),
                KSizedBox.kHeightSizedBox16,
                BoxWidget(
                  key: KWidgetkeys.screen.home.investorsBox,
                  text: context.l10n.investors,
                  onTap: () => context.goNamedWithScroll(KRoute.investors.name),
                  isDesk: isDesk,
                ),
              ],
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
            ];

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
              ..addAll([
                if (isDesk)
                  KSizedBox.kHeightSizedBox160
                else
                  KSizedBox.kHeightSizedBox40,
                SizedBox.shrink(
                  key: feedbackKey,
                ),
                if (context.read<FeedbackBloc>().state.formState ==
                        FeedbackEnum.success ||
                    context.read<FeedbackBloc>().state.formState ==
                        FeedbackEnum.sendingMessage)
                  FeedbackBoxWidget(
                    key: feedbackBoxKey,
                    isDesk: isDesk,
                    sendAgain: () => context
                        .read<FeedbackBloc>()
                        .add(const FeedbackEvent.sendignMessageAgain()),
                    feedbackBoxKey: feedbackBoxKey,
                  )
                else
                  ...FeedbackWidget.feedbackWidgetList(
                    isDesk: isDesk,
                    context: context,
                    nameController: nameController,
                    emailController: emailController,
                    messageController: messageController,
                    feedbackKey: feedbackKey,
                  ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox160
                else
                  KSizedBox.kHeightSizedBox10,
              ]);
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
