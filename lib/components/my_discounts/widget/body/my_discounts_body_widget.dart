import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/my_discounts/bloc/my_discounts_watcher_bloc.dart';
import 'package:veteranam/components/my_discounts/my_discounts.dart';
import 'package:veteranam/components/my_discounts/widget/my_discount_page_with_an_empty_profile.dart';
import 'package:veteranam/shared/shared_flutter.dart';

part '../my_discounts_card_widget_list.dart';

class MyDiscountsBodyWidget extends StatelessWidget {
  const MyDiscountsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyWatcherBloc, CompanyWatcherState>(
      listener: (context, state) => context
          .read<MyDiscountsWatcherBloc>()
          .add(const MyDiscountsWatcherEvent.started()),
      listenWhen: (previous, current) =>
          previous.company.id != current.company.id,
      builder: (context, companyState) {
        return BlocConsumer<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
          listener: (context, state) => context.dialog.showGetErrorDialog(
            error: state.failure?.value(context),
            onPressed: () => context
                .read<MyDiscountsWatcherBloc>()
                .add(const MyDiscountsWatcherEvent.started()),
          ),
          builder: (context, _) => ScaffoldAutoLoadingWidget(
            mainDeskPadding: ({required maxWidth}) =>
                const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize100,
              vertical: KPadding.kPaddingSize24,
            ),
            loadingButtonText: context.l10n.moreDiscounts,
            loadingStatus: _.loadingStatus,
            showLoadingWidget: companyState.company.isNotEmpty,
            cardListIsEmpty: _.loadedDiscountsModelItems.isEmpty,
            loadFunction: () => context
                .read<MyDiscountsWatcherBloc>()
                .add(const MyDiscountsWatcherEvent.loadNextItems()),
            emptyWidget: companyState.company.isEmpty
                ? null
                : ({required isDesk}) {
                    return MyDiscountEmptyWidget(isDesk: isDesk);
                  },
            mainChildWidgetsFunction: ({required isDesk}) => [
              if (companyState.company.isEmpty)
                Text(
                  key: MyDiscountsKeys.title,
                  context.l10n.myPublications,
                  style: isDesk
                      ? AppTextStyle.materialThemeDisplayLarge
                      : AppTextStyle.materialThemeDisplaySmall,
                  textAlign: isDesk ? TextAlign.center : TextAlign.start,
                )
              else
                LineTitleIconButtonWidget(
                  title: context.l10n.myPublications,
                  titleKey: MyDiscountsKeys.title,
                  icon: KIcon.plus,
                  iconButtonKey: MyDiscountsKeys.iconAdd,
                  isDesk: isDesk,
                  onPressed: () => context.goNamed(KRoute.discountsAdd.name),
                ),
              KSizedBox.kHeightSizedBox40,
              if (companyState.company.isEmpty)
                MyDiscountPageWithEmptyProfileWidget(isDesk: isDesk)
              else
                ..._myDiscountsCardWidgetList(
                  context: context,
                  isDesk: isDesk,
                ),
              if (isDesk)
                KSizedBox.kHeightSizedBox56
              else
                KSizedBox.kHeightSizedBox32,
            ],
            isListLoadedFull: _.isListLoadedFull,
            // loadFunction: () {
            //   context
            //       .read<MyDiscountsWatcherBloc>()
            //       .add(const MyDiscountsWatcherEvent.started());
            // },
          ),
        );
      },
    );
  }
}
