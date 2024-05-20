import 'package:flutter/material.dart';

import 'package:kozak/shared/shared.dart';

class EmployeeRespondButtonsWidget extends StatelessWidget {
  const EmployeeRespondButtonsWidget({required this.isDesk, super.key});

  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return isDesk
        ? Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  key: KWidgetkeys.screen.employeeRespond.send,
                  text: context.l10n.send,
                  onPressed: null,
                  isDesk: isDesk,
                ),
              ),
              KSizedBox.kWidthSizedBox73,
              Expanded(
                child: ButtonWidget(
                  key: KWidgetkeys.screen.employeeRespond.cancel,
                  text: context.l10n.cancel,
                  onPressed: () => context.goNamedWithScroll(
                    KRoute.workEmployee.name,
                  ),
                  isDesk: isDesk,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          )
        : Column(
            children: [
              ButtonWidget(
                key: KWidgetkeys.screen.employeeRespond.send,
                text: context.l10n.send,
                onPressed: null,
                isDesk: isDesk,
              ),
              KSizedBox.kHeightSizedBox16,
              ButtonWidget(
                key: KWidgetkeys.screen.employeeRespond.cancel,
                text: context.l10n.cancel,
                onPressed: () => context.goNamedWithScroll(
                  KRoute.workEmployee.name,
                ),
                isDesk: isDesk,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ],
          );
  }
}
