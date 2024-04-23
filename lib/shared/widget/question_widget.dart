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
      decoration: KWidetTheme.boxDecorationWidget,
      child: ExpansionTile(
        title: Text(
          widget.questionModel.title,
          key: KWidgetkeys.widget.question.title,
          style: widget.isDesk ? AppTextStyle.text40 : AppTextStyle.text18,
          maxLines: 2,
        ),
        onExpansionChanged: (value) => setState(() {
          openQuestion = value;
        }),
        trailing: IconWidget(
          icon: openQuestion
              ? KIcon.minus.setIconKey(
                  KWidgetkeys.widget.question.iconMinus,
                )
              : KIcon.plus.setIconKey(
                  KWidgetkeys.widget.question.iconPlus,
                ),
          background: AppColors.widgetBackground,
        ),
        tilePadding: const EdgeInsets.symmetric(
          horizontal: KPadding.kPaddingSize32,
          vertical: KPadding.kPaddingSize16,
        ),
        childrenPadding: EdgeInsets.only(
          left:
              widget.isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
          bottom: KPadding.kPaddingSize16,
          top: widget.isDesk ? KPadding.kPaddingSize8 : 0,
        ),
        children: [
          Markdown(
            key: KWidgetkeys.widget.question.subtitle,
            data: widget.questionModel.subtitle,
            styleSheet: MarkdownStyleSheet(
              p: widget.isDesk ? AppTextStyle.text24 : AppTextStyle.text14,
            ),
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }
}
