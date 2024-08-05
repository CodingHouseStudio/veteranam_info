import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@LazySingleton(as: IInformationRepository)
class InformationRepository implements IInformationRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();

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
    } on FirebaseException catch (e) {
      return Left(SendFailure.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }

  @override
  Future<Either<SomeFailure, InformationModel>> getInformation(
    String id,
  ) async {
    try {
      final informationModel = await _firestoreService.getInformation(id);
      return Right(informationModel);
    } on FirebaseException catch (e) {
      return Left(GetFailur.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }
}
