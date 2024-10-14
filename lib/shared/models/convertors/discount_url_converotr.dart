import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:veteranam/shared/shared.dart';

class DiscountURLConverter {
  static DiscountModel? fromJson(Map<String, String> json) {
    DiscountModel? discountModel;

    if (json.isNotEmpty) {
      final queryParams = json.map((key, value) {
        late String text;
        try {
          text = Uri.decodeComponent(value);
        } catch (e) {
          text = value;
        }
        if (text == UrlParameters.whenParametIsNull) {
          return MapEntry(key, null);
        }
        // Handle lists separated by ","
        if ([
          DiscountModelJsonField.category,
          DiscountModelJsonField.categoryEN,
          DiscountModelJsonField.subcategory,
          DiscountModelJsonField.subcategoryEN,
          DiscountModelJsonField.eligibility,
          DiscountModelJsonField.eligibilityEN,
          DiscountModelJsonField.location,
          DiscountModelJsonField.locationEN,
        ].contains(key)) {
          return MapEntry(
            key,
            text
                .replaceAll('[', '')
                .replaceAll(']', '')
                .split(','), // Split lists
          );
        }

        if (key == DiscountModelJsonField.subLocation) {
          return MapEntry(
            key,
            text,
          );
        }

        if (key == DiscountModelJsonField.discount) {
          return MapEntry(
            key,
            text.split(',').map((e) => int.tryParse(e) ?? 0).toList(),
          );
        }

        if (key == DiscountModelJsonField.userPhoto) {
          late dynamic photo;
          try {
            photo = jsonDecode(value);
          } catch (e) {
            photo = value;
          }
          // Decode the JSON string into a Map
          return MapEntry(
            key,
            [photo],
            // Decode the JSON string correctly
          );
        }

        return MapEntry(key, text);
      });

      // Create DiscountModel from JSON if query parameters exist
      if (queryParams.isNotEmpty) {
        try {
          discountModel = DiscountModel.fromJson(queryParams);
          // ignore: empty_catches
        } catch (e) {}
      }
    }

    return discountModel;
  }

  static Map<String, dynamic> toJson(DiscountModel discount) {
    return discount.toJson().map((key, value) {
      var text = '';
      if (value is List<int>) {
        text = value.map((e) => e.toString()).join(',');
      }
      if (value is List<dynamic> &&
          value.first is Map<String, dynamic> &&
          text.isEmpty) {
        final json = value.first as Map<String, dynamic>;
        late String jsonString;
        try {
          jsonString = jsonEncode(
            json,
          );
        } catch (e) {
          jsonString = json.toString();
        }
        text = jsonString;
      }

      if (value is DateTime && text.isEmpty) {
        text = value.toIso8601String();
      }
      if (text.isEmpty) {
        text = value?.toString() ?? UrlParameters.whenParametIsNull;
      }
      try {
        return MapEntry(
          key,
          Uri.encodeComponent(text),
        );
      } catch (e) {
        return MapEntry(
          key,
          text,
        );
      }
    });
  }
}
