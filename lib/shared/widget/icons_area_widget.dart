import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class IconsAreaWidget extends StatelessWidget {
  const IconsAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconWidget(key: KWidgetkeys.iconsAreKeys.plus, icon: KIcon.plus),
        KSizedBox.kHeightSizedBoxS,
        IconWidget(key: KWidgetkeys.iconsAreKeys.person, icon: KIcon.person),
      ],
    );
  }
}
