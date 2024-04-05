import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MessageFieldWidget(changeMessage: (_) {}),
        KSizedBox.kHeightSizedBox30,
        const FilterBoxWidget(
          filters: KMockText.filter,
        ),
        KSizedBox.kHeightSizedBox30,
        DropListFieldWidget(
          onChanged: (_) {},
          hintText: '',
          dropDownList: KMockText.dropDownList,
        ),
        KSizedBox.kHeightSizedBox30,
        const QuestionWidget(
          title: KMockText.questionTitle,
          subtitle: KMockText.questionSubtitle,
        ),
        KSizedBox.kHeightSizedBox30,
        BoxWidget(
          text: context.l10n.discountsCoupons,
        ),
        KSizedBox.kHeightSizedBox30,
        const ButtonMobWidget(
          showGoogleIcon: true,
        ),
        KSizedBox.kHeightSizedBox30,
      ],
    );
  }
}
