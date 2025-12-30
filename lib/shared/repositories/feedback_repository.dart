import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

// import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;

@Singleton(as: IFeedbackRepository)
class FeedbackRepository implements IFeedbackRepository {
  FeedbackRepository({
    required FirestoreService firestoreService,
    required StorageService storageService,
  })  : _firestoreService = firestoreService,
        _storageService = storageService;
  final FirestoreService _firestoreService;
  final StorageService _storageService;

  @override
  Future<Either<SomeFailure, bool>> sendFeedback(FeedbackModel feedback) async {
    return eitherFutureHelper(
      () async {
        await _firestoreService.addFeedback(feedback);
        return const Right(true);
      },
      methodName: 'Feedback(sendFeedback)',
      className: ErrorText.repositoryKey,
      data: 'Feedback: $feedback',
    );
  }

  @override
  Future<Either<SomeFailure, bool>> sendMobFeedback({
    required FeedbackModel feedback,
    required Uint8List image,
  }) async {
    return eitherFutureHelper(
      () async {
        final feedbackModel = await _addImage(
          feedback: feedback,
          image: image,
        );
        await _firestoreService.addMobFeedback(feedbackModel);
        return const Right(true);
      },
      methodName: 'Feedback(sendMobFeedback)',
      className: ErrorText.repositoryKey,
      data: 'Feedback: $feedback| ${image.getErrorData}',
    );
  }

  @override
  Future<Either<SomeFailure, bool>> checkUserNeedShowFeedback(
    String userId,
  ) async {
    return eitherFutureHelper(
      () async {
        final feedback = await _firestoreService.getUserFeedback(userId);
        final date = DateTime.now()
            .subtract(const Duration(days: KDimensions.daysBetweenFeedback));
        final lastFeedback =
            feedback.reduce((a, b) => a.timestamp.isAfter(b.timestamp) ? a : b);
        if (lastFeedback.timestamp.isAfter(date)) {
          return const Right(false);
        } else {
          return const Right(true);
        }
      },
      methodName: 'Feedback(checkUserNeedShowFeedback)',
      className: ErrorText.repositoryKey,
      user: User(id: userId),
      data: 'User ID: $userId',
    );
  }

  Future<FeedbackModel> _addImage({
    required Uint8List image,
    required FeedbackModel feedback,
  }) async {
    final downloadURL = await _storageService.saveFile(
      filePickerItem: image.parseToImagePickerItem,
      id: feedback.id,
      collecltionName: FirebaseCollectionName.mobFeedback,
    );
    if (downloadURL != null && downloadURL.isNotEmpty) {
      return feedback.copyWith(
        image: ImageModel(downloadURL: downloadURL),
      );
    }

    return feedback;
  }
}
