import 'package:dartz/dartz.dart';
import 'package:in_app_review/in_app_review.dart' show InAppReview;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/constants/security_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(env: [Config.mobile])
class MobileRatingRepository {
  MobileRatingRepository({
    required InAppReview inAppReview,
  }) : _inAppReview = inAppReview;
  final InAppReview _inAppReview;
  Future<Either<SomeFailure, bool>> showRatingDialog() async {
    try {
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();
        return const Right(true);
      } else {
        await _inAppReview.openStoreListing(
          appStoreId: KSecurityKeys.appStoreId,
        );
        return const Right(false);
      }
    } catch (e, stack) {
      return Left(
        SomeFailure.serverError(
          error: e,
          stack: stack,
          tag: 'Mobile Rating(showRatingDialog)',
          tagKey: ErrorText.repositoryKey,
        ),
      );
    }
  }
}
