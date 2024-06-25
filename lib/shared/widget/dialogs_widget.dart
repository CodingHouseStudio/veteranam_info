import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

extension DiaglogExtention on BuildContext {
  // ignore: library_private_types_in_public_api
  _DialogsWidget get dialog => _DialogsWidget.of(this);
}

class _DialogsWidget {
  _DialogsWidget.of(this.context);
  final BuildContext context;

  void showLogoutConfirmationDialog({
    required bool isDesk,
  }) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          key: KWidgetkeys.widget.dialogs.logOut,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.logOutQuestion,
                key: KWidgetkeys.widget.dialogs.profileText,
                style: isDesk ? AppTextStyle.text48 : AppTextStyle.text24,
              ),
              KSizedBox.kHeightSizedBox10,
              ButtonWidget(
                key: KWidgetkeys.widget.dialogs.confirmButton,
                onPressed: () {
                  context.read<AuthenticationBloc>().add(
                        AuthenticationLogoutRequested(),
                      );
                  context.pop();
                },
                text: context.l10n.yes,
                textStyle: isDesk ? AppTextStyle.text32 : AppTextStyle.text16,
                isDesk: isDesk,
              ),
              KSizedBox.kHeightSizedBox10,
              ButtonWidget(
                key: KWidgetkeys.widget.dialogs.unconfirmButton,
                onPressed: () => context.pop(),
                text: context.l10n.no,
                textStyle: isDesk ? AppTextStyle.text32 : AppTextStyle.text16,
                isDesk: isDesk,
              ),
            ],
          ),
        );
      },
    );
  }

  void showDeleteConfirmationDialog({
    required bool isDesk,
  }) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          key: KWidgetkeys.widget.dialogs.deleteAccount,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.deleteAccountQuestion,
                key: KWidgetkeys.widget.dialogs.profileText,
                style: isDesk ? AppTextStyle.text48 : AppTextStyle.text24,
              ),
              KSizedBox.kHeightSizedBox10,
              ButtonWidget(
                key: KWidgetkeys.widget.dialogs.confirmButton,
                onPressed: () {
                  context.read<AuthenticationBloc>().add(
                        AuthenticationDeleteRequested(),
                      );
                  context.pop();
                },
                text: context.l10n.yes,
                textStyle: isDesk ? AppTextStyle.text32 : AppTextStyle.text16,
                isDesk: isDesk,
              ),
              KSizedBox.kHeightSizedBox10,
              ButtonWidget(
                key: KWidgetkeys.widget.dialogs.unconfirmButton,
                onPressed: () => context.pop(),
                text: context.l10n.no,
                textStyle: isDesk ? AppTextStyle.text32 : AppTextStyle.text16,
                isDesk: isDesk,
              ),
            ],
          ),
        );
      },
    );
  }

  void showReportDialog({
    required bool isDesk,
  }) {
    if (isDesk) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => GetIt.I.get<ReportBloc>(),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(KSize.kRadius32),
              ),
              icon: Align(
                alignment: Alignment.centerRight,
                child: IconButtonWidget(
                  onPressed: () => context.pop(),
                  icon: KIcon.close,
                  background: AppColors.materialThemeWhite,
                  padding: KPadding.kPaddingSize12,
                ),
              ),
              iconPadding: const EdgeInsets.all(KPadding.kPaddingSize16),
              backgroundColor: AppColors.materialThemeKeyColorsNeutral,
              actionsOverflowAlignment: OverflowBarAlignment.center,
              contentPadding: const EdgeInsets.only(
                left: KPadding.kPaddingSize160,
                right: KPadding.kPaddingSize160,
                bottom: KPadding.kPaddingSize40,
              ),
              content: const ReportDialogWidget(isDesk: true),
            ),
          );
        },
      );
    } else {
      showModalBottomSheet<Widget>(
        context: context,
        isScrollControlled: true,
        barrierColor:
            AppColors.materialThemeKeyColorsSecondary.withOpacity(0.2),
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(KSize.kRadius32)),
        ),
        showDragHandle: true,
        backgroundColor: AppColors.materialThemeKeyColorsNeutral,
        builder: (context) => BlocProvider(
          create: (context) => GetIt.I.get<ReportBloc>(),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize16,
              vertical: KPadding.kPaddingSize32,
            ),
            child: ReportDialogWidget(isDesk: false),
          ),
        ),
      );
    }
  }

  void showGetErrorDialog({
    required String error,
    required void Function() onPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: KWidgetkeys.widget.dialogs.failure,
        backgroundColor: AppColors.materialThemeKeyColorsSecondary,
        content: GetErrorDialogWidget(onPressed: onPressed, error: error),
        duration: const Duration(minutes: 1),
      ),
    );
  }

  void showSendErrorDialog(
    String error,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: KWidgetkeys.widget.dialogs.failure,
        content: Text(
          error,
          key: KWidgetkeys.widget.dialogs.failureText,
          style: AppTextStyle.materialThemeBodyLarge,
        ),
        duration: const Duration(minutes: 1),
      ),
    );
  }
}
