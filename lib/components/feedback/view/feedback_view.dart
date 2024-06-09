import 'package:flutter/widgets.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

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
