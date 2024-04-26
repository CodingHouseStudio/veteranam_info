import 'package:flutter/widgets.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class QuestionsFormScreen extends StatelessWidget {
  const QuestionsFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionsFormBody(
      key: KWidgetkeys.screen.questionsForm.screen,
    );
  }
}
