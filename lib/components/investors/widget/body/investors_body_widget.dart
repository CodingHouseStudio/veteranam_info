import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

part '../feedback_widget_list.dart';

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
            mainChildWidgetsFunction: ({required isDesk}) {
              final childWidgets = _feedbackWidgetList(
                context: context,
                isDesk: isDesk,
                nameController: nameController,
                emailController: emailController,
                messageController: messageController,
                feedbackKey: feedbackKey,
                feedbackBoxKey: feedbackBoxKey,
              );
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
                              key: KWidgetkeys.screen.investors.donateCard,
                              fundModel: _.fundItems.elementAt(index),
                              isDesk: false,
                              hasSubtitle: true,
                            ),
                          ),
                        )
                    else
                      TextButton(
                        key: KWidgetkeys.screen.investors.buttonMock,
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
