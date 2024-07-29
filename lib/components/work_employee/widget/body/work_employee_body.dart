import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

part '../works_widget_list.dart';

class WorkEmployeeBody extends StatelessWidget {
  const WorkEmployeeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure?.value(context),
        onPressed: () => context
            .read<WorkEmployeeWatcherBloc>()
            .add(const WorkEmployeeWatcherEvent.started()),
      ),
      builder: (context, _) => ScaffoldDecorationNetworkWidget(
        loadDataAgain: () => context
            .read<WorkEmployeeWatcherBloc>()
            .add(const WorkEmployeeWatcherEvent.started()),
        titleChildWidgetsFunction: ({required isDesk}) => [
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
          ...TitleWidget.titleWidgetList(
            title: context.l10n.work,
            titleKey: KWidgetkeys.screen.workEmployee.title,
            subtitle: context.l10n.workSubtitle,
            subtitleKey: KWidgetkeys.screen.workEmployee.subtitle,
            isDesk: isDesk,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
        ],
        mainPadding: ({required isDesk, required maxWidth}) => isDesk
            ? EdgeInsets.symmetric(
                horizontal: maxWidth * KDimensions.paddingMultiply,
                vertical: KPadding.kPaddingSize56,
              )
            : EdgeInsets.zero,
        mainChildWidgetsFunction: ({required isDesk}) => [
          if (_.loadingStatus == LoadingStatus.loaded &&
              _.workModelItems.isNotEmpty)
            WorkEmployeeFilters(
              key: KWidgetkeys.screen.workEmployee.filter,
              cities: _.workModelItems.overallCities,
              categories: _.workModelItems.overallCategories,
              isDesk: isDesk,
            ),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
          if (_.workModelItems.isEmpty &&
              _.loadingStatus == LoadingStatus.loaded &&
              Config.isDevelopment)
            MockButtonWidget(
              key: KWidgetkeys.screen.workEmployee.buttonMock,
              onPressed: () {
                GetIt.I.get<IWorkRepository>().addMockWorks();
                context
                    .read<WorkEmployeeWatcherBloc>()
                    .add(const WorkEmployeeWatcherEvent.started());
              },
            )
          else
            ...worksWidgetList(context: context, isDesk: isDesk),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
          WorkRequestCardWidget(
            key: KWidgetkeys.screen.workEmployee.requestCard,
            isDesk: isDesk,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
          Center(
            child: PaginationWidget(
              key: KWidgetkeys.screen.workEmployee.pagination,
              currentPage: _.page,
              pages: _.maxPage,
              changePage: (int page) {
                context.read<WorkEmployeeWatcherBloc>().add(
                      WorkEmployeeWatcherEvent.loadPage(
                        page,
                      ),
                    );
              },
            ),
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
        ],
      ),
    );
  }
}
