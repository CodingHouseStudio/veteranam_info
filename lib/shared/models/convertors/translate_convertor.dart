import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/models/models.dart';

class TranslateConverter implements JsonConverter<TranslateModel, dynamic> {
  const TranslateConverter();

  @override
  TranslateModel fromJson(dynamic json) {
    return TranslateModel.fromJson(json as Map<String, dynamic>);
  }

  @override
  dynamic toJson(TranslateModel object) {
    return object.toJson();
  }

  static Map<String, dynamic> readJsonItem(
    Map<dynamic, dynamic> json,
    String key,
  ) {
    final uk = json[key];
    if (uk == null) return {};
    if (uk is Map<String, dynamic>) {
      return uk;
    }
    final en = json['$key${TranslateModelJsonField.enSufix}'];
    return {
      TranslateModelJsonField.uk: uk,
      TranslateModelJsonField.en: en,
    };
  }
}

class TranslateOrNullConverter
    implements JsonConverter<TranslateModel?, dynamic> {
  const TranslateOrNullConverter();

  @override
  TranslateModel? fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return map.isEmpty ? null : TranslateModel.fromJson(map);
  }

  @override
  dynamic toJson(TranslateModel? object) {
    return object?.toJson();
  }
}

class TranslateItemsConverter
    implements JsonConverter<List<TranslateModel>, dynamic> {
  const TranslateItemsConverter();

  @override
  List<TranslateModel> fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    final items = map[TranslateModelJsonField.trnslationListJson];
    if (items is List) {
      return List.generate(
        items.length,
        (index) => TranslateModel.fromJson(
          items.elementAt(index) as Map<String, dynamic>,
        ),
      );
    }
    return [];
  }

  @override
  dynamic toJson(List<TranslateModel> object) {
    return List.generate(
      object.length,
      (index) => object.elementAt(index).toJson(),
      growable: false,
    );
  }

  static Map<String, dynamic> readJsonItems(
    Map<dynamic, dynamic> json,
    String key,
  ) {
    final ukItems = json[key] as List?;
    if (ukItems == null) return {};
    if (ukItems.isEmpty) {
      return {TranslateModelJsonField.trnslationListJson: ukItems};
    }
    if (ukItems.first is Map<String, dynamic>) {
      return {
        TranslateModelJsonField.trnslationListJson: ukItems,
      };
    }
    final enItems = json['$key${TranslateModelJsonField.enSufix}'];
    final translationItems = <Map<String, dynamic>>[];
    for (var i = 0; i < ukItems.length; i++) {
      translationItems.add({
        TranslateModelJsonField.uk: ukItems.elementAt(i),
        TranslateModelJsonField.en: (enItems as List?)?.elementAtOrNull(i),
      });
    }
    return {TranslateModelJsonField.trnslationListJson: translationItems};
  }
}

class TranslateItemsOrNullConverter
    implements JsonConverter<List<TranslateModel>?, dynamic> {
  const TranslateItemsOrNullConverter();

  @override
  List<TranslateModel>? fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    if (map.isNotEmpty) {
      final items = map[TranslateModelJsonField.trnslationListJson];
      if (items is List) {
        return List.generate(
          items.length,
          (index) => TranslateModel.fromJson(
            items.elementAt(index) as Map<String, dynamic>,
          ),
        );
      }
    }
    return null;
  }

  @override
  dynamic toJson(List<TranslateModel>? object) {
    return object == null
        ? null
        : List.generate(
            object.length,
            (index) => object.elementAt(index).toJson(),
            growable: false,
          );
  }
}
