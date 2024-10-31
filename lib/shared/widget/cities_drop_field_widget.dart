import 'package:flutter/material.dart';
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
    return MultiDropFieldImplementationWidget<CityModel>(
      key: KWidgetkeys.widget.citiesDropField.widget,
      textFieldKey: textFieldKey,
      labelText: context.l10n.city, isRequired: isRequired,
      dropDownList: citiesList,
      isDesk: isDesk,
      errorText: errorText,
      onChanged: onChanged,
      values: selectedCities,
      showErrorText: showErrorText,
      // controller: controller,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return citiesList;
        }

        return citiesList
            .where(
              (element) => element.name.uk
                  .getTrnslation(en: element.name.en, context: context)
                  .toLowerCase()
                  .contains(
                    textEditingValue.text.toLowerCase(),
                  ),
            )
            .toList();
      },
      unfocusSufixIcon: KIcon.distance,
      item: (CityModel element) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getCityName(cityModel: element, context: context),
            key: KWidgetkeys.widget.citiesDropField.city,
            style: AppTextStyle.materialThemeBodyLarge,
          ),
          KSizedBox.kHeightSizedBox4,
          Text(
            element.region.uk
                .getTrnslation(en: element.region.en, context: context),
            key: KWidgetkeys.widget.citiesDropField.region,
            style: AppTextStyle.materialThemeLabelSmallNeutralVariant70,
          ),
          KSizedBox.kHeightSizedBox4,
        ],
      ),
      getItemText: (CityModel value) =>
          getCityName(cityModel: value, context: context),
      removeEvent: removeCity,
    );
  }

  String getCityName({
    required CityModel cityModel,
    required BuildContext context,
  }) =>
      cityModel.name.uk.getTrnslation(en: cityModel.name.en, context: context);
}
