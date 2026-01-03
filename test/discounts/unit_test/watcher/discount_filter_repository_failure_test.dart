import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../../test_dependency.dart';
import 'discount_filter_repository_test.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);

  group(
      '${KScreenBlocName.discount} ${KScreenBlocName.filter}'
      ' ${KGroupText.repository} ', () {
    late IDiscountFilterRepository mockDiscountFilterRepository;
    late UserRepository mockUserRepository;
    setUp(() {
      mockUserRepository = MockUserRepository();
      if (GetIt.I.isRegistered<UserRepository>()) {
        GetIt.I.unregister<UserRepository>();
      }
      GetIt.I.registerSingleton(mockUserRepository);
    });
    group('is test false', () {
      setUp(() {
        KTest.isTest = false;
        mockDiscountFilterRepository = DiscountFilterRepository.init();
      });
      test('Add and Remove Cateogry', () {
        final wrongResult = mockDiscountFilterRepository.addRemoveCategory(
          valueUK: KTestVariables.field,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        );

        expect(
          mockDiscountFilterRepository.activeCategoryMap.isEmpty,
          isTrue,
        );

        expect(
          mockDiscountFilterRepository.categoryMap.containSelected,
          isFalse,
        );

        expect(
          wrongResult,
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            SomeFailure.filter,
          ),
        );
      });
    });
    group('is test true and filter is Empty', () {
      setUp(() {
        KTest.isTest = true;
        mockDiscountFilterRepository = const DiscountFilterRepository.empty();
      });
      test('Add and Remove Cateogry', () {
        final wrongResult = mockDiscountFilterRepository.addRemoveCategory(
          valueUK: KTestVariables.field,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        );

        expect(
          mockDiscountFilterRepository.activeCategoryMap.isEmpty,
          isTrue,
        );

        expect(
          mockDiscountFilterRepository.categoryMap.containSelected,
          isFalse,
        );

        expect(
          wrongResult,
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            SomeFailure.unsupported,
          ),
        );
      });
      test('Add and Remove Location', () {
        final wrongResult = mockDiscountFilterRepository.addRemoveLocation(
          valueUK: KTestVariables.field,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        );

        expect(
          mockDiscountFilterRepository.activeLocationMap.isEmpty,
          isTrue,
        );

        expect(
          mockDiscountFilterRepository.locationMap.containSelected,
          isFalse,
        );

        expect(
          wrongResult,
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            SomeFailure.unsupported,
          ),
        );
      });
      test('Add and Remove Eligebility', () {
        final wrongResult = mockDiscountFilterRepository.addRemoveEligibility(
          valueUK: KTestVariables.field,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        );

        expect(
          mockDiscountFilterRepository.activeEligibilityMap.isEmpty,
          isTrue,
        );

        expect(
          mockDiscountFilterRepository.eligibilityMap.containSelected,
          isFalse,
        );

        expect(
          wrongResult,
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            SomeFailure.unsupported,
          ),
        );
      });
      test('Save And Revert Filter', () {
        final saveResult = mockDiscountFilterRepository.saveActiveFilter();

        expect(
          saveResult,
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            SomeFailure.unsupported,
          ),
        );

        final revertResult = mockDiscountFilterRepository.revertActiveFilter(
          KTestVariables.discountModelItemsModify,
        );

        expect(
          revertResult,
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            SomeFailure.unsupported,
          ),
        );
      });
      test('Reset All', () {
        final result = mockDiscountFilterRepository.resetAll(
          KTestVariables.discountModelItemsModify,
        );

        expect(
          result,
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            SomeFailure.unsupported,
          ),
        );
      });
      test('Get Filter Values From Discount Items', () {
        final result =
            mockDiscountFilterRepository.getFilterValuesFromDiscountItems(
          KTestVariables.discountModelItemsModify,
        );

        expect(
          result,
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            SomeFailure.unsupported,
          ),
        );
      });
    });
  });
}
