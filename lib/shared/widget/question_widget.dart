import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kozak/shared/shared.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    required this.isDesk,
    required this.questionModel,
    super.key,
  });
  final QuestionModel questionModel;
  final bool isDesk;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late bool openQuestion;
  @override
  void initState() {
    openQuestion = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: KWidgetkeys.widget.question.widget,
      decoration: KWidgetTheme.boxDecorationWidget,
      clipBehavior: Clip.hardEdge,
      child: Material(
        type: MaterialType.transparency,
        child: ExpansionTile(
          shape: const Border.fromBorderSide(
            BorderSide(
              color: AppColors.materialThemeKeyColorsNeutral,
              width: 0,
            ),
          ),
          title: Text(
            widget.questionModel.title,
            key: KWidgetkeys.widget.question.title,
            style: widget.isDesk
                ? AppTextStyle.materialThemeHeadlineSmall
                : AppTextStyle.materialThemeTitleLarge,
            maxLines: 2,
          ),
          onExpansionChanged: (value) => setState(() {
            openQuestion = value;
          }),
          trailing: IconWidget(
            icon: openQuestion
                ? KIcon.minus.copyWith(
                    key: KWidgetkeys.widget.question.iconMinus,
                  )
                : KIcon.plus.copyWith(
                    key: KWidgetkeys.widget.question.iconPlus,
                  ),
            padding: KPadding.kPaddingSize12,
            background: AppColors.materialThemeWhite,
          ),
          tilePadding: EdgeInsets.symmetric(
            horizontal: widget.isDesk
                ? KPadding.kPaddingSize32
                : KPadding.kPaddingSize16,
            vertical: KPadding.kPaddingSize16,
          ).copyWith(
            bottom: KPadding.kPaddingSize16,
            right: widget.isDesk
                ? KPadding.kPaddingSize16
                : KPadding.kPaddingSize8,
          ),
          childrenPadding: EdgeInsets.symmetric(
            horizontal: widget.isDesk
                ? KPadding.kPaddingSize16
                : KPadding.kPaddingSize4,
            vertical: KPadding.kPaddingSize16,
          ).copyWith(top: 0),
          children: [
            Markdown(
              key: KWidgetkeys.widget.question.subtitle,
              data: widget.questionModel.subtitle,
              styleSheet: MarkdownStyleSheet(
                p: widget.isDesk
                    ? AppTextStyle.materialThemeBodyLarge
                    : AppTextStyle.materialThemeBodyMedium,
              ),
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
