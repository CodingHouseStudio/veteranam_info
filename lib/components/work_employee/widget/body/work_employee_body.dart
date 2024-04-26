import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class WorkEmployeeBody extends StatelessWidget {
  const WorkEmployeeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
      builder: (context, _) {
        switch (_.loadingStatus) {
          case LoadingStatus.initial:
            return const CircularProgressIndicator.adaptive();
          case LoadingStatus.loading:
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
                  style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
                ),
                KSizedBox.kHeightSizedBox8,
                Text(
                  context.l10n.workSubtitle,
                  style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
                WorkEmployeeFilters(
                  cities: _.workModelItems.overallCities,
                  categories: _.workModelItems.overallCategories,
                  isDesk: isDesk,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox40
                else
                  KSizedBox.kHeightSizedBox24,
                ...List.generate(
                    _.workModelItems.isNotEmpty
                        ? _.filteredWorkModelItems.length
                        : 1, (index) {
                  if (_.workModelItems.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: index != 0 ? KPadding.kPaddingSize40 : 0,
                      ),
                      child: WorkCardWidget(
                        workModel: _.filteredWorkModelItems.elementAt(index),
                        isDesk: isDesk,
                      ),
                    );
                  } else {
                    return TextButton(
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
                    );
                  }
                }),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
                Center(
                  child: PaginationWidget(
                    currentPage: _.page,
                    pages: _.maxPage,
                    changePage: (int page) =>
                        context.read<WorkEmployeeWatcherBloc>().add(
                              WorkEmployeeWatcherEvent.loadPage(
                                page,
                              ),
                            ),
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
