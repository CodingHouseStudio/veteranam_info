import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared_dart.dart';

abstract class IFeedbackRepository {
  Future<Either<SomeFailure, bool>> sendFeedback(FeedbackModel feedback);
  Future<Either<SomeFailure, bool>> sendMobFeedback({
    required FeedbackModel feedback,
    required Uint8List image,
  });
  Future<Either<SomeFailure, bool>> checkUserNeedShowFeedback(String userId);
}
