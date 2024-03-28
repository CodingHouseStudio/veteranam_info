import 'package:flutter/material.dart';
import 'package:kozak/components/home/home.dart';
import 'package:kozak/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: KWidgetkeys.homeKeys.screen,
      appBar: AppBar(
        title: NawbarDesc(
          search: (text) {},
        ),
      ),
      body: const HomeBodyWidget(),
    );
  }
}
