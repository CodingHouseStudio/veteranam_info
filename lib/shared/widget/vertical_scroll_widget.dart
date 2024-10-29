import 'package:flutter/widgets.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class VerticalScrollWidget extends StatelessWidget {
  const VerticalScrollWidget({
    required this.children,
    super.key,
    this.scrollKey,
    this.mainAxisEnd,
  });
  final List<Widget> children;
  final Key? scrollKey;
  final bool? mainAxisEnd;
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SingleChildScrollView(
        key: scrollKey,
        scrollDirection: Axis.horizontal,
        reverse: mainAxisEnd ?? false,
        child: Row(
          children: children,
        ),
      ),
    );
  }
}
