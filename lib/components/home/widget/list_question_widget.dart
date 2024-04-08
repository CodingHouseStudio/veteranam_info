import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ListQuestionWidget extends StatelessWidget {
  const ListQuestionWidget({required this.questionModelItems, super.key});
  final List<QuestionModel> questionModelItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: KWidgetkeys.screen.home.question,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.faq,
          key: KWidgetkeys.screen.home.questionListTitle,
          style: AppTextStyle.text96,
        ),
        KSizedBox.kHeightSizedBox48,
        ListView.builder(
          key: KWidgetkeys.screen.home.questionList,
          shrinkWrap: true,
          itemCount: questionModelItems.length,
          itemBuilder: (context, index) => Column(
            children: [
              QuestionWidget(
                title: questionModelItems.elementAt(index).title,
                subtitle: questionModelItems.elementAt(index).subtitle,
              ),
              KSizedBox.kHeightSizedBox24,
            ],
          ),
        ),
      ],
    );
  }
}
