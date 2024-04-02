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
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          key: KWidgetkeys.questionKeys.widget,
          title: Text(
            widget.title,
            key: KWidgetkeys.questionKeys.title,
            style: AppTextStyle.lableL,
            maxLines: 1,
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              openQuestion = expanded;
            });
          },
          trailing: IconWidget(
            icon: openQuestion ? KIcon.minus : KIcon.plus,
            background: AppColors.widgetBackground,
            // padding: KPadding.kPaddingSizeM,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSizeML,
                vertical: KPadding.kPaddingSizeSM,
              ),
              child: Text(
                widget.subtitle,
                key: KWidgetkeys.questionKeys.subtitle,
                style: AppTextStyle.lableM,
                softWrap: true,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
