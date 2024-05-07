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
  void addMockDiscountItems() {
    for (var i = 0; i < KMockText.tags.length; i++) {
      _firestoreService.addDiscount(
        DiscountModel(
          id: '${ExtendedDateTime.id}$i',
          service: KMockText.serviceDiscount,
          discount: KMockText.discount,
          city: KMockText.cityDiscount,
          discountDescription: KMockText.descriptionDiscount,
          date: DateTime.now(),
          instruction: KMockText.instructionDiscount,
          preInstructionDiscount: KMockText.preInstructionDiscount,
          tags: KMockText.tagsDiscount.elementAt(i),
        ),
      );
    }
  }
}
