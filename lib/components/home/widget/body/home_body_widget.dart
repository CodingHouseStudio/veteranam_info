import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List<int>.generate(100, (index) => index);
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
        PaginationWidget(
          items: items,
          itemBuilder: (context, items) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item ${items[index]}'),
                );
              },
            );
          },
        ),
        KSizedBox.kHeightSizedBox30,
        const ButtonMobWidget(
          showGoogleIcon: true,
        ),
        KSizedBox.kHeightSizedBox30,
        ButtonSecondaryWidget(
          onPressed: () {},
          text: KMockText.title,
          icon: KIcon.plus,
        ),
        KSizedBox.kHeightSizedBox30,
      ],
    );
  }
}
