import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

extension TextColorStyleExtention on BuildContext {
  TextColorStyleContext get textStyle => TextColorStyleContext.of(this);
}

class TextColorStyleContext {
  TextColorStyleContext.of(this.context);
  final BuildContext context;
  TextStyle get hint16 {
    return TextStyle(
      color: context.color.secondary,
      fontSize: KSize.kFont16,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get hint20 {
    return TextStyle(
      color: context.color.secondary,
      fontSize: KSize.kFont20,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get hint24 {
    return TextStyle(
      color: context.color.secondary,
      fontSize: KSize.kFont24,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get hint14 {
    return TextStyle(
      color: context.color.secondary,
      fontSize: KSize.kFont14,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle get error14 {
    return TextStyle(
      color: context.color.error,
      fontSize: KSize.kFont14,
      fontWeight: FontWeight.w400,
    );
  }
}
