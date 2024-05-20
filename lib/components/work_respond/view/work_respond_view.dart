import 'package:flutter/material.dart';
import 'package:kozak/components/work_respond/widget/body/work_respond_body.dart';
import 'package:kozak/shared/constants/constants.dart';

class WorkRespondScreen extends StatelessWidget {
  const WorkRespondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkRespondBodyWidget(
      key: KWidgetkeys.screen.workRespond.screen,
    );
  }
}
