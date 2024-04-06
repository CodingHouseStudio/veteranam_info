import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    required this.title,
    required this.subtitle,
    super.key,
  });
  final String title;
  final String subtitle;

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
      decoration: KWidetTheme.boxDecorationWidget,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                openQuestion = !openQuestion;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize32,
                vertical: KPadding.kPaddingSize16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: AppTextStyle.text40,
                      maxLines: 1,
                    ),
                  ),
                  IconWidget(
                    icon: openQuestion
                        ? KIcon.minus
                            .setIconKey(KWidgetkeys.widget.question.iconMinus)
                        : KIcon.plus
                            .setIconKey(KWidgetkeys.widget.question.iconPlus),
                    background: AppColors.widgetBackground,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: openQuestion,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize32,
                vertical: KPadding.kPaddingSize16,
              ),
              child: Text(
                widget.subtitle,
                style: AppTextStyle.text24,
                softWrap: true,
                maxLines: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
