import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
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

  @override
  Future<Either<SomeFailure, bool>> updateLikeCount({
    required InformationModel informationModel,
    required bool isLiked,
  }) async {
    try {
      await _firestoreService.updateInformationModel(
        informationModel.copyWith(
          likes: isLiked
              ? informationModel.likes ?? 0 + 1
              : informationModel.likes != null && informationModel.likes! > 1
                  ? informationModel.likes! - 1
                  : null,
        ),
      );
      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(GetFailur.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }
}
