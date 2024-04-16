import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ListQuestionWidget extends StatelessWidget {
  const ListQuestionWidget({
    required this.questionModelItem,
    required this.isDesk,
    super.key,
  });

  final QuestionModel questionModelItem;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: KWidgetkeys.screen.home.question,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDesk)
          KSizedBox.kHeightSizedBox48
        else
          KSizedBox.kHeightSizedBox24,
        ListView.builder(
          key: KWidgetkeys.screen.home.questionList,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
              bottom:
                  isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize16,
            ),
            child: QuestionWidget(
              title: questionModelItem.title,
              subtitle: questionModelItem.subtitle,
              isDesk: isDesk,
            ),
          ),
        ),
      ],
    );
  }
}
