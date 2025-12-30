import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/components/information/bloc/information_watcher_bloc.dart';
import 'package:veteranam/shared/extension/list_extension_dart.dart';
import 'package:veteranam/shared/repositories/i_information_repository.dart';
import 'package:veteranam/shared/shared_flutter.dart';

part '../news_widget_list.dart';

class InformationBodyWidget extends StatelessWidget {
  const InformationBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InformationWatcherBloc, InformationWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure?.value(context),
        onPressed: () {},
        // I think this event is not necessary for Stream, but
        // I think it's better to give
        // the user imaginary control over it
        // () => context
        //     .read<InformationWatcherBloc>()
        //     .add(const InformationWatcherEvent.started()),
      ),
      builder: (context, _) => ScaffoldAutoLoadingWidget(
        loadingButtonText: context.l10n.moreNews,
        loadingStatus: _.loadingStatus,
        cardListIsEmpty: _.filteredInformationModelItems.isEmpty,
        // resetFilter: () => context
        //     .read<InformationWatcherBloc>()
        //     .add(const InformationWatcherEvent.filter(-1)),
        // loadDataAgain: () => context
        //     .read<InformationWatcherBloc>()
        //     .add(const InformationWatcherEvent.started()),
        titleChildWidgetsFunction: ({required isDesk}) => [
          KSizedBox.kHeightSizedBox24,
          TitleIconWidget(
            title: context.l10n.verifiedInformation,
            titleKey: InformationKeys.title,
            isDesk: isDesk,
            titleSecondPart: context.l10n.forVeteransAndTheirFamilies,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
          // if (isDesk)
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     TextPointWidget(
          //       context.l10n.information,
          //       hasExpanded: false,
          //     ),
          // KSizedBox.kWidthSizedBox90,
          // Expanded(child: _filter(isDesk: isDesk, context: context))
          //   ],
          // )
          // else
          // ...[
          //   TextPointWidget(context.l10n.information),
          //   KSizedBox.kHeightSizedBox8,
          _filter(isDesk: isDesk, context: context),
          // ],
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
        ],
        mainDeskPadding: ({required maxWidth}) => EdgeInsets.symmetric(
          horizontal: maxWidth * KDimensions.tenPercent,
        ),
        mainChildWidgetsFunction: ({required isDesk}) => [
          if (_.informationModelItems.isEmpty &&
              _.loadingStatus == LoadingStatus.loaded &&
              Config.isDevelopment)
            MockButtonWidget(
              key: InformationKeys.buttonMock,
              onPressed: () {
                GetIt.I.get<IInformationRepository>().addMockInformationItems();
                context
                    .read<InformationWatcherBloc>()
                    .add(const InformationWatcherEvent.started());
              },
            )
          else
            ..._newsWidgetList(
              context: context,
              isDesk: isDesk,
            ),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
          // LoadingButton(
          //   widgetKey: InformationKeys.button,
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
        isListLoadedFull: _.isListLoadedFull,
      ),
    );
  }

  Widget _filter({required bool isDesk, required BuildContext context}) =>
      FilterChipBodyWidget(
        key: InformationKeys.filter,
        filtersItems: context
            .read<InformationWatcherBloc>()
            .state
            .informationModelItems
            .overallItems(
              isEnglish: context.isEnglish,
              getFilter: (item) => [
                TranslateModel(
                  uk: item.categoryUA.first,
                  en: item.category.first,
                ),
              ],
            )
            .map(
              (element) => context
                      .read<InformationWatcherBloc>()
                      .state
                      .filters
                      .contains(element.value)
                  ? element.copyWith(isSelected: true)
                  : element,
            )
            .toList(),
        isDesk: isDesk,
        // onResetValue: () => context.read<InformationWatcherBloc>().add(
        //       const InformationWatcherEvent.filterReset(),
        //     ),
        onSelected: (index) => context.read<InformationWatcherBloc>().add(
              InformationWatcherEvent.filter(
                index,
              ),
            ),
        fullLength: context
            .read<InformationWatcherBloc>()
            .state
            .informationModelItems
            .length,
        filterIsEmpty:
            context.read<InformationWatcherBloc>().state.filters.isEmpty,
      );
}
