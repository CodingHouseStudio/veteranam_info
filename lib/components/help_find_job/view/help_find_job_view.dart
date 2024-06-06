import 'package:flutter/material.dart';
import 'package:kozak/components/help_find_job/help_find_job.dart';
import 'package:kozak/shared/constants/constants.dart';

class HelpFindJobScreen extends StatelessWidget {
  const HelpFindJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HelpFindJobBlocprovider(
      key: KWidgetkeys.screen.helpFindJob.screen,
      childWidget: const PageViewController(),
    );
  }
}
