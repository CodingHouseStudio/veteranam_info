import 'package:flutter/widgets.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class QuestionsFormScreen extends StatelessWidget {
  const QuestionsFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionsFormBody(
      key: KWidgetkeys.screen.questionsForm.screen,
    );
  }
}
