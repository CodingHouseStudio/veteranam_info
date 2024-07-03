import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

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
        KMockText.informationModel.copyWith(
          id: '${ExtendedDateTime.id}$i',
          fetchDate: ExtendedDateTime.current,
          image: i > KMockText.tags.length - 2
              ? const ImageModel(downloadURL: KMockText.image)
              : null,
        ),
      );
    }
  }
}
