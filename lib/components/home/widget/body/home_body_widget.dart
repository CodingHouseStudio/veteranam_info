import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:skeletonizer/skeletonizer.dart';

part '../box_widget_list.dart';
part '../question_widget_list.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final aboutProjectKey = GlobalKey();
    return BlocConsumer<HomeWatcherBloc, HomeWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure!.value(context),
        onPressed: () => context
            .read<HomeWatcherBloc>()
            .add(const HomeWatcherEvent.started()),
      ),
      listenWhen: (previous, current) => current.failure != null,
      builder: (context, _) => ScaffoldWidget(
        mainChildWidgetsFunction: ({required isDesk}) => [
          ..._boxWidgetList(
            context: context,
            isDesk: isDesk,
            aboutProjectKey: aboutProjectKey,
          ),
          SizedBox(
            key: aboutProjectKey,
            height: KSize.kPixel48,
          ),
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
            KImage.discountImage.setKey(KWidgetkeys.screen.home.discountImage),
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
          if (isDesk)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: faqTest(context: context, isDesk: isDesk),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: _.questionModelItems.isEmpty &&
                          _.loadingStatus == LoadingStatus.loaded
                      ? Config.isDevelopment
                          ? mockButton(context)
                          : const SizedBox.shrink()
                      : Column(
                          children: _questionWidgetList(
                            context: context,
                            isDesk: isDesk,
                          ),
                        ),
                ),
              ],
            )
          else ...[
            ...faqTest(context: context, isDesk: isDesk),
            KSizedBox.kHeightSizedBox24,
            if (_.questionModelItems.isEmpty &&
                _.loadingStatus == LoadingStatus.loaded)
              Config.isDevelopment
                  ? mockButton(context)
                  : const SizedBox.shrink()
            else
              ..._questionWidgetList(
                context: context,
                isDesk: isDesk,
              ),
          ],
          if (isDesk)
            KSizedBox.kHeightSizedBox160
          else
            KSizedBox.kHeightSizedBox48,
        ],
      ),
    );
  }

  Widget mockButton(BuildContext context) => MockButtonWidget(
        key: KWidgetkeys.screen.home.buttonMock,
        onPressed: () {
          GetIt.I.get<IHomeRepository>().addMockQuestions();
          context.read<HomeWatcherBloc>().add(
                const HomeWatcherEvent.started(),
              );
        },
      );

  List<Widget> faqTest({
    required BuildContext context,
    required bool isDesk,
  }) =>
      [
        TextPointWidget(
          context.l10n.whatYouMostInterestedIn,
          key: KWidgetkeys.screen.home.faqPrefix,
        ),
        if (isDesk) KSizedBox.kHeightSizedBox16 else KSizedBox.kHeightSizedBox8,
        Text(
          context.l10n.answersYourQuestions,
          key: KWidgetkeys.screen.home.faqTitle,
          style: isDesk
              ? AppTextStyle.materialThemeDisplayLarge
              : AppTextStyle.materialThemeDisplaySmall,
        ),
        if (isDesk) KSizedBox.kHeightSizedBox16 else KSizedBox.kHeightSizedBox8,
        Text(
          context.l10n.questionSubtitle,
          key: KWidgetkeys.screen.home.faqSubtitle,
          style: isDesk
              ? AppTextStyle.materialThemeBodyLarge
              : AppTextStyle.materialThemeBodyMedium,
        ),
        KSizedBox.kHeightSizedBox16,
        DoubleButtonWidget(
          widgetKey: KWidgetkeys.screen.home.faqButton,
          text: context.l10n.writeMessage,
          onPressed: () => context.goNamed(KRoute.feedback.name),
          isDesk: isDesk,
        ),
      ];
}
