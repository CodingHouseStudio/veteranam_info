import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class DialogsWidget {
  static void showLogoutConfirmationDialog({
    required BuildContext context,
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
                key: KWidgetkeys.widget.dialogs.text,
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

  static void showDeleteConfirmationDialog({
    required BuildContext context,
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
                key: KWidgetkeys.widget.dialogs.text,
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
}
