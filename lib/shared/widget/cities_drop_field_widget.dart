import 'package:flutter/material.dart';
import 'package:optimized_search_field/optimized_search_field.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class CitiesDropFieldWidget extends StatelessWidget {
  const CitiesDropFieldWidget({
    required this.citiesList,
    required this.isDesk,
    required this.onChanged,
    required this.removeCity,
    required this.textFieldKey,
    required this.selectedCities,
    super.key,
    this.showErrorText,
    this.errorText,
    this.isRequired,
    // this.controller,
  });
  final void Function(String text)? onChanged;
  final List<CityModel> citiesList;
  final bool isDesk;
  final bool? showErrorText;
  final String? errorText;
  final void Function(String value) removeCity;
  final List<String> selectedCities;
  // final TextEditingController? controller;
  final Key textFieldKey;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return BaseMultiSearchField<CityModel>(
      key: CitiesDropFieldKeys.widget,
      listKey: DropListFieldKeys.list,
      listItemKey: DropListFieldKeys.item,
      selectedListItemKey: MultiDropFieldKeys.chips,
      textFieldKey: textFieldKey,
      labelText: context.l10n.city, isRequired: isRequired,
      dropDownList: citiesList,
      errorText: errorText,
      onSelected: (text) {
        onChanged?.call(text);
      },
      values: selectedCities,
      showErrorText: showErrorText,
      // controller: controller,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return citiesList;
        }

        return citiesList
            .where(
              (element) =>
                  element.name.getTrsnslation(context).toLowerCase().contains(
                        textEditingValue.text.toLowerCase(),
                      ),
            )
            .toList();
      },
      unfocusSuffixIcon: KIcon.distance,
      itemsSpace: KPadding.kPaddingSize8,
      itemStyle: KButtonStyles.dropListButtonStyle,
      fieldSuffixIcon: KIcon.searchFieldIcon,
      item: (CityModel element) => Column(
        spacing: KPadding.kPaddingSize4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getCityName(cityModel: element, context: context),
            key: CitiesDropFieldKeys.city,
            style: AppTextStyle.materialThemeBodyLarge,
          ),
          Text(
            element.region.getTrsnslation(context),
            key: CitiesDropFieldKeys.region,
            style: AppTextStyle.materialThemeLabelSmallNeutralVariant70,
          ),
          const SizedBox.shrink(),
        ],
      ),
      selectedItemTextStyle: isDesk
          ? AppTextStyle.materialThemeTitleMedium
          : AppTextStyle.materialThemeTitleSmall,
      selectedItemStyle: KButtonStyles.advancedFilterButtonStyle,
      getItemText: (CityModel value) =>
          getCityName(cityModel: value, context: context),
      removeEvent: removeCity,
      menuMaxHeight:
          isDesk ? KMinMaxSize.maxHeight400 : KMinMaxSize.maxHeight220,
      customTextField: ({
        required controller,
        required focusNode,
        required key,
        required onChanged,
        required onSubmitted,
        required suffixIcon,
        required textFieldKey,
      }) =>
          TextFieldWidget(
        isDesk: isDesk,
        labelText: context.l10n.selectCity,
        key: textFieldKey,
        widgetKey: key,
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        suffixIcon: suffixIcon,
        disabledBorder: KWidgetTheme.outlineInputBorderEnabled,
        showErrorText: showErrorText,
        errorText: errorText,
        isRequired: isRequired,
      ),
    );
  }

  String getCityName({
    required CityModel cityModel,
    required BuildContext context,
  }) =>
      cityModel.name.getTrsnslation(context);
}
