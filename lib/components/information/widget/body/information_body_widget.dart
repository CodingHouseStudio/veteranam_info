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
      builder: (context, _) {
        switch (_.loadingStatus) {
          case LoadingStatus.initial:
            return const CircularProgressIndicator.adaptive();
          case LoadingStatus.loading:
            return const CircularProgressIndicator.adaptive();
          case LoadingStatus.loaded:
            return ScaffoldWithNavBar(
              childWidgetsFunction: ({required isDesk}) => [
                if (isDesk)
                  KSizedBox.kHeightSizedBox40
                else
                  KSizedBox.kHeightSizedBox16,
                Text(
                  context.l10n.information,
                  key: KWidgetkeys.screen.information.title,
                  style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
                ),
                KSizedBox.kHeightSizedBox8,
                Text(
                  context.l10n.informationSubtitle,
                  key: KWidgetkeys.screen.information.subtitle,
                  style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
                AuditInspectionInProgresFilters(
                  key: KWidgetkeys.screen.information.filter,
                  filtersItem: _.informationModelItems.overallTags,
                  isDesk: isDesk,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox40
                else
                  KSizedBox.kHeightSizedBox24,
                ...List.generate(
                    _.filteredInformationModelItems.isNotEmpty
                        ? _.filteredInformationModelItems.length
                        : 1, (index) {
                  if (_.informationModelItems.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: index != 0 ? KPadding.kPaddingSize40 : 0,
                      ),
                      child: NewsCardWidget(
                        key: KWidgetkeys.screen.information.card,
                        informationItem:
                            _.filteredInformationModelItems.elementAt(index),
                        isDesk: isDesk,
                      ),
                    );
                  } else {
                    return TextButton(
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
                    );
                  }
                }),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
                Center(
                  child: ButtonWidget(
                    key: KWidgetkeys.screen.information.button,
                    text: context.l10n.moreNews,
                    onPressed: () => context.read<InformationWatcherBloc>().add(
                          const InformationWatcherEvent.loadNextItems(),
                        ),
                    icon: isDesk
                        ? KIcon.refresh.setIconKey(
                            KWidgetkeys.screen.information.buttonIcon,
                          )
                        : null,
                    isDesk: isDesk,
                  ),
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
              ],
            );
          case LoadingStatus.error:
            return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }
}
