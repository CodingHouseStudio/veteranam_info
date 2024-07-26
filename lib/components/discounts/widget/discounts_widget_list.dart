part of 'body/discounts_body_widget.dart';

List<Widget> discountsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final items = cardWidgetList<DiscountModel>(
    loadingStatus: context.read<DiscountWatcherBloc>().state.loadingStatus,
    modelItems:
        context.read<DiscountWatcherBloc>().state.filteredDiscountModelItems,
    cardWidget: ({required modelItem, required isLoading}) =>
        DiscountCardWidget(
      key: KWidgetkeys.screen.discounts.card,
      discountItem: modelItem,
      isDesk: isDesk,
      reportEvent: null,
      // () => context
      //     .read<DiscountWatcherBloc>()
      //     .add(const DiscountWatcherEvent.getReport()),
    ),
    isDesk: isDesk,
    shimmerItemsNumber: KDimensions.shimmerDiscountsItems,
    isNotFailure: context.read<DiscountWatcherBloc>().state.failure == null,
    shimmerItem: KMockText.discountModel,
  );

  final finalList = <Widget>[];
  for (var i = 0; i < items.length; i++) {
    finalList.add(items[i]);
    if ((i + 1) % (KDimensions.loadItems * 3) == 0 &&
        context.read<DiscountWatcherBloc>().state.loadingStatus !=
            LoadingStatus.listLoadedFull) {
      final controller = TextEditingController();
      finalList.add(
        BlocProvider(
          create: (context) => GetIt.I.get<DiscountLinkFormBloc>(),
          child: BlocConsumer<DiscountLinkFormBloc, DiscountLinkFormState>(
            listener: (context, state) {
              if (state.formState == LinkEnum.sending) {
                controller.clear();
              }
              if (state.formState == LinkEnum.success) {
                context.read<DiscountLinkCubit>().started();
              }
            },
            builder: (context, _) => NotificationLinkWidget(
              onChanged: (text) => context.read<DiscountLinkFormBloc>().add(
                    DiscountLinkFormEvent.updateLink(text),
                  ),
              isDesk: isDesk,
              title: context.l10n.discountLinkTitle,
              sendOnPressed: () => context.read<DiscountLinkFormBloc>().add(
                    const DiscountLinkFormEvent.sendLink(),
                  ),
              fieldController: controller,
              filedErrorText:
                  context.read<DiscountLinkFormBloc>().state.formState ==
                          LinkEnum.invalidData
                      ? context
                          .read<DiscountLinkFormBloc>()
                          .state
                          .link
                          .error
                          .value(context)
                      : null,
              enabled: context.read<DiscountLinkCubit>().state,
              showThankText:
                  context.read<DiscountLinkFormBloc>().state.formState ==
                          LinkEnum.sending ||
                      context.read<DiscountLinkFormBloc>().state.formState ==
                          LinkEnum.success,
            ),
          ),
        ),
      );
    }
  }
  return finalList;
}
