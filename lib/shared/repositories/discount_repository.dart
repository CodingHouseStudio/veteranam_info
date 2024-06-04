import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Singleton(as: IDiscountRepository)
class DiscountRepository implements IDiscountRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();

  @override
  Stream<List<DiscountModel>> getDiscountItems() =>
      _firestoreService.getDiscounts();

  @override
  Future<void> addMockDiscountItems() async {
    final tagsSnapshot = await _firestoreService.getTags().first;

    final tagMap = {
      for (final tag in tagsSnapshot) tag.id: tag,
    };

    for (var i = 0; i < tagMap.length; i++) {
      await _firestoreService.addDiscount(
        DiscountModel(
          id: '${ExtendedDateTime.id}$i',
          userId: '${ExtendedDateTime.id}$i',
          service: KMockText.serviceDiscount,
          percent: KMockText.discount,
          city: KMockText.cityDiscount,
          comment: KMockText.descriptionDiscount,
          date: DateTime.now(),
          instruction: KMockText.instructionDiscount,
          tags: tagMap.values.map((tag) => tag.title).toList(),
        ),
      );
    }
  }
}
