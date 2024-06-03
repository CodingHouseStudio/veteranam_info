import 'package:flutter/material.dart';

/// COMMENT: Variables with dimensions that don't have a specific group
abstract class KDimensions {
  static const storyCardMaxLines = 10;
  static const donateCardsLine = 3;
  static const donateCardSmallExpanded = 2;
  static const donateCardBigExpanded = 4;
  static const donateCardStandartExpanded = 3;
  static const pageItems = 3;
  static const loadItems = 1;
  static const leftCardPaddingMultiply = 0.5;
  static const respondPaddingMultiply = 0.2;
  static const daysBetweenFeedback = 7;

  static var _doubleButtonAnimationDuration = 200;
  static int get doubleButtonAnimationDuration =>
      _doubleButtonAnimationDuration;
  @visibleForTesting
  static set doubleButtonAnimationDuration(int duration) =>
      _doubleButtonAnimationDuration = duration;
}
