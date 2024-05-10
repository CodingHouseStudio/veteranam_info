import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:kozak/shared/shared.dart';

class WorkRespondButtonsWidget extends StatelessWidget {
  const WorkRespondButtonsWidget({required this.isDesk, super.key});

  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return isDesk
        ? Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  key: KWidgetkeys.screen.workRespond.send,
                  text: context.l10n.send,
                  onPressed: null,
                  isDesk: isDesk,
                ),
              ),
              KSizedBox.kWidthSizedBox73,
              Expanded(
                child: ButtonWidget(
                  key: KWidgetkeys.screen.workRespond.cancel,
                  text: context.l10n.cancel,
                  onPressed: null,
                  isDesk: isDesk,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          )
        : Column(
            children: [
              ButtonWidget(
                key: KWidgetkeys.screen.workRespond.send,
                text: context.l10n.send,
                onPressed: null,
                isDesk: isDesk,
              ),
              KSizedBox.kHeightSizedBox16,
              ButtonWidget(
                key: KWidgetkeys.screen.workRespond.cancel,
                text: context.l10n.cancel,
                onPressed: null,
                isDesk: isDesk,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ],
          );
  }
}
