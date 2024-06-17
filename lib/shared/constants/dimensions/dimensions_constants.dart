import 'package:flutter/material.dart';

/// COMMENT: Variables with dimensions that don't have a specific group
abstract class KDimensions {
  static const storyCardMaxLines = 10;
  static const donateCardsLine = 3;
  static const donateCardSmallExpanded = 2;
  static const donateCardBigExpanded = 4;
  static const donateCardStandartExpanded = 3;
  static const pageItems = 3;

  static var _loadItems = 3;
  static var _investorsLoadItems = 6;

  static int get investorsLoadItems => _investorsLoadItems;
  static int get loadItems => _loadItems;

  @visibleForTesting
  static set loadItems(int loadItemsValue) => _loadItems = loadItemsValue;
  @visibleForTesting
  static set investorsLoadItems(int investorsLoadItemsValue) =>
      _investorsLoadItems = investorsLoadItemsValue;

  static const leftCardPaddingMultiply = 0.5;
  static const paddingMultiply = 0.1;
  static const daysBetweenFeedback = 7;

  static const doubleButtonAnimationDuration = 200;

  static const shimmerQuestionItems = 4;
  static const shimmerInformationItems = 1;
  static const shimmerFundsItems = 4;
  static const shimmerStoriesItems = 1;
  static const shimmerWorksItems = 3;
  static const shimmerDiscountsItems = 1;
}
