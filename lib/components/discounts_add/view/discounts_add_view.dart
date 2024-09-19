import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';

class DiscountsAddScreen extends StatelessWidget {
  const DiscountsAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DiscountsAddBlocprovider(
      childWidget: DiscountsAddBodyWidget(),
    );
  }
}
