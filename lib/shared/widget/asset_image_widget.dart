import 'package:flutter/widgets.dart';
import 'package:veteranam/shared/shared.dart';

class AssetImageWidget extends StatelessWidget {
  const AssetImageWidget(
    this.name, {
    super.key,
    this.fit,
    this.width,
    this.height,
    this.cacheSize = KMinMaxSize.kImageMaxSize,
  });
  final String name;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final int cacheSize;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      key: key ?? Key(name),
      name,
      fit: fit,
      width: width,
      height: height,
      cacheHeight: cacheSize,
      cacheWidth: cacheSize,
    );
  }
}
