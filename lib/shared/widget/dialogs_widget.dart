import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            children: <Widget>[
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
            children: <Widget>[
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

  void showGetErrorDialog({
    required String error,
    required void Function() onPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: KWidgetkeys.widget.dialogs.failure,
        backgroundColor: AppColors.materialThemeKeyColorsSecondary,
        content: Row(
          children: [
            Expanded(
              child: Text(
                error,
                key: KWidgetkeys.widget.dialogs.failureText,
                style: AppTextStyle.materialThemeTitleMedium,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        key: KWidgetkeys.widget.dialogs.failureButton,
                        style: KButtonStyles.whiteSnackBarButtonStyle,
                        onPressed: () {
                          onPressed();
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                        child: Text(
                          context.l10n.tryItAgain,
                          style: AppTextStyle.materialThemeTitleMedium,
                        ),
                      ),
                    ),
                  ),
                  KSizedBox.kWidthSizedBox12,
                  IconButtonWidget(
                    icon: KIcon.close.copyWith(weight: 300),
                    onPressed: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                    background: AppColors.materialThemeWhite,
                    padding: KPadding.kPaddingSize10,
                  ),
                ],
              ),
            ),
          ],
        ),
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
