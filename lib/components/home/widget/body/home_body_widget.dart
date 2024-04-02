import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSizeXXL),
      child: ListView(
        children: [
          KSizedBox.kHeightSizedBoxM,
          MessageFieldWidget(changeMessage: (_) {}),
          KSizedBox.kHeightSizedBoxM,
          const FilterBoxWidget(
            filters: KMockText.filter,
          ),
          KSizedBox.kHeightSizedBoxM,
          DropListFieldWidget(
            onChanged: (_) {},
            hintText: '',
            dropDownList: KMockText.dropDownList,
          ),
          KSizedBox.kHeightSizedBoxM,
          const QuestionWidget(
            title: KAppText.questionTitle,
            subtitle: KAppText.questionSubtitle,
          ),
          KSizedBox.kHeightSizedBoxM,
          const BoxWidget(
            text: KAppText.footerDiscountsCoupons,
          ),
          KSizedBox.kHeightSizedBoxM,
          const FooterDescWidget(),
          KSizedBox.kHeightSizedBoxM,
          InputWriteMsgDesk(changeMessage: (_) {}),
          KSizedBox.kHeightSizedBoxM,
        ],
      ),
    );
  }
}
