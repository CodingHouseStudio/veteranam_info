import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MarkdownLinkWidget extends StatelessWidget {
  const MarkdownLinkWidget({
    required this.text,
    required this.isDesk,
    super.key,
    this.textStyle,
    this.showDialogForLink = true,
  });
  final String text;
  final TextStyle? textStyle;
  final bool isDesk;
  final bool showDialogForLink;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: text.replaceAll('\n', '\\\n'),
      // selectable: true,
      styleSheet: MarkdownStyleSheet(
        a: textStyle ?? AppTextStyle.materialThemeBodyLarge,
        p: textStyle,
      ),
      onTapLink: (text, href, title) => href == null
          ? null
          : showDialogForLink
              ? context.openLinkWithAgreeDialog(isDesk: isDesk, link: href)
              : context.read<UrlCubit>().launchUrl(url: href),
    );
  }
}
