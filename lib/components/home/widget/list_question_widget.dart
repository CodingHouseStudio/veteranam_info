import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ListQuestionWidget extends StatelessWidget {
  const ListQuestionWidget({
    required this.questionModelItems,
    required this.isDesk,
    super.key,
  });

  final List<QuestionModel> questionModelItems;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: KWidgetkeys.screen.home.question,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.faq,
          key: KWidgetkeys.screen.home.questionListTitle,
          style: isDesk ? AppTextStyle.text96 : AppTextStyle.text48,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox48
        else
          KSizedBox.kHeightSizedBox24,
        ListView.builder(
          key: KWidgetkeys.screen.home.questionList,
          shrinkWrap: true,
          itemCount: questionModelItems.length,
          itemBuilder: (context, index) => Padding(
            padding: questionModelItems.length - 1 != index
                ? EdgeInsets.only(
                    bottom: isDesk
                        ? KPadding.kPaddingSize24
                        : KPadding.kPaddingSize16,
                  )
                : EdgeInsets.zero,
            child: QuestionWidget(
              title: questionModelItems.elementAt(index).title,
              subtitle: questionModelItems.elementAt(index).subtitle,
              isDesk: isDesk,
            ),
          ),
        ),
      ],
    );
  }
}
