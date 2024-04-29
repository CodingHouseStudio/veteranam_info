import 'package:flutter/material.dart';
import 'package:kozak/components/thanks/widget/body/thanks_body_widget.dart';
import 'package:kozak/shared/shared.dart';

class ThanksScreen extends StatelessWidget {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThanksBodyWidget(
      key: KWidgetkeys.screen.thanks.screen,
    );
  }
}
