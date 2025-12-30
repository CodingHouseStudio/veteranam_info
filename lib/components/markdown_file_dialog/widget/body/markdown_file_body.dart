import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:veteranam/components/markdown_file_dialog/bloc/markdown_file_cubit.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MarkdownFileBody extends StatelessWidget {
  const MarkdownFileBody({
    required this.startText,
    required this.isTablet,
    super.key,
  });
  final String startText;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarkdownFileCubit, String?>(
      builder: (context, _) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: KMinMaxSize.maxWidth768,
              minWidth: KMinMaxSize.maxWidth768,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: KPadding.kPaddingSize24,
                top: KPadding.kPaddingSize16,
                right: KPadding.kPaddingSize24,
                left: KPadding.kPaddingSize24,
              ),
              child: _ == null
                  ? const Padding(
                      padding: EdgeInsets.all(KPadding.kPaddingSize32),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    )
                  : MarkdownBody(
                      key: PrivacyPolicyDialogKeys.text,
                      data: _,
                      styleSheet: MarkdownStyleSheet(
                        horizontalRuleDecoration: const BoxDecoration(
                          border: Border(top: BorderSide()),
                        ),
                        a: isTablet
                            ? AppTextStyle.materialThemeBodyLarge
                            : AppTextStyle.materialThemeBodyMedium,
                      ),
                      onTapLink: (text, href, title) =>
                          context.read<UrlCubit>().copy(text: text),
                    ),
            ),
          ),
        );
      },
    );
  }
}
