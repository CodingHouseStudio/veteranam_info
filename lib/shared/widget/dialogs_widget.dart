import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

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
    required CardEnum cardEnum,
    // required void Function()? afterEvent,
    required String cardId,
  }) {
    if (isDesk) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) =>
                GetIt.I.get<ReportBloc>()..add(ReportEvent.started(cardId)),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final isDeskValue = constraints.maxWidth >
                    KPlatformConstants.minWidthThresholdTablet;
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(KSize.kRadius32),
                  ),
                  scrollable: true,
                  insetPadding: EdgeInsets.zero,
                  icon: CancelWidget(
                    widgetKey: KWidgetkeys.widget.reportDialog.cancel,
                    onPressed: () => context.pop(),
                  ),
                  iconPadding: const EdgeInsets.all(KPadding.kPaddingSize16)
                      .copyWith(bottom: 0),
                  backgroundColor: AppColors.materialThemeKeyColorsNeutral,
                  actionsOverflowAlignment: OverflowBarAlignment.center,
                  contentPadding: isDeskValue
                      ? const EdgeInsets.only(
                          left: KPadding.kPaddingSize160,
                          right: KPadding.kPaddingSize160,
                          bottom: KPadding.kPaddingSize40,
                        )
                      : const EdgeInsets.symmetric(
                          horizontal: KPadding.kPaddingSize16,
                          vertical: KPadding.kPaddingSize32,
                        ),
                  content: ReportDialogWidget(
                    isDesk: isDeskValue,
                    cardEnum: cardEnum,
                    // afterEvent: afterEvent,
                  ),
                );
              },
            ),
          );
        },
      );
    } else {
      showModalBottomSheet<void>(
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
          create: (context) =>
              GetIt.I.get<ReportBloc>()..add(ReportEvent.started(cardId)),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final isDeskValue =
                  constraints.maxWidth >= KMinMaxSize.maxWidth600;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize16,
                  vertical: KPadding.kPaddingSize32,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: ReportDialogWidget(
                      isDesk: isDeskValue,
                      cardEnum: cardEnum,
                      // afterEvent: afterEvent,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  void showMobileMenuDialog() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      barrierColor: AppColors.materialThemeKeyColorsSecondary.withOpacity(0.2),
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(KSize.kRadius32)),
      ),
      showDragHandle: true,
      backgroundColor: AppColors.materialThemeKeyColorsNeutral,
      builder: (context) => const Padding(
        padding: EdgeInsets.only(
          left: KPadding.kPaddingSize40,
          right: KPadding.kPaddingSize32,
          bottom: KPadding.kPaddingSize32,
          top: KPadding.kPaddingSize16,
        ),
        child: MenuDialogWidget(),
      ),
    );
  }

  void showGetErrorDialog({
    required String? error,
    required void Function() onPressed,
  }) {
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: KWidgetkeys.widget.dialogs.failure,
          backgroundColor: AppColors.materialThemeKeyColorsSecondary,
          content: GetErrorDialogWidget(onPressed: onPressed, error: error),
          duration: const Duration(minutes: 1),
        ),
      );
    }
  }

  void showSendErrorDialog(
    String? error,
  ) {
    if (error != null) {
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

  void showCopyEmailDialog(String? text) {
    if (text != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
    }
  }
}
