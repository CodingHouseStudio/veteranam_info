import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/markdown_file_dialog/markdown_file_dialog.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MarkdownFileDialog extends StatelessWidget {
  const MarkdownFileDialog({
    required this.ukFilePath,
    required this.enFilePath,
    required this.startText,
    super.key,
  });
  final String ukFilePath;
  final String? enFilePath;
  final String startText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLayoutBloc, AppLayoutState>(
      builder: (context, state) {
        return AlertDialog(
          key: PrivacyPolicyDialogKeys.dialog,
          shape: KWidgetTheme.outlineBorder,
          backgroundColor: AppColors.materialThemeKeyColorsNeutral,
          clipBehavior: Clip.hardEdge,
          // scrollable: true,
          icon: MarkdownDialogTitleWidget(
            title: startText,
            isTablet: state.appVersionEnum.isTablet,
          ),
          iconPadding: const EdgeInsets.only(
            top: KPadding.kPaddingSize24,
            right: KPadding.kPaddingSize24,
            left: KPadding.kPaddingSize24,
          ),
          contentPadding: EdgeInsets.zero,
          content: MarkdownFileBlocprovider(
            widgetChild: MarkdownFileBody(
              startText: startText,
              isTablet: state.appVersionEnum.isTablet,
            ),
            ukFilePath: ukFilePath,
            enFilePath: enFilePath,
          ),
        );
      },
    );
  }
}
