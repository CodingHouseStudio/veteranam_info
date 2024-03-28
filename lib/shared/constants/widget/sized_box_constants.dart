import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KSizedBox {
  static const SizedBox kHeightSizedBoxL = SizedBox(
    height: KSize.kPixelSizeL,
  );
  static const SizedBox kHeightSizedBoxM = SizedBox(
    height: KSize.kPixelSizeM,
  );
  static const SizedBox kHeightSizedBoxML = SizedBox(
    height: KSize.kPixelSizeML,
  );
  static const SizedBox kHeightSizedBoxS = SizedBox(
    height: KSize.kPixelSizeS,
  );

  static const SizedBox kHeightSizedBoxXS = SizedBox(
    height: KSize.kPixelSizeXS,
  );

  static const SizedBox kWidthSizedBoxL = SizedBox(
    width: KSize.kPixelSizeL,
  );
  static const SizedBox kWidthSizedBoxM = SizedBox(
    width: KSize.kPixelSizeM,
  );
  static const SizedBox kWidthSizedBoxML = SizedBox(
    width: KSize.kPixelSizeML,
  );
  static const SizedBox kWidthSizedBoxS = SizedBox(
    width: KSize.kPixelSizeS,
  );

  static const SizedBox kWidthSizedBoxXS = SizedBox(
    width: KSize.kPixelSizeXS,
  );
}
