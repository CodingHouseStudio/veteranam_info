import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/shared/shared_dart.dart';
import '../../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);

  group(
      '${KScreenBlocName.discount} ${KScreenBlocName.filter} '
      '${KGroupText.repository} ', () {
    // late IDiscountFilterRepository discountFilterRepository;
    late UserRepository mockUserRepository;
    setUp(() {
      mockUserRepository = MockUserRepository();
      if (GetIt.I.isRegistered<UserRepository>()) {
        GetIt.I.unregister<UserRepository>();
      }
      GetIt.I.registerSingleton(mockUserRepository);
    });
    IDiscountFilterRepository init() {
      final discountFilterRepository = DiscountFilterRepository.init()
        ..getFilterValuesFromDiscountItems(
          KTestVariables.discountModelItemsModify,
        );
      return discountFilterRepository;
    }

    test('Init', () {
      final discountFilterRepository = init();

      expect(
        discountFilterRepository.activeCategoryMap.isEmpty,
        isTrue,
      );
      expect(
        discountFilterRepository.activeEligibilityMap.isEmpty,
        isTrue,
      );
      expect(
        discountFilterRepository.activeLocationMap.isEmpty,
        isTrue,
      );

      expect(
        discountFilterRepository.locationIsNotEpmty,
        isTrue,
      );

      expect(
        discountFilterRepository.categoryMap.isNotEmpty,
        isTrue,
      );
      expect(
        discountFilterRepository.eligibilityMap.isNotEmpty,
        isTrue,
      );
      expect(
        discountFilterRepository.locationMap.isNotEmpty,
        isTrue,
      );

      expect(
        discountFilterRepository.getActivityList.isEmpty,
        isTrue,
      );

      expect(
        discountFilterRepository.hasActivityItem,
        isFalse,
      );

      expect(
        discountFilterRepository.saveFilterEqual,
        isTrue,
      );
    });

    test('Add and Remove Cateogry', () {
      final discountFilterRepository = init();

      final addResult = discountFilterRepository.addRemoveCategory(
        valueUK: KMockText.tag.first,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        discountFilterRepository.activeCategoryMap.isEmpty,
        isFalse,
      );

      expect(
        discountFilterRepository.categoryMap.containSelected,
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

      final add2Result = discountFilterRepository.addRemoveCategory(
        valueUK: KMockText.tag.last,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        discountFilterRepository.activeCategoryMap.length,
        1,
      );

      expect(
        discountFilterRepository.categoryMap.containSelected,
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

      final removeResult = discountFilterRepository.addRemoveCategory(
        valueUK: KMockText.tag.last,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        discountFilterRepository.activeCategoryMap.isEmpty,
        isTrue,
      );

      expect(
        discountFilterRepository.categoryMap.containSelected,
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
      final discountFilterRepository = init();

      final addResult = discountFilterRepository.addRemoveLocation(
        valueUK: KMockText.location.uk,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        discountFilterRepository.activeLocationMap.isEmpty,
        isFalse,
      );

      // expect(
      //   discountFilterRepository.locationMap.containSelected,
      //   isTrue,
      // );

      expect(
        addResult,
        isA<Right<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          isTrue,
        ),
      );

      final removeResult = discountFilterRepository.addRemoveLocation(
        valueUK: KMockText.location.uk,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        discountFilterRepository.activeLocationMap.isEmpty,
        isTrue,
      );

      expect(
        discountFilterRepository.locationMap.containSelected,
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

      final searchResult = discountFilterRepository.locationSearch(
        KMockText.location.uk,
      );

      expect(
        discountFilterRepository.locationMap.length,
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

      final searchEmptyResult = discountFilterRepository.locationSearch(
        KTestVariables.fieldEmpty,
      );

      expect(
        discountFilterRepository.locationMap.length,
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
      final discountFilterRepository = init();

      final addResult = discountFilterRepository.addRemoveEligibility(
        valueUK: EligibilityEnum.veterans.getTranslateModel.uk,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        discountFilterRepository.activeEligibilityMap.isEmpty,
        isFalse,
      );

      expect(
        discountFilterRepository.eligibilityMap.containSelected,
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

      final removeResult = discountFilterRepository.addRemoveEligibility(
        valueUK: EligibilityEnum.veterans.getTranslateModel.uk,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        discountFilterRepository.activeEligibilityMap.isEmpty,
        isTrue,
      );

      expect(
        discountFilterRepository.eligibilityMap.containSelected,
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
      final discountFilterRepository = init();

      final getFilterFullResult = discountFilterRepository.getFilterList(
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

      final addResult = discountFilterRepository.addRemoveCategory(
        valueUK: KMockText.tag.first,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        discountFilterRepository.activeCategoryMap.isEmpty,
        isFalse,
      );

      expect(
        discountFilterRepository.categoryMap.containSelected,
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

      final getFilterResult = discountFilterRepository.getFilterList(
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

      final removeResult = discountFilterRepository.addRemoveCategory(
        valueUK: KMockText.tag.first,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        discountFilterRepository.activeCategoryMap.isEmpty,
        isTrue,
      );

      expect(
        discountFilterRepository.categoryMap.containSelected,
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
      final discountFilterRepository = init();

      final getFilterFullResult = discountFilterRepository.getFilterList(
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

      final addResult = discountFilterRepository.addRemoveCategory(
        valueUK: KMockText.tag.first,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        discountFilterRepository.activeCategoryMap.isEmpty,
        isFalse,
      );

      expect(
        discountFilterRepository.categoryMap.containSelected,
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

      final getFilterResult = discountFilterRepository.getFilterList(
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

      final removeResult = discountFilterRepository.addRemoveCategory(
        valueUK: KMockText.tag.first,
        unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
      );

      expect(
        discountFilterRepository.activeCategoryMap.isEmpty,
        isTrue,
      );

      expect(
        discountFilterRepository.categoryMap.containSelected,
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
      final discountFilterRepository = init()
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
        discountFilterRepository.activeCategoryMap.isEmpty,
        isFalse,
      );
      expect(
        discountFilterRepository.activeLocationMap.isEmpty,
        isFalse,
      );
      expect(
        discountFilterRepository.activeEligibilityMap.isEmpty,
        isFalse,
      );

      final resetFullResult = discountFilterRepository.resetAll(
        [],
      );

      expect(
        discountFilterRepository.categoryMap.isEmpty,
        isTrue,
      );
      expect(
        discountFilterRepository.locationMap.isEmpty,
        isTrue,
      );
      expect(
        discountFilterRepository.eligibilityMap.isEmpty,
        isTrue,
      );

      expect(
        discountFilterRepository.activeCategoryMap.isEmpty,
        isTrue,
      );
      expect(
        discountFilterRepository.activeLocationMap.isEmpty,
        isTrue,
      );
      expect(
        discountFilterRepository.activeEligibilityMap.isEmpty,
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

      final resetResult = discountFilterRepository.resetAll(
        KTestVariables.discountModelItemsModify,
      );

      expect(
        discountFilterRepository.categoryMap.isEmpty,
        isFalse,
      );
      expect(
        discountFilterRepository.locationMap.isEmpty,
        isFalse,
      );
      expect(
        discountFilterRepository.eligibilityMap.isEmpty,
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
      final discountFilterRepository = init()
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
        discountFilterRepository.activeCategoryMap.isEmpty,
        isFalse,
      );
      expect(
        discountFilterRepository.activeLocationMap.isEmpty,
        isFalse,
      );
      expect(
        discountFilterRepository.activeEligibilityMap.isEmpty,
        isFalse,
      );

      final saveResult = discountFilterRepository.saveActiveFilter();

      discountFilterRepository
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
        discountFilterRepository.activeCategoryMap.isEmpty,
        isTrue,
      );
      expect(
        discountFilterRepository.activeLocationMap.isEmpty,
        isTrue,
      );
      expect(
        discountFilterRepository.activeEligibilityMap.isEmpty,
        isTrue,
      );

      expect(
        discountFilterRepository.activeEligibilityMap.isEmpty,
        isTrue,
      );

      expect(
        discountFilterRepository.saveFilterEqual,
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

      final revertResult = discountFilterRepository.revertActiveFilter(
        KTestVariables.discountModelItemsModify,
      );

      expect(
        discountFilterRepository.activeCategoryMap.isEmpty,
        isFalse,
      );
      expect(
        discountFilterRepository.activeLocationMap.isEmpty,
        isFalse,
      );
      expect(
        discountFilterRepository.activeEligibilityMap.isEmpty,
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
