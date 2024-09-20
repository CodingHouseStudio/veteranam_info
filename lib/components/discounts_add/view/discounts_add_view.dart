import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class DiscountsAddScreen extends StatelessWidget {
  const DiscountsAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DiscountsAddBlocprovider(
      key: KWidgetkeys.screen.discountsAdd.screen,
      childWidget: const DiscountsAddBodyWidget(),
    );
  }
}
