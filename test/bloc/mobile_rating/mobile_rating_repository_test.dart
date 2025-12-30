import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);

  group('${KScreenBlocName.network} ${KGroupText.repository}', () {
    late MobileRatingRepository mobileRatingRepository;
    late InAppReview mockInAppReview;

    setUp(() {
      mockInAppReview = MockInAppReview();

      when(
        mockInAppReview.openStoreListing(
          appStoreId: KAppText.appStoreId,
        ),
      ).thenAnswer(
        (_) async {},
      );
      when(
        mockInAppReview.requestReview(),
      ).thenAnswer(
        (_) async {},
      );

      mobileRatingRepository =
          MobileRatingRepository(inAppReview: mockInAppReview);
    });

    test('Show Rating Dialog when is available', () async {
      when(
        mockInAppReview.isAvailable(),
      ).thenAnswer(
        (_) async => true,
      );
      expect(
        await mobileRatingRepository.showRatingDialog(),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });

    test('Show Rating Dialog when is not available', () async {
      when(
        mockInAppReview.isAvailable(),
      ).thenAnswer(
        (_) async => false,
      );
      expect(
        await mobileRatingRepository.showRatingDialog(),
        isA<Right<SomeFailure, bool>>()
            .having((e) => e.value, 'value', isFalse),
      );
    });

    test('Show Rating Dialog failure', () async {
      when(
        mockInAppReview.isAvailable(),
      ).thenThrow(Exception(KGroupText.failure));
      expect(
        await mobileRatingRepository.showRatingDialog(),
        isA<Left<SomeFailure, bool>>(),
      );
    });
  });
}
