import 'package:flutter/widgets.dart';

import 'package:veteranam/shared/shared_flutter.dart';

List<Widget> cardWidgetList<T>({
  required LoadingStatus loadingStatus,
  required List<T> modelItems,
  required Widget Function({
    required T modelItem,
    required bool isLoading,
  }) cardWidget,
  required int shimmerItemsNumber,
  // required Key cardKey,
  // required Key cardLastKey,
  required bool isNotFailure,
  required T shimmerItem,
  required bool isDesk,
}) {
  final isLoading = loadingStatus != LoadingStatus.loaded;
  final fullList = [
    if (isNotFailure) ...[
      ...modelItems,
      if (isLoading && (isDesk || modelItems.isEmpty))
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
      child: (isDesk || modelItems.isEmpty) &&
              fullList.length - index <= shimmerItemsNumber &&
              isLoading
          ? SkeletonizerWidget(
              isLoading: true,
              child: cardWidget(
                modelItem: fullList.elementAt(index),
                isLoading: isLoading,
              ),
            )
          : cardWidget(
              modelItem: fullList.elementAt(index),
              isLoading: isLoading,
            ),
    );
  });
}
