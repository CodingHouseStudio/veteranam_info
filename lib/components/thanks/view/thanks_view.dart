import 'package:flutter/material.dart';
import 'package:veteranam/components/thanks/widget/body/thanks_body_widget.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ThanksScreen extends StatelessWidget {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThanksBodyWidget(
      key: ThanksKeys.screen,
    );
  }
}
