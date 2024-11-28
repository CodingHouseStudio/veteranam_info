class IDFilterItemsModel {
  const IDFilterItemsModel({
    required this.value,
  });

  const IDFilterItemsModel.empty({
    this.value = const {},
  });

  final Map<String, IDFilterItem> value;

  Iterable<String> get getFilteringId {
    return value.keys.where(
      (key) => value[key]!.containAllFilter,
    );
  }
}

class IDFilterItem {
  IDFilterItem({
    required this.discountId,
    this.hasCateogries = true,
    this.hasEligibilities = true,
    this.hasLocation = true,
  });

  final String discountId;
  final bool hasCateogries;
  final bool hasEligibilities;
  final bool hasLocation;
  IDFilterItem copyWith({
    String? discountId,
    bool? hasCateogries,
    bool? hasEligibilities,
    bool? hasLocation,
  }) {
    return IDFilterItem(
      discountId: discountId ?? this.discountId,
      hasCateogries: hasCateogries ?? this.hasCateogries,
      hasEligibilities: hasEligibilities ?? this.hasEligibilities,
      hasLocation: hasLocation ?? this.hasLocation,
    );
  }

  bool get containAllFilter => hasCateogries && hasEligibilities && hasLocation;
}
