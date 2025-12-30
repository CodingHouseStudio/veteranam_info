import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:veteranam/components/my_discounts/bloc/my_discounts_watcher_bloc.dart';
import 'package:veteranam/components/my_discounts/my_discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
      spacing:
          widget.isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize16,
      children: [
        DiscountCardWidget(
          discountItem: widget.discountModel,
          isDesk: widget.isDesk,
          // reportEvent: null,
          share:
              '${KRoute.home.path}${KRoute.discounts.path}/${widget.discountModel.id}',
          // isLoading: widget.isLoading,
          useSiteUrl: true,
          // () => context
          //     .read<DiscountWatcherBloc>()
          //     .add(const DiscountWatcherEvent.getReport()),
          isBusiness: true,
        ),
        if (widget.isDesk)
          Row(
            //mainAxisAlignment: MainAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DiscountStatusWidget(
                key: MyDiscountsKeys.status,
                status: widget.discountModel.status,
                isDesk: widget.isDesk,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: KPadding.kPaddingSize8,
                children: [
                  trashButton(context),
                  editButton,
                  if (widget.discountModel.status.showDeactivateButton)
                    TextButton.icon(
                      onPressed: () {
                        widget.onDeactivate?.call(
                          deactivate: widget.discountModel.status !=
                              DiscountState.deactivated,
                        );
                      },
                      // () {
                      //   widget.discountModel.status ==
                      // DiscountState.published
                      //       ? widget.onDeactivate?.call(
                      //           deactivate: widget.discountModel.status !=
                      //               DiscountState.deactivated,
                      //         )
                      //       : null;
                      // },
                      style: KButtonStyles.borderBlackMyDiscountsButtonStyle,
                      icon: KIcon.close,
                      label: Text(
                        key: MyDiscountsKeys.deactivate,
                        widget.discountModel.status.isPublished
                            ? context.l10n.deactivate
                            : context.l10n.activate,
                        style: AppTextStyle.materialThemeTitleMedium,
                      ),
                    ),
                ],
              ),
            ],
          )
        else ...[
          DiscountStatusWidget(
            key: MyDiscountsKeys.status,
            status: widget.discountModel.status,
            isDesk: widget.isDesk,
          ),
          KSizedBox.kHeightSizedBox16,
          Row(
            mainAxisAlignment: widget.discountModel.status.isPublished
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            spacing: KPadding.kPaddingSize8,
            children: [
              if (widget.discountModel.status.showDeactivateButton)
                TextButton.icon(
                  key: MyDiscountsKeys.deactivate,
                  onPressed: () {
                    widget.onDeactivate?.call(
                      deactivate: widget.discountModel.status !=
                          DiscountState.deactivated,
                    );
                  },
                  style:
                      KButtonStyles.borderBlackMyDiscountsDeactivateButtonStyle,
                  icon: KIcon.close,
                  label: Text(
                    widget.discountModel.status.isPublished
                        ? context.l10n.deactivate
                        : context.l10n.activate,
                    style: AppTextStyle.materialThemeTitleMedium,
                  ),
                ),
              Row(
                spacing: KPadding.kPaddingSize8,
                children: [
                  trashButton(context),
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
        key: MyDiscountsKeys.iconEdit,
        onPressed: () {
          context.goNamed(
            KRoute.discountsEdit.name,
            pathParameters: {
              UrlParameters.cardId: widget.discountModel.id,
            },
            extra: widget.discountModel,
          );
        },
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
        onAppliedPressed: () {
          context.read<MyDiscountsWatcherBloc>().add(
                MyDiscountsWatcherEvent.deleteDiscount(
                  widget.discountModel.id,
                ),
              );
        },
        timer: true,
      ),
      key: MyDiscountsKeys.iconTrash,
      padding: KPadding.kPaddingSize12,
      icon: KIcon.trash,
      buttonStyle: KButtonStyles.borderBlackMyDiscountsTrashButtonStyle,
    );
  }
}
