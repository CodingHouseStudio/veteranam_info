import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class UnderConstructionBodyWidget extends StatelessWidget {
  const UnderConstructionBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk}) => [
        Center(
          child: Text(
            context.l10n.underConstruction,
            key: KWidgetkeys.screen.underConstruction.text,
            style: AppTextStyle.text96,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
