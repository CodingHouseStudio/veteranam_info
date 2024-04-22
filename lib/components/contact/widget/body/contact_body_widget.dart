import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ContactBodyWidget extends StatelessWidget {
  const ContactBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final items = List<int>.generate(100, (index) => index);
    return ScaffoldWithNavBar(
      childWidgetsFunction: ({required isDesk}) => [
        KSizedBox.kHeightSizedBox30,
        FilterBoxWidget(
          filters: KMockText.tags.elementAt(0)!,
        ),
        KSizedBox.kHeightSizedBox30,
        DropListFieldWidget(
          onChanged: (_) {},
          hintText: '',
          dropDownList: KMockText.dropDownList,
        ),
        KSizedBox.kHeightSizedBox30,
        // PaginationWidget(
        //   items: items,
        //   itemBuilder: (context, items) {
        //     return ListView.builder(
        //       physics: const NeverScrollableScrollPhysics(),
        //       shrinkWrap: true,
        //       itemCount: items.length,
        //       itemBuilder: (context, index) {
        //         return ListTile(
        //           title: Text('Item ${items[index]}'),
        //         );
        //       },
        //     );
        //   },
        // ),
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
        const PageIndicatorControl(
          pageCount: 3,
        ),
        KSizedBox.kHeightSizedBox30,
      ],
    );
  }
}
