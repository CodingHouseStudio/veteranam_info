// import 'dart:convert' show jsonDecode, jsonEncode;

// import 'package:veteranam/shared/shared.dart';

// class DiscountURLConverter {
//   static DiscountModel? fromJson(Map<String, String> json) {
//     DiscountModel? discountModel;

//     if (json.isNotEmpty) {
//       final jsonValue = json.map((key, value) {
//         if (value == UrlParameters.whenParametIsNull) {
//           return MapEntry(key, null);
//         }
//         // Handle lists separated by ","
//         if ([
//           DiscountModelJsonField.category,
//           DiscountModelJsonField.categoryEN,
//           DiscountModelJsonField.subcategory,
//           DiscountModelJsonField.subcategoryEN,
//           DiscountModelJsonField.eligibility,
//           DiscountModelJsonField.eligibilityEN,
//           DiscountModelJsonField.location,
//           DiscountModelJsonField.locationEN,
//         ].contains(key)) {
//           return MapEntry(
//             key,
//             value
//                 .replaceAll('[', '')
//                 .replaceAll(']', '')
//                 .split(','), // Split lists
//           );
//         }

//         if (key == DiscountModelJsonField.subLocation) {
//           return MapEntry(
//             key,
//             value,
//           );
//         }
//         if (key == DiscountModelJsonField.discount) {
//           return MapEntry(
//             key,
//             value.split(',').map((e) => int.tryParse(e) ?? 0).toList(),
//           );
//         }

//         if (key == DiscountModelJsonField.userPhoto) {
//           late dynamic photo;
//           try {
//             photo = [jsonDecode(value)];
//           } catch (e) {
//             photo = null;
//           }
//           // Decode the JSON string into a Map
//           return MapEntry(
//             key,
//             photo,
//             // Decode the JSON string correctly
//           );
//         }

//         return MapEntry(key, value);
//       });

//       // Create DiscountModel from JSON if query parameters exist
//       if (jsonValue.isNotEmpty) {
//         try {
//           discountModel = DiscountModel.fromJson(jsonValue);
//           // ignore: empty_catches
//         } catch (e) {}
//       }
//     }

//     return discountModel;
//   }

//   static Map<String, dynamic> toJson(DiscountModel discount) {
//     return discount.toJson().map((key, value) {
//       if (value is List<int>) {
//         return MapEntry(
//           key,
//           value.map((e) => e.toString()).join(','),
//         );
//       }
//       if (value is List<dynamic> &&
//           value.isNotEmpty &&
//           value.first is Map<String, dynamic>) {
//         final json = value.first as Map<String, dynamic>;
//         late String jsonString;
//         try {
//           jsonString = jsonEncode(
//             json,
//           );
//         } catch (e) {
//           jsonString = json.toString();
//         }
//         return MapEntry(
//           key,
//           jsonString,
//         );
//       }

//       if (value is DateTime) {
//         return MapEntry(
//           key,
//           value.toIso8601String(),
//         );
//       }

//       return MapEntry(
//         key,
//         value?.toString() ?? UrlParameters.whenParametIsNull,
//       );
//     });
//   }
// }
