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
      child: SizedBox(
        // TODO(refactor): change it
        height: 100,
        child: ListView.builder(
          key: scrollKey,
          scrollDirection: Axis.horizontal,
          reverse: mainAxisEnd ?? false,
          shrinkWrap: true,
          itemCount: children.length,
          itemBuilder: (context, index) => children.elementAt(index),
        ),
      ),
    );
  }
}
