import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class EmptyCardWidget extends StatelessWidget {
  const EmptyCardWidget({
    required this.chilcWidget,
    required this.cardIsEmpty,
    super.key,
  });
  final Widget chilcWidget;
  final bool cardIsEmpty;

  @override
  Widget build(BuildContext context) {
    if (cardIsEmpty) {
      return SizedBox(
        width: KSize.kPixel640,
        height: KSize.kPixel640,
        child: ColoredBox(
          color: Colors.yellow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(KPadding.kPaddingSize16),
                child: CancelWidget(
                  // color: Colors.black,
                  onPressed: () => context.goNamed(KRoute.discounts.name),
                  widgetKey: Key('value'),
                ),
              ),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [KImage.found(), const Text('test')])),
            ],
          ),
        ),
      );
    }
    return chilcWidget;
  }
}
