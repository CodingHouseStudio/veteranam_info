import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

List<Widget> cardWidgetList<T>({
  required bool isLoading,
  required List<T> modelItems,
  required Widget Function({
    required T modelItem,
    required Key key,
  }) cardWidget,
  required int shimmerItemsNumber,
  required Key cardKey,
  required Key cardLastKey,
  required bool isNotFailure,
  required T shimmerItem,
  required bool isDesk,
}) {
  final fullList = [
    if (isNotFailure) ...[
      ...modelItems,
      if (isLoading)
        ...List.generate(
          shimmerItemsNumber,
          (index) => shimmerItem,
        ),
    ],
  ];
  return List.generate(fullList.length, (index) {
    return Padding(
      padding: index != 0
          ? EdgeInsets.only(
              top: isDesk ? KPadding.kPaddingSize48 : KPadding.kPaddingSize24,
            )
          : EdgeInsets.zero,
      child: SkeletonizerWidget(
        isLoading: fullList.length - index <= shimmerItemsNumber && isLoading,
        child: cardWidget(
          modelItem: fullList.elementAt(index),
          key: index != fullList.length - 1 ? cardKey : cardLastKey,
        ),
      ),
    );
  });
}
