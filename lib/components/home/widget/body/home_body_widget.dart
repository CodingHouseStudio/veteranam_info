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
          title: KAppText.questionTitle,
          subtitle: KAppText.questionSubtitle,
        ),
        KSizedBox.kHeightSizedBox30,
        const BoxWidget(
          text: KAppText.footerDiscountsCoupons,
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
