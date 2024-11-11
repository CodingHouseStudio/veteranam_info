import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/components/home/home.dart';
import 'package:veteranam/components/home/widget/box_widget_list.dart';
import 'package:veteranam/components/home/widget/question_widget_list.dart';
import 'package:veteranam/shared/repositories/i_faq_repository.dart';
import 'package:veteranam/shared/shared_flutter.dart';

part '../home_section_widget_list.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final aboutProjectKey = GlobalKey();
    return BlocConsumer<HomeWatcherBloc, HomeWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure?.value(context),
        onPressed: () => context
            .read<HomeWatcherBloc>()
            .add(const HomeWatcherEvent.started()),
      ),
      builder: (context, _) => ScaffoldWidget(
        hasFooter: true,
        pageName: context.l10n.settings,
        // showMobileNawbar: true,
        loadDataAgain: () => context
            .read<HomeWatcherBloc>()
            .add(const HomeWatcherEvent.started()),
        mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
          BoxWidgetList(
            // context: context,
            isDesk: isDesk,
            isTablet: isTablet,
            aboutProjectKey: aboutProjectKey,
          ),
          SizedBox(
            key: aboutProjectKey,
            height: KSize.kPixel48,
          ),
          Text(
            context.l10n.aboutProject,
            key: KWidgetkeys.screen.home.aboutProjecSubtitle,
            style: isDesk
                ? AppTextStyle.materialThemeDisplayMedium
                : isTablet
                    ? AppTextStyle.materialThemeDisplaySmall
                    : AppTextStyle.materialThemeHeadlineSmall,
          ),
          // if (isDesk)
          //   Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Expanded(
          //         child: TextPointWidget(
          //           context.l10n.whatKindOfProject,
          //           key: KWidgetkeys.screen.home.aboutProjecPrefix,
          //         ),
          //       ),
          //       Expanded(
          //         flex: 3,
          //         child: Text(
          //           context.l10n.aboutProject,
          //           key: KWidgetkeys.screen.home.aboutProjecSubtitle,
          //           style: AppTextStyle.materialThemeDisplayMedium,
          //         ),
          //       ),
          //     ],
          //   )
          // else ...[
          //   TextPointWidget(
          //     context.l10n.whatKindOfProject,
          //     key: KWidgetkeys.screen.home.aboutProjecPrefix,
          //   ),
          //   if (isTablet)
          //     KSizedBox.kHeightSizedBox24
          //   else
          //     KSizedBox.kHeightSizedBox8,
          //   Text(
          //     context.l10n.aboutProject,
          //     key: KWidgetkeys.screen.home.aboutProjecSubtitle,
          //     style: isTablet
          //         ? AppTextStyle.materialThemeDisplaySmall
          //         : AppTextStyle.materialThemeHeadlineSmall,
          //   ),
          // ],

          if (isTablet)
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
                  children:
                      getDiscountSection(context: context, isTablet: isTablet),
                ),
              ),
              leftWidget: KImage.discountImage(
                key: KWidgetkeys.screen.home.discountImage,
              ),
              rightPadding: KPadding.kPaddingSize84,
            )
          else ...[
            KImage.discountImage(key: KWidgetkeys.screen.home.discountImage),
            if (isTablet)
              KSizedBox.kHeightSizedBox48
            else
              KSizedBox.kHeightSizedBox16,
            ...getDiscountSection(context: context, isTablet: isTablet),
          ],

          if (Config.isDevelopment) ...[
            if (isTablet)
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
                    children: getInformationSection(
                      context: context,
                      isTablet: isTablet,
                    ),
                  ),
                ),
                rightWidget: KImage.inforamationImage(
                  key: KWidgetkeys.screen.home.informationImage,
                ),
                rightPadding: KPadding.kPaddingSize32,
              )
            else ...[
              KImage.inforamationImage(
                key: KWidgetkeys.screen.home.informationImage,
              ),
              if (isTablet)
                KSizedBox.kWidthSizedBox48
              else
                KSizedBox.kHeightSizedBox16,
              ...getInformationSection(context: context, isTablet: isTablet),
            ],
          ],
          if (isDesk || isTablet)
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
                    children: getFAQSection(context: context, isDesk: true),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: _.questionModelItems.isEmpty &&
                          _.loadingStatus == LoadingStatus.loaded &&
                          Config.isDevelopment
                      ? mockButton(context)
                      : Column(
                          children: [
                            QuestionWidgetList(
                              // context: context,
                              isDesk: isDesk,
                            ),
                          ],
                        ),
                ),
              ],
            )
          else ...[
            ...getFAQSection(context: context, isDesk: isTablet),
            if (isTablet)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
            if (_.questionModelItems.isEmpty &&
                _.loadingStatus == LoadingStatus.loaded)
              Config.isDevelopment
                  ? mockButton(context)
                  : const SizedBox.shrink()
            else
              QuestionWidgetList(
                // context: context,
                isDesk: isDesk,
              ),
          ],

          if (isDesk)
            KSizedBox.kHeightSizedBox160
          else if (isTablet)
            KSizedBox.kHeightSizedBox64
          else
            KSizedBox.kHeightSizedBox48,
        ],
      ),
    );
  }

  Widget mockButton(BuildContext context) => MockButtonWidget(
        key: KWidgetkeys.screen.home.buttonMock,
        onPressed: () {
          GetIt.I.get<IFaqRepository>().addMockQuestions();
          context.read<HomeWatcherBloc>().add(
                const HomeWatcherEvent.started(),
              );
        },
      );
}
