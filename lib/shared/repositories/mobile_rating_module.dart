import 'package:in_app_review/in_app_review.dart' show InAppReview;
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

@module
abstract class MobileRatingModule {
  @Singleton(env: [Config.mobile])
  InAppReview get inAppReview => InAppReview.instance;
}
