import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: IInformationRepository, env: [Config.development])
class InformationRepository implements IInformationRepository {
  InformationRepository({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;
  final FirestoreService _firestoreService;

  @override
  Stream<List<InformationModel>> getInformationItems({
    List<String>? reportIdItems,
  }) =>
      _firestoreService.getInformations(reportIdItems);

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
          likes: informationModel.getLike(isLiked: isLiked),
        ),
      );
      return const Right(true);
    } catch (e, stack) {
      return Left(
        SomeFailure.value(
          error: e,
          stack: stack,
          tag: 'Information(updateLikeCount)',
          tagKey: ErrorText.repositoryKey,
          data: 'Information Model: $informationModel, Is Liked: $isLiked',
        ),
      );
    }
  }

  @override
  Future<Either<SomeFailure, InformationModel>> getInformation(
    String id,
  ) async {
    try {
      final informationModel = await _firestoreService.getInformation(id);
      return Right(informationModel);
    } catch (e, stack) {
      return Left(
        SomeFailure.value(
          error: e,
          stack: stack,
          tag: 'Information(getInformation)',
          tagKey: ErrorText.repositoryKey,
          data: 'Information ID: $id',
        ),
      );
    }
  }
}
