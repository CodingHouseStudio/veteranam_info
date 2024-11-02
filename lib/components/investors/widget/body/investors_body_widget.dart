import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/components/investors/investors.dart';
import 'package:veteranam/components/investors/widget/investors_description_widget.dart';
import 'package:veteranam/shared/repositories/i_investors_repository.dart';
import 'package:veteranam/shared/shared_flutter.dart';

part '../funds_widget_list.dart';
part '../investors_image_widget_list.dart';

class InvestorsBodyWidget extends StatelessWidget {
  const InvestorsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const isDesk = true;
    final body = [
      const NawbarWidget(isDesk: isDesk, isTablet: false),
      KSizedBox.kHeightSizedBox24,
      if (Config.isWeb)
        TitlePointWidget(
          title: context.l10n.provideSuggestionsFromBusinesses,
          titleKey: KWidgetkeys.screen.investors.title,
          titleSecondPart: context.l10n.orDonateHere,
          // pointText: context.l10n.investors,
          // pointKey: KWidgetkeys.screen.investors.point,
          isDesk: isDesk,
          isRightArrow: false,
          titleAlignment: WrapAlignment.end,
          textAlign: TextAlign.end,
        ),
      if (isDesk)
        KSizedBox.kHeightSizedBox40
      else if (Config.isWeb)
        KSizedBox.kHeightSizedBox24,
      InvestorsDescriptionWidget(
        isDesk: isDesk,
      ),
      if (isDesk)
        KSizedBox.kHeightSizedBox40
      else if (Config.isWeb)
        KSizedBox.kHeightSizedBox24,
      // TextPointWidget(
      //   context.l10n.donateHere,
      //   key: KWidgetkeys.screen.investors.fundsPoint,
      //   hasExpanded: false,
      // ),
      // KSizedBox.kHeightSizedBox8,
      FundsWidgetList(isDesk: isDesk),
      if (isDesk) KSizedBox.kHeightSizedBox40 else KSizedBox.kHeightSizedBox24,
      // LoadingButton(
      //   widgetKey: KWidgetkeys.screen.investors.button,
      //   isDesk: isDesk,
      //   onPressed: () => context
      //       .read<InvestorsWatcherBloc>()
      //       .add(const InvestorsWatcherEvent.loadNextItems()),
      //   text: context.l10n.moreFunds,
      // ),
      if (isDesk) KSizedBox.kHeightSizedBox50 else KSizedBox.kHeightSizedBox24,
    ];
    return BlocListener<InvestorsWatcherBloc, InvestorsWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure?.value(context),
        onPressed: () => context
            .read<InvestorsWatcherBloc>()
            .add(const InvestorsWatcherEvent.started()),
      ),
      child: Scaffold(
        body: ListView.builder(
          itemCount: body.length,
          padding: EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize100),
          itemBuilder: (context, index) => body.elementAt(index),
          // loadFunction: () => context
          //     .read<InvestorsWatcherBloc>()
          //     .add(const InvestorsWatcherEvent.loadNextItems()),
        ),
      ),
    );
  }
}
