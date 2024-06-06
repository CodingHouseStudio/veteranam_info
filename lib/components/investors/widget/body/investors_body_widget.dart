import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:skeletonizer/skeletonizer.dart';

part '../funds_widget_list.dart';

class InvestorsBodyWidget extends StatelessWidget {
  const InvestorsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvestorsWatcherBloc, InvestorsWatcherState>(
      builder: (context, _) => ScaffoldWidget(
        mainChildWidgetsFunction: ({required isDesk}) => [
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox40,
          ...TitleWidget.titleWidgetList(
            title: context.l10n.funds,
            titleKey: KWidgetkeys.screen.investors.fundTitle,
            subtitle: context.l10n.fundsSubtitle,
            subtitleKey: KWidgetkeys.screen.investors.fundSubtitle,
            isDesk: isDesk,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
          if (_.fundItems.isEmpty && _.loadingStatus == LoadingStatus.loaded)
            Config.isDevelopment
                ? MockButtonWidget(
                    key: KWidgetkeys.screen.investors.buttonMock,
                    onPressed: () {
                      GetIt.I.get<IInvestorsRepository>().addMockFunds();
                      context
                          .read<InvestorsWatcherBloc>()
                          .add(const InvestorsWatcherEvent.started());
                    },
                  )
                : const SizedBox.shrink()
          else
            ..._fundsWidgetList(context: context, isDesk: isDesk),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox40,
        ],
      ),
    );
  }
}
