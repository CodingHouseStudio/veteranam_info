import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class MyDiscountsCard extends StatefulWidget {
  const MyDiscountsCard({
    required this.discountModel,
    required this.isDesk,
    required this.isLoading,
    this.onDeactivate,
    super.key,
  });

  final bool isDesk;
  final DiscountModel discountModel;
  final bool isLoading;
  final void Function({required bool deactivate})? onDeactivate;

  @override
  State<MyDiscountsCard> createState() => _MyDiscountsCardState();
}

class _MyDiscountsCardState extends State<MyDiscountsCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DiscountCardWidget(
          discountItem: widget.discountModel,
          isDesk: widget.isDesk,
          // reportEvent: null,
          share:
              '${KRoute.home.path}${KRoute.discounts.path}/${widget.discountModel.id}',
          isLoading: widget.isLoading,
          useSiteUrl: true,
          // () => context
          //     .read<DiscountWatcherBloc>()
          //     .add(const DiscountWatcherEvent.getReport()),
          isBusiness: true,
        ),
        if (widget.isDesk)
          KSizedBox.kHeightSizedBox24
        else
          KSizedBox.kHeightSizedBox16,
        if (widget.isDesk)
          Row(
            //mainAxisAlignment: MainAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DiscountStatusWidget(
                key: KWidgetkeys.screen.myDiscounts.status,
                status: widget.discountModel.status,
                isDesk: widget.isDesk,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  trashButton(context),
                  KSizedBox.kWidthSizedBox8,
                  editButton,
                  if (widget.discountModel.status == DiscountState.published)
                    Padding(
                      padding:
                          const EdgeInsets.only(left: KPadding.kPaddingSize8),
                      child: TextButton.icon(
                        onPressed: () => widget.onDeactivate?.call(
                          deactivate: true,
                        ),
                        // () {
                        //   widget.discountModel.status ==
                        // DiscountState.published
                        //       ? widget.onDeactivate?.call(
                        //           deactivate: widget.discountModel.status !=
                        //               DiscountState.deactivated,
                        //         )
                        //       : null;
                        // },
                        style: KButtonStyles.borderBlackButtonStyle.copyWith(
                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.only(
                              top: KPadding.kPaddingSize20,
                              bottom: KPadding.kPaddingSize20,
                              right: KPadding.kPaddingSize16,
                              left: KPadding.kPaddingSize8,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        icon: KIcon.close,
                        label: Text(
                          key: KWidgetkeys.screen.myDiscounts.deactivate,
                          context.l10n.deactivate,
                          style: AppTextStyle.materialThemeTitleMedium,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          )
        else ...[
          DiscountStatusWidget(
            key: KWidgetkeys.screen.myDiscounts.status,
            status: widget.discountModel.status,
            isDesk: widget.isDesk,
          ),
          KSizedBox.kHeightSizedBox16,
          Row(
            mainAxisAlignment:
                widget.discountModel.status == DiscountState.published
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.end,
            children: [
              if (widget.discountModel.status == DiscountState.published)
                TextButton.icon(
                  key: KWidgetkeys.screen.myDiscounts.deactivate,
                  onPressed: () => widget.onDeactivate?.call(
                    deactivate: true,
                  ),
                  // () {
                  //   widget.discountModel.status == DiscountState.published
                  //       ? widget.onDeactivate?.call(
                  //           deactivate: widget.discountModel.status !=
                  //               DiscountState.deactivated,
                  //         )
                  //       : null;
                  // },
                  style: KButtonStyles.borderBlackButtonStyle.copyWith(
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.only(
                        top: KPadding.kPaddingSize12,
                        bottom: KPadding.kPaddingSize12,
                        right: KPadding.kPaddingSize16,
                        left: KPadding.kPaddingSize8,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  icon: KIcon.close,
                  label: Text(
                    context.l10n.deactivate,
                    style: AppTextStyle.materialThemeTitleMedium,
                  ),
                ),
              Row(
                children: [
                  trashButton(context),
                  KSizedBox.kWidthSizedBox8,
                  editButton,
                ],
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget get editButton => IconButtonWidget(
        key: KWidgetkeys.screen.myDiscounts.iconEdit,
        onPressed: () => context.goNamed(
          KRoute.discountsAdd.name,
          queryParameters: DiscountURLConverter.toJson(widget.discountModel),
        ),
        icon: KIcon.edit,
        buttonStyle: KButtonStyles.circularBorderBlackButtonStyle,
      );

  Widget trashButton(BuildContext context) {
    return IconButtonWidget(
      onPressed: () => context.dialog.showConfirmationDialog(
        isDesk: widget.isDesk,
        title: context.l10n.deleteDiscount,
        subtitle: context.l10n.deleteDiscountQuestion,
        confirmText: context.l10n.delete,
        unconfirmText: context.l10n.continueWorking,
        confirmButtonBackground: AppColors.materialThemeKeyColorsSecondary,
        onPressed: () {
          context.read<MyDiscountsWatcherBloc>().add(
                MyDiscountsWatcherEvent.deleteDiscount(
                  widget.discountModel.id,
                ),
              );
          context.pop();
        },
      ),
      key: KWidgetkeys.screen.myDiscounts.iconTrash,
      padding: KPadding.kPaddingSize12,
      icon: KIcon.trash,
      buttonStyle: KButtonStyles.borderBlackButtonStyle.copyWith(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.all(
            KPadding.kPaddingSize12,
          ),
        ),
      ),
    );
  }
}
