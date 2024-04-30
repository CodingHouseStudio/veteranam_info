import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class WorkRespondBodyWidget extends StatelessWidget {
  const WorkRespondBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      childWidgetsFunction: ({required isDesk}) => [
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox24,
        Text(
          context.l10n.respond,
          key: const Key(''),
          style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
        ),
        KSizedBox.kHeightSizedBox30,
        KSizedBox.kHeightSizedBox8,
        Text(
          'test text',
          key: const Key(''),
          style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox120
        else
          KSizedBox.kHeightSizedBox64,
      ],
    );
  }
}
