import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/components/work_employee/bloc/work_employee_watcher_bloc.dart';
import 'package:veteranam/components/work_employee/work_employee.dart';
import 'package:veteranam/shared/repositories/i_work_repository.dart';
import 'package:veteranam/shared/shared_flutter.dart';

part '../works_widget_list.dart';

class WorkEmployeeBody extends StatelessWidget {
  const WorkEmployeeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure?.value(context),
        onPressed: () {},
        // I think this event is not necessary for Stream, but
        // I think it's better to give
        // the user imaginary control over it
        // () => context
        //     .read<WorkEmployeeWatcherBloc>()
        //     .add(const WorkEmployeeWatcherEvent.started()),
      ),
      builder: (context, _) => ScaffoldDecorationWidget(
        // loadDataAgain: () => context
        //     .read<WorkEmployeeWatcherBloc>()
        //     .add(const WorkEmployeeWatcherEvent.started()),
        titleChildWidgetsFunction: ({required isDesk}) => [
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
          TitleWidget(
            title: context.l10n.work,
            titleKey: WorkEmployeeKeys.title,
            subtitle: context.l10n.workSubtitle,
            subtitleKey: WorkEmployeeKeys.subtitle,
            isDesk: isDesk,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
        ],
        mainPadding: ({required isDesk, required maxWidth}) =>
            maxWidth.screenPadding(
          precent: KDimensions.tenPercent,
          notUseHorizontal: isDesk,
          verticalPadding: KPadding.kPaddingSize56,
        ),
        mainChildWidgetsFunction: ({required isDesk}) => [
          if (_.loadingStatus == LoadingStatus.loaded &&
              _.workModelItems.isNotEmpty)
            WorkEmployeeFilters(
              key: WorkEmployeeKeys.filter,
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
              key: WorkEmployeeKeys.buttonMock,
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
            key: WorkEmployeeKeys.requestCard,
            isDesk: isDesk,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
          Center(
            child: PaginationWidget(
              key: WorkEmployeeKeys.pagination,
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
