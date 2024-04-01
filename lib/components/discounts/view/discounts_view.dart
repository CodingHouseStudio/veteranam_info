import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class DiscountsScreen extends StatelessWidget {
  const DiscountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DiscountsBodyWidget(key: KWidgetkeys.discountsKeys.screen);
  }
}
