import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

// import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;

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
    return eitherFutureHelper(
      () async {
        await _firestoreService.updateInformationModel(
          informationModel.copyWith(
            likes: informationModel.getLike(isLiked: isLiked),
          ),
        );
        return const Right(true);
      },
      methodName: 'Information(updateLikeCount)',
      className: ErrorText.repositoryKey,
      data: 'Information Model: $informationModel, Is Liked: $isLiked',
    );
  }

  @override
  Future<Either<SomeFailure, InformationModel>> getInformation(
    String id,
  ) async {
    return eitherFutureHelper(
      () async {
        final informationModel = await _firestoreService.getInformation(id);
        return Right(informationModel);
      },
      methodName: 'Information(getInformation)',
      className: ErrorText.repositoryKey,
      data: 'Information ID: $id',
    );
  }
}
