part of '../widget_keys.dart';

abstract class DiscountsKeys {
  static const screen = Key('discounts_screen');
  static const filter = Key('discounts_screen_filter');
  static const card = Key('discounts_screen_card');
  // static const cardLast = Key('discounts_screen_card_last');
  // static const button = Key('discount_screen_button');
  static const buttonIcon = Key('discount_screen_button_icon');
  static const title = Key('discount_title');
  static const subtitleKey = Key('discount_subtitleKey');
  static const addDiscountButton = Key('discount_add_discount_button');
  // static const titlePoint = Key('discount_title_point');
  static const endListText = Key('discounts_screen_end_list_text');
  // static const ButtonIcon =
  //     Key('discounts_filter_button_icon');
  // static const ButtonIconUp =
  //     Key('discounts_filter_button_icon_up');
  static const userEmailDialog = Key('discounts_screen_user_email_dialog');
  // static const cancelIcon = Key('discounts_screen_cancel_icon');
  // static const cancelText = Key('discounts_screen_cancel_text');
  static const sortingButton = Key('discounts_screen_sorting_button');
  static const sortingFeaturedButtno =
      Key('discounts_screen_sorting_featured_button');
  static const sortingByDateButton =
      Key('discounts_screen_sorting_by_date_button');
  static const sortingLargestSmallestButton =
      Key('discounts_screen_sorting_largest_smallest_button');
  static const viewMode = Key('discounts_screen_view_mode');
  static const horizontalViewModeIcon =
      Key('discounts_screen_horizontal_view_mode_icon');
  static const verticalViewModeIcon =
      Key('discounts_screen_vertical_view_mode_icon');
  static const horizontalList = Key('discounts_screen_horizontal_list');
  static const verticalList = Key('discounts_screen_vertical_list');

  static const sortingList = [
    sortingFeaturedButtno,
    sortingByDateButton,
    sortingLargestSmallestButton,
  ];
}

abstract class DiscountsFilterKeys {
  static const desk = Key('discounts_filter_desk');
  static const mob = Key('discounts_filter_mob');
  static const appliedText = Key('discounts_filter_applied_text');
  static const mobButton = Key('discounts_filter_mob_button');
  static const dialog = Key('discounts_filter_dialog');
  static const list = Key('discounts_filter_list');
  static const resetButton = Key('discounts_filter_reset_button');
  static const cancelChip = Key('discounts_filter_cancel_chip');
  static const mobAppliedButton = Key('discounts_filter_mob_applied_button');
  static const citiesText = Key('discounts_filter_cities_text');
  static const categoriesText = Key('discounts_filter_categories_text');
  static const eligibilitiesText = Key('discounts_filter_eligibilities_text');
  static const cityItems = Key('discounts_filter_city_items');
  static const categoriesItems = Key('discounts_screen_categories_items');
  static const eligibilitiesItems = Key('discounts_filter_eligibilities_items');
  static const eligibilitiesCancelChip =
      Key('discounts_filter_eligibilities_cancel_chip');
  static const categoriesCancelChip =
      Key('discounts_filter_categories_cancel_chip');
  static const cityCancelChip = Key('discounts_filter_city_cancel_chip');
  static const loadingItems = Key('discounts_filter_loading_items');
  static const citySearchField = Key('discounts_filter_city_search_field');
  static const citySearchFieldCloseIcon =
      Key('discounts_filter_city_search_field_close_icon');

  static const cityOpenIcon = Key('discounts_filter_city_open_icon');
  static const cityCloseIcon = Key('discounts_filter_city_close_icon');
  static const categoriesOpenIcon =
      Key('discounts_filter_categories_open_icon');
  static const categoriesCloseIcon =
      Key('discounts_filter_categories_close_icon');
  static const eligibilitiesOpenIcon =
      Key('discounts_filter_eligiblities_open_icon');
  static const eligibilitiesCloseIcon =
      Key('discounts_filter_eligiblities_close_icon');
}
