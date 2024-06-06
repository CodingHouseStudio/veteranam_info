import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/help_find_job/help_find_job.dart';
import 'package:kozak/shared/shared.dart';

part '../page_controller_widget.dart';

part '../respond_container_widget.dart';

class HelpFindJobContact extends StatelessWidget {
  const HelpFindJobContact({
    required this.onNextPressed,
    super.key,
  });

  final VoidCallback onNextPressed;

  @override
  Widget build(BuildContext context) {
    return ScaffoldDecorationWidget(
      titleChildWidgetsFunction: ({required isDesk}) => [
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox16,
        ...TitleWidget.titleWidgetList(
          title: context.l10n.helpFindJobTitle,
          titleKey: KWidgetkeys.screen.helpFindJob.titleContact,
          subtitle: context.l10n.helpFindJobSubtitle,
          subtitleKey: KWidgetkeys.screen.helpFindJob.subtitleContact,
          isDesk: isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox24,
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                isDesk ? KPadding.kPaddingSize220 : KPadding.kPaddingSize8,
          ),
          child: CustomPaint(
            painter: ViewpagerIndicatorWidget(
              pageCount: 3,
              pageTitles: [
                context.l10n.contacts,
                context.l10n.details,
                context.l10n.skills,
              ],
              isDesk: isDesk,
            ),
            child: const SizedBox(
              height: 50,
              width: double.infinity,
            ),
          ),
        ),
      ],
      mainDecoration: KWidgetTheme.boxDecorationWidget,
      mainPadding: ({required isDesk, required maxWidth}) =>
          EdgeInsets.symmetric(
        horizontal: isDesk ? maxWidth * KDimensions.respondPaddingMultiply : 0,
        vertical: isDesk ? KPadding.kPaddingSize40 : KPadding.kPaddingSize24,
      ),
      mainDecorationPadding: ({required isDesk}) => EdgeInsets.all(
        isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      mainChildWidgetsFunction: ({required isDesk}) => [
        ..._respondContainerWidgetList(
          context: context,
          isDesk: isDesk,
          onNextPressed: onNextPressed,
        ),
      ],
    );
  }
}
