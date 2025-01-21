import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);

  group(
      '${KScreenBlocName.discount} ${KScreenBlocName.filter} '
      '${KGroupText.repository} ', () {
    late IDiscountFilterRepository mockDiscountFilterRepository;
    late UserRepository mockUserRepository;
    setUp(() {
      mockUserRepository = MockUserRepository();
      if (GetIt.I.isRegistered<UserRepository>()) {
        GetIt.I.unregister<UserRepository>();
      }
      GetIt.I.registerSingleton(mockUserRepository);
      mockDiscountFilterRepository = DiscountFilterRepository.init()
        ..getFilterValuesFromDiscountItems(
          KTestVariables.discountModelItemsModify,
        );
    });
    test('Init', () {
      expect(
        mockDiscountFilterRepository.activeCategoryMap.isEmpty,
        isTrue,
      );
      expect(
        mockDiscountFilterRepository.activeEligibilityMap.isEmpty,
        isTrue,
      );
      expect(
        mockDiscountFilterRepository.activeLocationMap.isEmpty,
        isTrue,
      );

      expect(
        mockDiscountFilterRepository.locationIsNotEpmty,
        isTrue,
      );

      expect(
        mockDiscountFilterRepository.categoryMap.isNotEmpty,
        isTrue,
      );
      expect(
        mockDiscountFilterRepository.eligibilityMap.isNotEmpty,
        isTrue,
      );
      expect(
        mockDiscountFilterRepository.locationMap.isNotEmpty,
        isTrue,
      );

      expect(
        mockDiscountFilterRepository.getActivityList.isEmpty,
        isTrue,
      );

      expect(
        mockDiscountFilterRepository.hasActivityItem,
        isFalse,
      );

      expect(
        mockDiscountFilterRepository.saveFilterEqual,
        isTrue,
      );
    });

    test('Add and Remove Cateogry', () {
      final addResult = mockDiscountFilterRepository.addRemoveCategory(
        valueUK: KMockText.tag.first,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        mockDiscountFilterRepository.activeCategoryMap.isEmpty,
        isFalse,
      );

      expect(
        mockDiscountFilterRepository.categoryMap.containSelected,
        isTrue,
      );

      expect(
        addResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          isTrue,
        ),
      );

      final add2Result = mockDiscountFilterRepository.addRemoveCategory(
        valueUK: KMockText.tag.last,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        mockDiscountFilterRepository.activeCategoryMap.length,
        1,
      );

      expect(
        mockDiscountFilterRepository.categoryMap.containSelected,
        isTrue,
      );

      expect(
        add2Result,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          isTrue,
        ),
      );

      final removeResult = mockDiscountFilterRepository.addRemoveCategory(
        valueUK: KMockText.tag.last,
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
        removeResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          isTrue,
        ),
      );
    });

    test('Add, Remove and search Location', () {
      final addResult = mockDiscountFilterRepository.addRemoveLocation(
        valueUK: KMockText.location.uk,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        mockDiscountFilterRepository.activeLocationMap.isEmpty,
        isFalse,
      );

      expect(
        mockDiscountFilterRepository.locationMap.containSelected,
        isTrue,
      );

      expect(
        addResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          isTrue,
        ),
      );

      final removeResult = mockDiscountFilterRepository.addRemoveLocation(
        valueUK: KMockText.location.uk,
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
        removeResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          isTrue,
        ),
      );

      final searchResult = mockDiscountFilterRepository.locationSearch(
        KMockText.location.uk,
      );

      expect(
        mockDiscountFilterRepository.locationMap.length,
        1,
      );

      expect(
        searchResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          isTrue,
        ),
      );

      final searchEmptyResult = mockDiscountFilterRepository.locationSearch(
        KTestVariables.fieldEmpty,
      );

      expect(
        mockDiscountFilterRepository.locationMap.length,
        isNot(1),
      );

      expect(
        searchEmptyResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          isTrue,
        ),
      );
    });

    test('Add and Remove Eligibility', () {
      final addResult = mockDiscountFilterRepository.addRemoveEligibility(
        valueUK: EligibilityEnum.veterans.getTranslateModel.uk,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        mockDiscountFilterRepository.activeEligibilityMap.isEmpty,
        isFalse,
      );

      expect(
        mockDiscountFilterRepository.eligibilityMap.containSelected,
        isTrue,
      );

      expect(
        addResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          isTrue,
        ),
      );

      final removeResult = mockDiscountFilterRepository.addRemoveEligibility(
        valueUK: EligibilityEnum.veterans.getTranslateModel.uk,
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
        removeResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          isTrue,
        ),
      );
    });

    test('Get Filter List with Category and without', () {
      final getFilterFullResult = mockDiscountFilterRepository.getFilterList(
        KTestVariables.discountModelItemsModify,
      );

      expect(
        getFilterFullResult,
        isA<Right<SomeFailure, List<DiscountModel>>>().having(
          (e) => e.value,
          'value',
          KTestVariables.discountModelItemsModify,
        ),
      );

      final addResult = mockDiscountFilterRepository.addRemoveCategory(
        valueUK: KMockText.tag.first,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        mockDiscountFilterRepository.activeCategoryMap.isEmpty,
        isFalse,
      );

      expect(
        mockDiscountFilterRepository.categoryMap.containSelected,
        isTrue,
      );

      expect(
        addResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          isTrue,
        ),
      );

      final getFilterResult = mockDiscountFilterRepository.getFilterList(
        KTestVariables.discountModelItemsModify,
      );

      expect(
        getFilterResult,
        isA<Right<SomeFailure, List<DiscountModel>>>().having(
          (e) => e.value.length,
          'value',
          1,
        ),
      );

      final removeResult = mockDiscountFilterRepository.addRemoveCategory(
        valueUK: KMockText.tag.first,
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
        removeResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          isTrue,
        ),
      );
    });

    test('Get Filter List with Category and without', () {
      final getFilterFullResult = mockDiscountFilterRepository.getFilterList(
        KTestVariables.discountModelItemsModify,
      );

      expect(
        getFilterFullResult,
        isA<Right<SomeFailure, List<DiscountModel>>>().having(
          (e) => e.value,
          'value',
          KTestVariables.discountModelItemsModify,
        ),
      );

      final addResult = mockDiscountFilterRepository.addRemoveCategory(
        valueUK: KMockText.tag.first,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        mockDiscountFilterRepository.activeCategoryMap.isEmpty,
        isFalse,
      );

      expect(
        mockDiscountFilterRepository.categoryMap.containSelected,
        isTrue,
      );

      expect(
        addResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          isTrue,
        ),
      );

      final getFilterResult = mockDiscountFilterRepository.getFilterList(
        KTestVariables.discountModelItemsModify,
      );

      expect(
        getFilterResult,
        isA<Right<SomeFailure, List<DiscountModel>>>().having(
          (e) => e.value.length,
          'value',
          1,
        ),
      );

      final removeResult = mockDiscountFilterRepository.addRemoveCategory(
        valueUK: KMockText.tag.first,
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
        removeResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          isTrue,
        ),
      );
    });

    test('Reset all', () {
      mockDiscountFilterRepository
        ..addRemoveCategory(
          valueUK: KMockText.tag.first,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        )
        ..addRemoveEligibility(
          valueUK: EligibilityEnum.veterans.getTranslateModel.uk,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        )
        ..addRemoveLocation(
          valueUK: KMockText.location.uk,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        );

      expect(
        mockDiscountFilterRepository.activeCategoryMap.isEmpty,
        isFalse,
      );
      expect(
        mockDiscountFilterRepository.activeLocationMap.isEmpty,
        isFalse,
      );
      expect(
        mockDiscountFilterRepository.activeEligibilityMap.isEmpty,
        isFalse,
      );

      final resetFullResult = mockDiscountFilterRepository.resetAll(
        [],
      );

      expect(
        mockDiscountFilterRepository.categoryMap.isEmpty,
        isTrue,
      );
      expect(
        mockDiscountFilterRepository.locationMap.isEmpty,
        isTrue,
      );
      expect(
        mockDiscountFilterRepository.eligibilityMap.isEmpty,
        isTrue,
      );

      expect(
        mockDiscountFilterRepository.activeCategoryMap.isEmpty,
        isTrue,
      );
      expect(
        mockDiscountFilterRepository.activeLocationMap.isEmpty,
        isTrue,
      );
      expect(
        mockDiscountFilterRepository.activeEligibilityMap.isEmpty,
        isTrue,
      );

      expect(
        resetFullResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          true,
        ),
      );

      final resetResult = mockDiscountFilterRepository.resetAll(
        KTestVariables.discountModelItemsModify,
      );

      expect(
        mockDiscountFilterRepository.categoryMap.isEmpty,
        isFalse,
      );
      expect(
        mockDiscountFilterRepository.locationMap.isEmpty,
        isFalse,
      );
      expect(
        mockDiscountFilterRepository.eligibilityMap.isEmpty,
        isFalse,
      );

      expect(
        resetResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          true,
        ),
      );
    });

    test('Save and Revert', () {
      mockDiscountFilterRepository
        ..addRemoveCategory(
          valueUK: KMockText.tag.first,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        )
        ..addRemoveEligibility(
          valueUK: EligibilityEnum.veterans.getTranslateModel.uk,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        )
        ..addRemoveLocation(
          valueUK: KMockText.location.uk,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        );

      expect(
        mockDiscountFilterRepository.activeCategoryMap.isEmpty,
        isFalse,
      );
      expect(
        mockDiscountFilterRepository.activeLocationMap.isEmpty,
        isFalse,
      );
      expect(
        mockDiscountFilterRepository.activeEligibilityMap.isEmpty,
        isFalse,
      );

      final saveResult = mockDiscountFilterRepository.saveActiveFilter();

      mockDiscountFilterRepository
        ..addRemoveCategory(
          valueUK: KMockText.tag.first,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        )
        ..addRemoveEligibility(
          valueUK: EligibilityEnum.veterans.getTranslateModel.uk,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        )
        ..addRemoveLocation(
          valueUK: KMockText.location.uk,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        );

      expect(
        mockDiscountFilterRepository.activeCategoryMap.isEmpty,
        isTrue,
      );
      expect(
        mockDiscountFilterRepository.activeLocationMap.isEmpty,
        isTrue,
      );
      expect(
        mockDiscountFilterRepository.activeEligibilityMap.isEmpty,
        isTrue,
      );

      expect(
        mockDiscountFilterRepository.activeEligibilityMap.isEmpty,
        isTrue,
      );

      expect(
        mockDiscountFilterRepository.saveFilterEqual,
        isFalse,
      );

      expect(
        saveResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          true,
        ),
      );

      final revertResult = mockDiscountFilterRepository.revertActiveFilter(
        KTestVariables.discountModelItemsModify,
      );

      expect(
        mockDiscountFilterRepository.activeCategoryMap.isEmpty,
        isFalse,
      );
      expect(
        mockDiscountFilterRepository.activeLocationMap.isEmpty,
        isFalse,
      );
      expect(
        mockDiscountFilterRepository.activeEligibilityMap.isEmpty,
        isFalse,
      );

      expect(
        revertResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          true,
        ),
      );
    });
  });
}

extension MapFilterExtension on Map<String, FilterItem> {
  bool get containSelected => values
      .where(
        (element) => element.isSelected,
      )
      .isNotEmpty;
}
