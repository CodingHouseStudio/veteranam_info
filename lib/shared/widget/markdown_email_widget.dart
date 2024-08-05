import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:veteranam/shared/shared.dart';

class MarkdownEmailWidget extends StatelessWidget {
  const MarkdownEmailWidget({
    required this.data,
    super.key,
    this.padding,
    this.textStyle,
  });
  final String data;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      key: KWidgetkeys.screen.privacyPolicy.text,
      data: data,
      styleSheet: MarkdownStyleSheet(
        a: textStyle ?? AppTextStyle.materialThemeBodyLarge,
      ),
      onTapLink: (text, href, title) => context.read<UrlCubit>().launchUrl(
            url: text,
            scheme: KAppText.emailScheme,
          ),
    );
  }
}
