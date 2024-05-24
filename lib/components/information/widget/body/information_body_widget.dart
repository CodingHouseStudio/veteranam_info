import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class InformationBodyWidget extends StatelessWidget {
  const InformationBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InformationWatcherBloc, InformationWatcherState>(
      builder: (context, _) => ScaffoldWidget(
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
          InformationFilters(
            key: KWidgetkeys.screen.information.filter,
            filtersItem: _.informationModelItems.overallTags,
            isDesk: isDesk,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
        ],
        mainDeskPadding:
            const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize48),
        mainChildWidgetsFunction: ({required isDesk}) {
          final childWidgets = <Widget>[];

          switch (_.loadingStatus) {
            case LoadingStatus.initial:
              childWidgets.add(const CircularProgressIndicator.adaptive());
            case LoadingStatus.loading:
              childWidgets.add(const CircularProgressIndicator.adaptive());
            case LoadingStatus.loaded:
              childWidgets.addAll([
                if (_.informationModelItems.isNotEmpty)
                  ...List.generate(_.filteredInformationModelItems.length,
                      (index) {
                    return Padding(
                      padding: index != 0
                          ? EdgeInsets.only(
                              top: isDesk
                                  ? KPadding.kPaddingSize40
                                  : KPadding.kPaddingSize24,
                            )
                          : EdgeInsets.zero,
                      child: NewsCardWidget(
                        key: KWidgetkeys.screen.information.card,
                        informationItem:
                            _.filteredInformationModelItems.elementAt(index),
                        isDesk: isDesk,
                      ),
                    );
                  })
                else
                  TextButton(
                    key: KWidgetkeys.screen.information.buttonMock,
                    onPressed: () {
                      GetIt.I
                          .get<IInformationRepository>()
                          .addMockInformationItems();
                      context
                          .read<InformationWatcherBloc>()
                          .add(const InformationWatcherEvent.started());
                    },
                    child: Text(
                      context.l10n.getMockData,
                      style: AppTextStyle.text32,
                    ),
                  ),
              ]);

            case LoadingStatus.error:
              childWidgets.add(const CircularProgressIndicator.adaptive());
          }
          return childWidgets
            ..addAll([
              if (isDesk)
                KSizedBox.kHeightSizedBox56
              else
                KSizedBox.kHeightSizedBox24,
              LoadingButton(
                key: KWidgetkeys.screen.information.button,
                isDesk: isDesk,
                onPressed: () => context.read<InformationWatcherBloc>().add(
                      const InformationWatcherEvent.loadNextItems(),
                    ),
                iconKey: KWidgetkeys.screen.information.buttonIcon,
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox56
              else
                KSizedBox.kHeightSizedBox24,
            ]);
        },
      ),
    );
  }
}
