import 'package:flutter/material.dart' show Offset;

/// COMMENT: Variables with dimensions that don't have a specific group
abstract class KDimensions {
  static const storyCardMaxLines = 10;
  static const donateCardsLine = 3;
  static const donateCardSmallExpanded = 2;
  static const donateCardBigExpanded = 4;
  static const donateCardStandartExpanded = 3;
  static const pageItems = 3;

  static const loadItems = 3;
  static const linkScrollCount = 2;
  static const investorsLoadItems = 6;

  static const leftCardPaddingMultiply = 0.5;
  static const respondPaddingMultiply = 0.1;
  static const daysBetweenFeedback = 7;

  static const doubleButtonAnimationDuration = 200;

  static const shimmerQuestionItems = 4;
  static const shimmerInformationItems = 3;
  static const shimmerFundsDeskItems = 2;
  static const shimmerFundsMobItems = 6;
  static const shimmerStoriesItems = 3;
  static const shimmerWorksItems = 3;
  static const shimmerDiscountsItems = 1;
  static const shimmerCategoryItems = 5;

  static const maxLinkPerDay = 3;

  static const emailScrollCount = 2;
  static const emailCloseDelay = 3;

  static const bottomDialogHeightFactor = 0.9;

  static const descriptionMobHideLength = 100;
  static const descriptionDeskHideLength = 200;

  static const offset = Offset(110, 45);

  static const discountOffset = Offset(420, 0);

  // static const kUserRoleWidth = 0.3;

  static const tenPercent = 0.1;

  static const fifteenPercent = 0.15;

  static const twentyPercent = 0.2;

  static const twentyEightPercent = 0.28;

  static const thirtyPercent = 0.3;

  static const thirtyThreePercent = 0.33;

  static const seventyPercent = 0.7;

  static const sixtyPercent = 0.6;

  static const sendingDelay = 60;

  static const minAmountTimeDiscountDays = 14;

  static const confirmdialogTimerDelay = 10;
  static const sequenceNumberError = 2;
  static const sequenceNumberCriticalError = 4;
  static const sequenceNumberWarning = 1;
  static const sequenceNumber = 0;
  static const sequenceNumberData = -2;

  static const logLevelData = -200;
  static const logLevelInfo = 1;
  static const logLevelWarning = 200;
  static const logLevelError = 500;
  static const logLevelCriticalError = 1000;

  static const listCacheExtent = 1000.0;
}
