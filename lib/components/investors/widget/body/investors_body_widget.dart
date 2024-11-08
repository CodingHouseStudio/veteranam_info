import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/components/investors/investors.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class InvestorsBodyWidget extends StatelessWidget {
  const InvestorsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
        final isTablet =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        final padding = EdgeInsets.symmetric(
          horizontal: (isDesk
              ? KPadding.kPaddingSize90 +
                  ((constraints.maxWidth >
                          KPlatformConstants.maxWidthThresholdTablet)
                      ? (constraints.maxWidth -
                              KPlatformConstants.maxWidthThresholdTablet) /
                          2
                      : 0)
              : KPadding.kPaddingSize16),
        );
        final body = [
          NawbarWidget(isDesk: isDesk, isTablet: isTablet),
          KSizedBox.kHeightSizedBox24,
          if (Config.isWeb)
            Padding(
              padding: padding,
              child: TitlePointWidget(
                title: context.l10n.provideSuggestionsFromBusinesses,
                titleKey: KWidgetkeys.screen.investors.title,
                titleSecondPart: context.l10n.orDonateHere,
                isDesk: isDesk,
                isRightArrow: false,
                titleAlignment: WrapAlignment.end,
                textAlign: TextAlign.end,
              ),
            ),
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else if (Config.isWeb)
            KSizedBox.kHeightSizedBox24,
          Padding(
            padding: padding,
            child: InvestorsDescriptionWidget(
              isDesk: isDesk,
            ),
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else if (Config.isWeb)
            KSizedBox.kHeightSizedBox24,
          Padding(
            padding: padding,
            child: FundsWidgetList(isDesk: isDesk),
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox50
          else
            KSizedBox.kHeightSizedBox24,
        ];
        return BlocListener<NetworkCubit, NetworkStatus>(
          listener: (context, state) {
            if (state == NetworkStatus.network) {
              context.read<InvestorsWatcherBloc>().add(
                    const InvestorsWatcherEvent.started(),
                  );
            }
          },
          child: BlocListener<InvestorsWatcherBloc, InvestorsWatcherState>(
            listener: (context, state) => context.dialog.showGetErrorDialog(
              error: state.failure?.value(context),
              onPressed: () => context
                  .read<InvestorsWatcherBloc>()
                  .add(const InvestorsWatcherEvent.started()),
            ),
            child: Scaffold(
              body: ListView.builder(
                key: KWidgetkeys.widget.scaffold.scroll,
                primary: false,
                itemCount: body.length,
                itemBuilder: (context, index) => body.elementAt(index),
              ),
            ),
          ),
        );
      },
    );
  }
}
