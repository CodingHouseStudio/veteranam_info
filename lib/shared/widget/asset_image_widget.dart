import 'package:flutter/widgets.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class AssetImageWidget extends StatelessWidget {
  const AssetImageWidget(
    this.name, {
    super.key,
    this.fit,
    this.width,
    this.height,
    this.cacheSize = KMinMaxSize.kImageMaxSize,
    this.widgetKey,
  });
  final String name;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final int cacheSize;
  final Key? widgetKey;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      key: widgetKey ?? Key(name),
      name,
      fit: fit,
      width: width,
      height: height,
      cacheHeight: cacheSize,
      cacheWidth: cacheSize,
    );
  }
}
