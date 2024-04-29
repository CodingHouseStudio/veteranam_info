import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Singleton(as: IInformationRepository)
class InformationRepository implements IInformationRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();

  @override
  Stream<List<InformationModel>> getInformationItems() =>
      _firestoreService.getInformations();

  @override
  void addMockInformationItems() {
    for (var i = 0; i < KMockText.tags.length; i++) {
      _firestoreService.addInformation(
        InformationModel(
          id: DateTime.now().millisecond.toString(),
          title: KMockText.title,
          news: KMockText.cardData,
          date: DateTime.now(),
          image: i > KMockText.tags.length - 2 ? KMockText.image : null,
          tags: KMockText.tags.elementAt(i),
        ),
      );
    }
  }
}
