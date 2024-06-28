import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

part '../funds_widget_list.dart';
part '../investors_image_widget_list.dart';

class InvestorsBodyWidget extends StatelessWidget {
  const InvestorsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvestorsWatcherBloc, InvestorsWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure!.value(context),
        onPressed: () => context
            .read<InvestorsWatcherBloc>()
            .add(const InvestorsWatcherEvent.started()),
      ),
      listenWhen: (previous, current) => current.failure != null,
      builder: (context, _) => ScaffoldAutoLoadingWidget(
        loadingButtonText: context.l10n.moreFunds,
        listCanLoaded: _.fundItems.length > _.loadingFundItems.length,
        mainChildWidgetsFunction: ({required isDesk}) => [
          KSizedBox.kHeightSizedBox24,
          ...TitleWidget.pointTitleWidgetList(
            title: context.l10n.provideSuggestionsFromBusinesses,
            titleKey: KWidgetkeys.screen.investors.title,
            titleSecondPart: context.l10n.orDonateHere,
            pointText: context.l10n.investors,
            pointKey: KWidgetkeys.screen.investors.point,
            isDesk: isDesk,
            isRightArrow: false,
            titleAlignment: WrapAlignment.end,
            textAlign: TextAlign.end,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
          if (isDesk)
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: SectionWidget.get(
                      isTablet: isDesk,
                      textPoint: null,
                      title: context.l10n.supportOurVeterans,
                      subtitle: context.l10n.investorsSubtitle,
                      textButton: context.l10n.writeMessage,
                      route: () => context.goNamed(KRoute.feedback.name),
                      prefixKey: null,
                      titleKey: KWidgetkeys.screen.investors.feedbackTitle,
                      subtitleKey:
                          KWidgetkeys.screen.investors.feedbackSubtitle,
                      buttonKey: KWidgetkeys.screen.investors.feedbackButton,
                    ),
                  ),
                ),
                ..._investorsImageWidgetList(
                  isDesk: true,
                ),
              ],
            )
          else ...[
            ...SectionWidget.get(
              isTablet: isDesk,
              textPoint: null,
              title: context.l10n.supportOurVeterans,
              subtitle: context.l10n.investorsSubtitle,
              textButton: context.l10n.writeMessage,
              route: () => context.goNamed(KRoute.feedback.name),
              prefixKey: null,
              titleKey: KWidgetkeys.screen.investors.feedbackTitle,
              subtitleKey: KWidgetkeys.screen.investors.feedbackSubtitle,
              buttonKey: KWidgetkeys.screen.investors.feedbackButton,
            ),
            KSizedBox.kHeightSizedBox24,
            ..._investorsImageWidgetList(
              isDesk: false,
            ),
          ],
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
          TextPointWidget(
            context.l10n.donateHere,
            key: KWidgetkeys.screen.investors.fundsPoint,
            hasExpanded: false,
          ),
          KSizedBox.kHeightSizedBox8,
          Center(
            child: Text(
              context.l10n.provenFunds,
              key: KWidgetkeys.screen.investors.fundsTitle,
              style: AppTextStyle.materialThemeDisplayMedium,
            ),
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox32
          else
            KSizedBox.kHeightSizedBox24,
          if (_.fundItems.isEmpty &&
              _.loadingStatus == LoadingStatus.loaded &&
              Config.isDevelopment)
            MockButtonWidget(
              key: KWidgetkeys.screen.investors.buttonMock,
              onPressed: () {
                GetIt.I.get<IInvestorsRepository>().addMockFunds();
                context
                    .read<InvestorsWatcherBloc>()
                    .add(const InvestorsWatcherEvent.started());
              },
            )
          else
            ..._fundsWidgetList(context: context, isDesk: isDesk),
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
          // LoadingButton(
          //   widgetKey: KWidgetkeys.screen.investors.button,
          //   isDesk: isDesk,
          //   onPressed: () => context
          //       .read<InvestorsWatcherBloc>()
          //       .add(const InvestorsWatcherEvent.loadeNextItems()),
          //   text: context.l10n.moreFunds,
          // ),
          if (isDesk)
            KSizedBox.kHeightSizedBox50
          else
            KSizedBox.kHeightSizedBox24,
        ],
        scrollFunction: () => context
            .read<InvestorsWatcherBloc>()
            .add(const InvestorsWatcherEvent.loadeNextItems()),
      ),
    );
  }
}
