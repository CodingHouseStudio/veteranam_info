import 'package:flutter/widgets.dart';
import 'package:kozak/components/components.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeedbackBlocprovider(
      childWidget: FeedbackBodyWidget(),
    );
  }
}
