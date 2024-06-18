import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

part '../news_widget_list.dart';

class InformationBodyWidget extends StatelessWidget {
  const InformationBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InformationWatcherBloc, InformationWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure!.value(context),
        onPressed: () => context
            .read<InformationWatcherBloc>()
            .add(const InformationWatcherEvent.started()),
      ),
      listenWhen: (previous, current) => current.failure != null,
      builder: (context, _) => ScaffoldAutoLoadingWidget(
        titleChildWidgetsFunction: ({required isDesk}) => [
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox16,
          ...TitleWidget.titleWidgetList(
            title: context.l10n.information,
            titleKey: KWidgetkeys.screen.information.title,
            subtitle: context.l10n.informationSubtitle,
            subtitleKey: KWidgetkeys.screen.information.subtitle,
            isDesk: isDesk,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
          FiltersChipWidget(
            key: KWidgetkeys.screen.information.filter,
            filtersItems: _.informationModelItems.overallTags(context),
            isDesk: isDesk,
            // onResetValue: () => context.read<InformationWatcherBloc>().add(
            //       const InformationWatcherEvent.filterReset(),
            //     ),
            isSelected: (index) =>
                context
                    .read<InformationWatcherBloc>()
                    .state
                    .filtersIndex
                    ?.contains(index) ??
                false,
            onSelected: (index) => context.read<InformationWatcherBloc>().add(
                  InformationWatcherEvent.filter(
                    index,
                  ),
                ),
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
        ],
        mainDeskPadding: const EdgeInsets.symmetric(
          horizontal: KPadding.kPaddingSize48,
        ),
        mainChildWidgetsFunction: ({required isDesk}) => [
          if (_.informationModelItems.isEmpty &&
              _.loadingStatus == LoadingStatus.loaded &&
              Config.isDevelopment)
            MockButtonWidget(
              key: KWidgetkeys.screen.information.buttonMock,
              onPressed: () {
                GetIt.I.get<IInformationRepository>().addMockInformationItems();
                context
                    .read<InformationWatcherBloc>()
                    .add(const InformationWatcherEvent.started());
              },
            )
          else
            ..._newsWidgetList(context: context, isDesk: isDesk),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
          // LoadingButton(
          //   widgetKey: KWidgetkeys.screen.information.button,
          //   isDesk: isDesk,
          //   onPressed: () => context.read<InformationWatcherBloc>().add(
          //         const InformationWatcherEvent.loadNextItems(),
          //       ),
          //   text: context.l10n.moreNews,
          // ),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
        ],
        scrollFunction: () => context.read<InformationWatcherBloc>().add(
              const InformationWatcherEvent.loadNextItems(),
            ),
      ),
    );
  }
}
