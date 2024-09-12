import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:veteranam/shared/shared.dart';

class MarkdownLinkWidget extends StatelessWidget {
  const MarkdownLinkWidget({required this.text, super.key, this.textStyle});
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: text,

      // selectable: true,
      styleSheet: MarkdownStyleSheet(
        a: textStyle ?? AppTextStyle.materialThemeBodyLarge,
      ),
      onTapLink: (text, href, title) =>
          context.read<UrlCubit>().launchUrl(url: href),
    );
  }
}
