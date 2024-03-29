import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KBorder {
  static OutlineInputBorder outlineInput = OutlineInputBorder(
    borderSide: const BorderSide(color: KColorTheme.lightGray),
    borderRadius: KBorderRadius.kBorderRadiusM,
  );
  static OutlineInputBorder outlineInputError = OutlineInputBorder(
    borderSide: const BorderSide(color: KColorTheme.error),
    borderRadius: KBorderRadius.kBorderRadiusM,
  );
}
