import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KSizedBox.kHeightSizedBox30,
        const ProfileCardWidget(),
        KSizedBox.kHeightSizedBox30,
        CheckPointWidget(
          onChanged: ({required isCheck}) {},
        ),
        KSizedBox.kHeightSizedBox30,
      ],
    );
  }
}
