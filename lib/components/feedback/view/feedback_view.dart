import 'package:flutter/widgets.dart';
import 'package:veteranam/components/feedback/feedback.dart';
import 'package:veteranam/shared/shared.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeedbackBlocprovider(
      key: KWidgetkeys.screen.feedback.screen,
      childWidget: const FeedbackBodyWidget(),
    );
  }
}
