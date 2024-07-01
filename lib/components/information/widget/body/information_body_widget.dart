import 'package:flutter/cupertino.dart';
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
    late var listCanLoaded = true;
    return BlocConsumer<InformationWatcherBloc, InformationWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure!.value(context),
        onPressed: () => context
            .read<InformationWatcherBloc>()
            .add(const InformationWatcherEvent.started()),
      ),
      listenWhen: (previous, current) {
        listCanLoaded = previous.filteredInformationModelItems.length !=
            current.filteredInformationModelItems.length;
        return current.failure != null;
      },
      builder: (context, _) => ScaffoldAutoLoadingWidget(
        loadingButtonText: context.l10n.moreNews,
        listCanLoaded: _.loadingStatus != LoadingStatus.listLoadedFull,
        cardListIsEmpty: _.filteredInformationModelItems.isEmpty,
        titleChildWidgetsFunction: ({required isDesk}) => [
          KSizedBox.kHeightSizedBox24,
          ...TitleWidget.titleIconWidgetList(
            title: context.l10n.verifiedInformation,
            titleKey: KWidgetkeys.screen.information.title,
            isDesk: isDesk,
            titleSecondPart: context.l10n.forVeteransAndTheirFamilies,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
          if (isDesk)
            Row(
              children: [
                TextPointWidget(
                  context.l10n.information,
                  hasExpanded: false,
                ),
                KSizedBox.kWidthSizedBox90,
                Expanded(child: _filter(isDesk: isDesk, context: context)),
              ],
            )
          else ...[
            TextPointWidget(context.l10n.information),
            KSizedBox.kHeightSizedBox8,
            _filter(isDesk: isDesk, context: context),
          ],
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
        ],
        mainDeskPadding: ({required maxWidth}) => EdgeInsets.symmetric(
          horizontal: maxWidth * KDimensions.paddingMultiply,
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
        loadFunction: () => context.read<InformationWatcherBloc>().add(
              const InformationWatcherEvent.loadNextItems(),
            ),
      ),
    );
  }

  Widget _filter({required bool isDesk, required BuildContext context}) =>
      FiltersChipWidget(
        key: KWidgetkeys.screen.information.filter,
        filtersItems: context
            .read<InformationWatcherBloc>()
            .state
            .informationModelItems
            .overallItems(
              context: context,
              getFilter: (item) => item.category,
              getUAFilter: (item) => item.categoryUA,
            ),
        isDesk: isDesk,
        // onResetValue: () => context.read<InformationWatcherBloc>().add(
        //       const InformationWatcherEvent.filterReset(),
        //     ),
        isSelected: (index) => context
            .read<InformationWatcherBloc>()
            .state
            .filtersIndex
            .contains(index),
        onSelected: (index) => context.read<InformationWatcherBloc>().add(
              InformationWatcherEvent.filter(
                index,
              ),
            ),
        fullLenght: context
            .read<InformationWatcherBloc>()
            .state
            .informationModelItems
            .length,
        filterIsEmpty:
            context.read<InformationWatcherBloc>().state.filtersIndex.isEmpty,
      );
}
