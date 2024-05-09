import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class InvestorsBodyWidget extends StatefulWidget {
  const InvestorsBodyWidget({super.key});

  @override
  State<InvestorsBodyWidget> createState() => _InvestorsBodyWidgetState();
}

class _InvestorsBodyWidgetState extends State<InvestorsBodyWidget> {
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
    return BlocBuilder<InvestorsWatcherBloc, InvestorsWatcherState>(
      builder: (context, _) => BlocConsumer<FeedbackBloc, FeedbackState>(
        listener: (context, state) {
          if (state.formState == FeedbackEnum.clear) {
            nameController.clear();
            emailController.clear();
            messageController.clear();
          }
        },
        builder: (context, state) {
          return ScaffoldWidget(
            childWidgetsFunction: ({required isDesk}) {
              final childWidgets = [
                if (isDesk)
                  KSizedBox.kHeightSizedBox40
                else
                  KSizedBox.kHeightSizedBox24,
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
                    context: context,
                    isDesk: isDesk,
                    title: context.l10n.investors,
                    subtitle: context.l10n.investorsSubtitle,
                    messageHint: context.l10n.writeYourSuggenstions,
                    nameController: nameController,
                    emailController: emailController,
                    messageController: messageController,
                    feedbackKey: feedbackKey,
                  ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox40,
                Text(
                  context.l10n.funds,
                  style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
                ),
                KSizedBox.kHeightSizedBox8,
                Text(
                  context.l10n.fundsSubtitle,
                  style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
                ),
                KSizedBox.kHeightSizedBox56,
              ];
              switch (_) {
                case InvestorsWatcherStateIntital():
                  childWidgets.add(const CircularProgressIndicator.adaptive());
                case InvestorsWatcherStateLoading():
                  childWidgets.add(const CircularProgressIndicator.adaptive());
                case InvestorsWatcherStateSuccess():
                  childWidgets.addAll([
                    if (_.fundItems.isNotEmpty)
                      if (isDesk)
                        ...List.generate(
                          (_.fundItems.length / 3).ceil(),
                          (index) => Padding(
                            padding: EdgeInsets.only(
                              top: index == 0 ? 0 : KPadding.kPaddingSize24,
                            ),
                            child: DonatesCardsWidget(
                              key: KWidgetkeys.screen.investors.donateCards,
                              fundItems: _.fundItems.sublist(
                                index * 3,
                                (_.fundItems.length > index * 3 + 3)
                                    ? index * 3 + 3
                                    : _.fundItems.length,
                              ),
                            ),
                          ),
                        )
                      else
                        ...List.generate(
                          _.fundItems.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(
                              top: index == 0 ? 0 : KPadding.kPaddingSize24,
                            ),
                            child: DonateCardWidget(
                              key: KWidgetkeys.screen.investors.donateCards,
                              fundModel: _.fundItems.elementAt(index),
                              isDesk: false,
                              hasSubtitle: true,
                            ),
                          ),
                        )
                    else
                      TextButton(
                        key: KWidgetkeys.screen.home.buttonMock,
                        onPressed: () {
                          GetIt.I.get<IInvestorsRepository>().addMockFunds();
                          context
                              .read<InvestorsWatcherBloc>()
                              .add(const InvestorsWatcherEvent.started());
                        },
                        child: Text(
                          context.l10n.getMockData,
                          style: AppTextStyle.text32,
                        ),
                      ),
                  ]);
                case InvestorsWatcherStateFailure():
                  childWidgets.add(const CircularProgressIndicator.adaptive());
              }
              return childWidgets
                ..add(
                  isDesk
                      ? KSizedBox.kHeightSizedBox56
                      : KSizedBox.kHeightSizedBox40,
                );
            },
          );
        },
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
