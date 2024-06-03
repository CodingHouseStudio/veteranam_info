import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

part '../box_widget_list.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeWatcherBloc, HomeWatcherState>(
      builder: (context, _) => ScaffoldWidget(
        mainChildWidgetsFunction: ({required isDesk}) {
          final childWidgets = [
            ..._boxWidgetList(context: context, isDesk: isDesk),
            KSizedBox.kHeightSizedBox48,
            if (isDesk)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextPointWidget(
                      context.l10n.whatKindOfProject,
                      key: KWidgetkeys.screen.home.aboutProjecPrefix,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      context.l10n.aboutProject,
                      key: KWidgetkeys.screen.home.aboutProjecSubtitle,
                      style: AppTextStyle.materialThemeDisplayMedium,
                    ),
                  ),
                ],
              )
            else ...[
              TextPointWidget(
                context.l10n.whatKindOfProject,
                key: KWidgetkeys.screen.home.aboutProjecPrefix,
              ),
              KSizedBox.kHeightSizedBox8,
              Text(
                context.l10n.aboutProject,
                key: KWidgetkeys.screen.home.aboutProjecSubtitle,
                style: AppTextStyle.materialThemeDisplayMedium,
              ),
            ],
            if (isDesk)
              KSizedBox.kHeightSizedBox160
            else
              KSizedBox.kHeightSizedBox48,
            if (isDesk)
              HomeScreenCard(
                rightWidget: Padding(
                  padding: const EdgeInsets.only(
                    left: KPadding.kPaddingSize48,
                  ),
                  child: Column(
                    children: HomeScreenCardContent.get(
                      buttonKey: KWidgetkeys.screen.home.discountButton,
                      prefixKey: KWidgetkeys.screen.home.discountPrefix,
                      titleKey: KWidgetkeys.screen.home.discountTitle,
                      subtitleKey: KWidgetkeys.screen.home.discountSubtitle,
                      textPoint: context.l10n.saveMoney,
                      title: context.l10n.discountsServices,
                      subtitle: context.l10n.discountsServicesSubtitle,
                      textButton: context.l10n.toDiscount,
                      route: () => context.goNamed(KRoute.discounts.name),
                      bottomWidget: KSizedBox.kHeightSizedBox90,
                      isDesk: true,
                    ),
                  ),
                ),
                leftWidget: KImage.discountImage
                    .setKey(KWidgetkeys.screen.home.discountImage),
                rightPadding: KPadding.kPaddingSize84,
              )
            else ...[
              KImage.discountImage
                  .setKey(KWidgetkeys.screen.home.discountImage),
              KSizedBox.kWidthSizedBox16,
              ...HomeScreenCardContent.get(
                buttonKey: KWidgetkeys.screen.home.discountButton,
                prefixKey: KWidgetkeys.screen.home.discountPrefix,
                titleKey: KWidgetkeys.screen.home.discountTitle,
                subtitleKey: KWidgetkeys.screen.home.discountSubtitle,
                textPoint: context.l10n.saveMoney,
                title: context.l10n.discountsServices,
                subtitle: context.l10n.discountsServicesSubtitle,
                textButton: context.l10n.toDiscount,
                route: () => context.goNamed(KRoute.discounts.name),
                isDesk: false,
              ),
            ],
            if (isDesk)
              KSizedBox.kHeightSizedBox160
            else
              KSizedBox.kHeightSizedBox40,
            if (isDesk)
              HomeScreenCard(
                leftWidget: Padding(
                  padding: const EdgeInsets.only(
                    right: KPadding.kPaddingSize48,
                  ),
                  child: Column(
                    children: HomeScreenCardContent.get(
                      buttonKey: KWidgetkeys.screen.home.informationButton,
                      prefixKey: KWidgetkeys.screen.home.informationPrefix,
                      subtitleKey: KWidgetkeys.screen.home.informationSubtitle,
                      titleKey: KWidgetkeys.screen.home.informationTitle,
                      textPoint: context.l10n.findOut,
                      title: context.l10n.informationNews,
                      subtitle: context.l10n.informationNewsSubtitle,
                      textButton: context.l10n.toInfomation,
                      route: () => context.goNamed(KRoute.information.name),
                      bottomWidget: KSizedBox.kHeightSizedBox48,
                      isDesk: true,
                    ),
                  ),
                ),
                rightWidget: KImage.inforamationImage
                    .setKey(KWidgetkeys.screen.home.informationImage),
                rightPadding: KPadding.kPaddingSize32,
              )
            else ...[
              KImage.inforamationImage
                  .setKey(KWidgetkeys.screen.home.informationImage),
              KSizedBox.kWidthSizedBox16,
              ...HomeScreenCardContent.get(
                buttonKey: KWidgetkeys.screen.home.informationButton,
                prefixKey: KWidgetkeys.screen.home.informationPrefix,
                subtitleKey: KWidgetkeys.screen.home.informationSubtitle,
                titleKey: KWidgetkeys.screen.home.informationTitle,
                textPoint: context.l10n.findOut,
                title: context.l10n.informationNews,
                subtitle: context.l10n.informationNewsSubtitle,
                textButton: context.l10n.toInfomation,
                route: () => context.goNamed(KRoute.information.name),
                isDesk: false,
              ),
            ],
            if (isDesk)
              KSizedBox.kHeightSizedBox160
            else
              KSizedBox.kHeightSizedBox40,
            // if (Config.isDevelopment) ...[
            //   Stack(
            //     children: [
            //       KImage.workImage,
            //       Center(
            //         child: Column(
            //           children: [
            //             Text(
            //               context.l10n.jobsVacancies,
            //               style: AppTextStyle.materialThemeDisplayLarge,
            //             ),
            //             KSizedBox.kHeightSizedBox16,
            //             Text(
            //               context.l10n.jobsVacanciesSubtitle,
            //               style: AppTextStyle.materialThemeBodyLarge,
            //             ),
            //             KSizedBox.kHeightSizedBox16,
            //             DoubleButtonWidget(
            //               text: context.l10n.toVacancy,
            //               onPressed: () =>
            //                   context.goNamed(KRoute.workEmployee.name),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            //   if (isDesk)
            //     KSizedBox.kHeightSizedBox160
            //   else
            //     KSizedBox.kHeightSizedBox40,
            // ],
          ];

          switch (_) {
            case HomeWatcherStateInitial():
              childWidgets.add(const CircularProgressIndicator.adaptive());
            case HomeWatcherStateLoading():
              childWidgets.add(const CircularProgressIndicator.adaptive());
            case HomeWatcherStateSuccess():
              if (isDesk) {
                childWidgets.add(
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextPointWidget(
                              context.l10n.whatYouMostInterestedIn,
                              key: KWidgetkeys.screen.home.faqPrefix,
                            ),
                            KSizedBox.kHeightSizedBox16,
                            Text(
                              context.l10n.answersYourQuestions,
                              key: KWidgetkeys.screen.home.faqTitle,
                              style: AppTextStyle.materialThemeDisplayLarge,
                            ),
                            KSizedBox.kHeightSizedBox16,
                            Text(
                              context.l10n.questionSubtitle,
                              key: KWidgetkeys.screen.home.faqSubtitle,
                              style: AppTextStyle.materialThemeBodyLarge,
                            ),
                            KSizedBox.kHeightSizedBox16,
                            DoubleButtonWidget(
                              widgetKey: KWidgetkeys.screen.home.faqButton,
                              text: context.l10n.writeMessage,
                              onPressed: null,
                              isDesk: isDesk,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: _.questionModelItems.isNotEmpty
                            ? Column(
                                children: List.generate(
                                    _.questionModelItems.isNotEmpty
                                        ? _.questionModelItems.length
                                        : 1, (index) {
                                  return Padding(
                                    padding: index != 0
                                        ? const EdgeInsets.only(
                                            top: KPadding.kPaddingSize24,
                                          )
                                        : EdgeInsets.zero,
                                    child: QuestionWidget(
                                      key: KWidgetkeys.screen.home.faq,
                                      questionModel:
                                          _.questionModelItems.elementAt(index),
                                      isDesk: true,
                                    ),
                                  );
                                }),
                              )
                            : mockButton(context),
                      ),
                    ],
                  ),
                );
              } else {
                childWidgets.addAll(
                  [
                    TextPointWidget(
                      context.l10n.whatYouMostInterestedIn,
                      key: KWidgetkeys.screen.home.faqPrefix,
                    ),
                    KSizedBox.kHeightSizedBox8,
                    Text(
                      context.l10n.answersYourQuestions,
                      key: KWidgetkeys.screen.home.faqTitle,
                      style: AppTextStyle.materialThemeDisplayLarge,
                    ),
                    KSizedBox.kHeightSizedBox8,
                    Text(
                      context.l10n.questionSubtitle,
                      key: KWidgetkeys.screen.home.faqSubtitle,
                      style: AppTextStyle.materialThemeBodyLarge,
                    ),
                    KSizedBox.kHeightSizedBox8,
                    DoubleButtonWidget(
                      widgetKey: KWidgetkeys.screen.home.faqButton,
                      text: context.l10n.writeMessage,
                      onPressed: null,
                      isDesk: isDesk,
                    ),
                    KSizedBox.kHeightSizedBox24,
                    if (_.questionModelItems.isNotEmpty)
                      ...List.generate(
                          _.questionModelItems.isNotEmpty
                              ? _.questionModelItems.length
                              : 1, (index) {
                        return Padding(
                          padding: index != 0
                              ? const EdgeInsets.only(
                                  top: KPadding.kPaddingSize24,
                                )
                              : EdgeInsets.zero,
                          child: QuestionWidget(
                            key: KWidgetkeys.screen.home.faq,
                            questionModel:
                                _.questionModelItems.elementAt(index),
                            isDesk: false,
                          ),
                        );
                      })
                    else
                      mockButton(context),
                  ],
                );
              }

            case HomeWatcherStateFailure():
              childWidgets.add(const CircularProgressIndicator.adaptive());
          }

          return childWidgets
            ..add(
              isDesk
                  ? KSizedBox.kHeightSizedBox160
                  : KSizedBox.kHeightSizedBox48,
            );
        },
      ),
    );
  }

  Widget mockButton(BuildContext context) => TextButton(
        key: KWidgetkeys.screen.home.buttonMock,
        onPressed: () {
          GetIt.I.get<IHomeRepository>().addMockQuestions();
          context.read<HomeWatcherBloc>().add(
                const HomeWatcherEvent.started(),
              );
        },
        child: Text(
          context.l10n.getMockData,
          style: AppTextStyle.text32,
        ),
      );
}
