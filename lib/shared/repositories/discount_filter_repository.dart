import 'dart:async';

import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:veteranam/shared/constants/security_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

class DiscountFilterRepository {
  /// Component holding search filters

  /// Products Hits Searcher.

  final group = FilterGroupID.and('filter');
  final filterState = FilterState();

  Stream<List<DiscountModel>> getDiscountItems(
      //{List<String>? reportIdItems}
      ) {
    filterState.add(group, {
      Filter.facet(
        DiscountModelJsonField.status,
        DiscountState.published.enumString,
      ),
    });
    final searcher = HitsSearcher(
      applicationID: '6Y3VCMAXD7',
      apiKey: KSecurityKeys.alogoliaApiKey,
      indexName: 'discount',
    )..connectFilterState(filterState);
    return searcher.responses.map((response) {
      final hits = response.hits;

      return hits.map((hit) {
        // Assuming hit data matches DiscountModel.fromJson
        return DiscountModel.fromJson(hit);
      }).toList();
    });
    // return _firestoreService.getDiscounts(
    //     //reportIdItems
    //     );
  }
}
