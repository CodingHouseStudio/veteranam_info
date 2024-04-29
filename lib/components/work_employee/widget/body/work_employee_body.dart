import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class WorkEmployeeBody extends StatefulWidget {
  const WorkEmployeeBody({super.key});

  @override
  State<WorkEmployeeBody> createState() => _WorkEmployeeBodyState();
}

class _WorkEmployeeBodyState extends State<WorkEmployeeBody> {
  late bool loadedState;
  @override
  void initState() {
    loadedState = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
      builder: (context, _) {
        switch (_.loadingStatus) {
          case LoadingStatus.initial:
            return const CircularProgressIndicator.adaptive();
          case LoadingStatus.loading:
            loadedState = true;
            return const CircularProgressIndicator.adaptive();
          case LoadingStatus.loaded:
            return ScaffoldWidget(
              childWidgetsFunction: ({required isDesk}) => [
                if (isDesk)
                  KSizedBox.kHeightSizedBox40
                else
                  KSizedBox.kHeightSizedBox24,
                Text(
                  context.l10n.work,
                  key: KWidgetkeys.screen.workEmployee.title,
                  style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
                ),
                KSizedBox.kHeightSizedBox8,
                Text(
                  context.l10n.workSubtitle,
                  key: KWidgetkeys.screen.workEmployee.subtitle,
                  style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
                WorkEmployeeFilters(
                  key: KWidgetkeys.screen.workEmployee.filter,
                  cities: _.workModelItems.overallCities,
                  categories: _.workModelItems.overallCategories,
                  isDesk: isDesk,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox40
                else
                  KSizedBox.kHeightSizedBox24,
                if (_.workModelItems.isNotEmpty)
                  ...List.generate(_.filteredWorkModelItems.length, (index) {
                    if (index != 0) {
                      loadedState = false;
                    }
                    return Padding(
                      padding: EdgeInsets.only(
                        top: index != 0 ? KPadding.kPaddingSize40 : 0,
                      ),
                      child: WorkCardWidget(
                        key: KWidgetkeys.screen.workEmployee.cards,
                        firstItemIsFirst: !loadedState && index == 0,
                        workModel: _.filteredWorkModelItems.elementAt(index),
                        isDesk: isDesk,
                      ),
                    );
                  })
                else
                  TextButton(
                    key: KWidgetkeys.screen.workEmployee.mockDataButton,
                    onPressed: () {
                      GetIt.I.get<IWorkRepository>().addMockWorks();
                      context
                          .read<WorkEmployeeWatcherBloc>()
                          .add(const WorkEmployeeWatcherEvent.started());
                    },
                    child: Text(
                      context.l10n.getMockData,
                      style: AppTextStyle.text32,
                    ),
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
                      context.read<ScrollCubit>().scrollUp();
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
            );
          case LoadingStatus.error:
            return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }
}
