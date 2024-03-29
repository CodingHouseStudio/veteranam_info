import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        FilterBoxWidget(
          filters: ['Пільги', 'Житло', 'Гарячі лінії'],
        ),
        FooterDescWidget(),
      ],
    );
  }
}
