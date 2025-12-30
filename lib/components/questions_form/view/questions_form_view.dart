import 'package:flutter/widgets.dart';

import 'package:veteranam/components/questions_form/questions_form.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class QuestionsFormScreen extends StatelessWidget {
  const QuestionsFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const QuestionFormBlocprovider(
      childWidget: QuestionsFormBody(
        key: QuestionsFormKeys.screen,
      ),
    );
  }
}
