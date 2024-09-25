import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.discountsAdd} ${KGroupText.bloc}', () {
    late DiscountsAddBloc discountsAddBloc;
    late IDiscountRepository mockDiscountsRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.id = KTestText.sendDiscountModel.id;
      ExtendedDateTime.current = KTestText.sendDiscountModel.dateVerified;
      mockDiscountsRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      DiscountsAddBloc.sendDiscountModel = KTestText.sendDiscountModel;

      when(
        mockDiscountsRepository.getDiscountItems(),
      ).thenAnswer(
        (_) => Stream.value([KTestText.sendDiscountModel]),
      );

      when(
        mockAppAuthenticationRepository.currentUser,
      ).thenAnswer(
        (_) => KTestText.user,
      );
      when(
        mockDiscountsRepository.addDiscount(KTestText.sendDiscountModel),
      ).thenAnswer(
        (_) async => const Right(true),
      );

      discountsAddBloc = DiscountsAddBloc(
        discountRepository: mockDiscountsRepository,
        appAuthenticationBloc: mockAppAuthenticationRepository,
      );
    });
    blocTest<DiscountsAddBloc, DiscountsAddState>(
      'emits [DiscountsAddState.initial(), DiscountsAddState.success()]'
      ' when update fields correct and save',
      build: () => discountsAddBloc,
      act: (bloc) async {
        bloc
          ..add(const DiscountsAddEvent.started())
          ..add(
            DiscountsAddEvent.categoryUpdate(
              KTestText.sendDiscountModel.category.first,
            ),
          )
          ..add(
            DiscountsAddEvent.periodUpdate(
              KTestText.sendDiscountModel.expiration,
            ),
          )
          ..add(
            DiscountsAddEvent.cityUpdate(
              KTestText.sendDiscountModel.location!.first,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.titleUpdate(
              KTestText.sendDiscountModel.title,
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestText.sendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestText.sendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.discountRemoveItem(
              KTestText.sendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestText.sendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.linkUpdate(
              KTestText.sendDiscountModel.link,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.descriptionUpdate(
              KTestText.sendDiscountModel.description,
            ),
          )
          ..add(
            DiscountsAddEvent.exclusionsUpdate(
              KTestText.sendDiscountModel.exclusions!,
            ),
          )
          ..add(const DiscountsAddEvent.send());
      },
      expect: () async => [
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          category: const MessageFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: const MessageFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.initial,
        ),
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          category: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.category.first,
          ),
          city: const CitiesFieldModel.pure(),
          period: const MessageFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.inProgress,
        ),
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          category: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.category.first,
          ),
          city: const CitiesFieldModel.pure(),
          period: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.expiration!,
          ),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.city.isValid &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.detail,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.title.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isValid &&
              state.discounts.value!.length == 1 &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isNotValid &&
              state.discounts.value!.isEmpty &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isValid &&
              state.discounts.value!.length == 1 &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.link.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.description,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.description.isValid &&
              state.formState == DiscountsAddEnum.descriptionInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.exclusions.isValid &&
              state.formState == DiscountsAddEnum.descriptionInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.formState == DiscountsAddEnum.success &&
              state.failure == null,
        ),
      ],
    );

    blocTest<DiscountsAddBloc, DiscountsAddState>(
      'emits [DiscountsAddState.initial(), DiscountsAddState.success()]'
      ' when update fields incorrect, save and back',
      build: () => discountsAddBloc,
      act: (bloc) async {
        bloc
          ..add(const DiscountsAddEvent.started())
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.categoryUpdate(
              KTestText.sendDiscountModel.category.first,
            ),
          )
          ..add(
            DiscountsAddEvent.periodUpdate(
              KTestText.sendDiscountModel.expiration,
            ),
          )
          ..add(
            DiscountsAddEvent.cityUpdate(
              KTestText.sendDiscountModel.location!.first,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.titleUpdate(
              KTestText.sendDiscountModel.title,
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestText.sendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.linkUpdate(
              KTestText.sendDiscountModel.link,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.descriptionUpdate(
              KTestText.sendDiscountModel.description,
            ),
          )
          ..add(
            DiscountsAddEvent.exclusionsUpdate(
              KTestText.sendDiscountModel.exclusions!,
            ),
          )
          ..add(const DiscountsAddEvent.back())
          ..add(const DiscountsAddEvent.back());
      },
      expect: () async => [
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          category: const MessageFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: const MessageFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.initial,
        ),
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          category: const MessageFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: const MessageFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.invalidData,
        ),
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          category: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.category.first,
          ),
          city: const CitiesFieldModel.pure(),
          period: const MessageFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.inProgress,
        ),
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          category: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.category.first,
          ),
          city: const CitiesFieldModel.pure(),
          period: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.expiration!,
          ),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.city.isValid &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.detail,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.detailInvalidData,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.title.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.link.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.description,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.descriptionInvalidData,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.description.isValid &&
              state.formState == DiscountsAddEnum.descriptionInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.exclusions.isValid &&
              state.formState == DiscountsAddEnum.descriptionInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.inProgress,
        ),
      ],
    );

    blocTest<DiscountsAddBloc, DiscountsAddState>(
      'emits [DiscountsAddState.initial(), DiscountsAddState.success()]'
      ' when update fields correct and save failure',
      build: () => discountsAddBloc,
      act: (bloc) async {
        when(
          mockDiscountsRepository.addDiscount(KTestText.sendDiscountModel),
        ).thenAnswer(
          (_) async =>
              Left(SomeFailure.serverError(error: KGroupText.failureSend)),
        );
        bloc
          ..add(const DiscountsAddEvent.started())
          ..add(
            DiscountsAddEvent.categoryUpdate(
              KTestText.sendDiscountModel.category.first,
            ),
          )
          ..add(
            DiscountsAddEvent.periodUpdate(
              KTestText.sendDiscountModel.expiration,
            ),
          )
          ..add(
            DiscountsAddEvent.cityUpdate(
              KTestText.sendDiscountModel.location!.first,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.titleUpdate(
              KTestText.sendDiscountModel.title,
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestText.sendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.linkUpdate(
              KTestText.sendDiscountModel.link,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.descriptionUpdate(
              KTestText.sendDiscountModel.description,
            ),
          )
          ..add(
            DiscountsAddEvent.exclusionsUpdate(
              KTestText.sendDiscountModel.exclusions!,
            ),
          )
          ..add(const DiscountsAddEvent.send());
      },
      expect: () async => [
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          category: const MessageFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: const MessageFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.initial,
        ),
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          category: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.category.first,
          ),
          city: const CitiesFieldModel.pure(),
          period: const MessageFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.inProgress,
        ),
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          category: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.category.first,
          ),
          city: const CitiesFieldModel.pure(),
          period: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.expiration!,
          ),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.city.isValid &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.detail,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.title.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.link.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.description,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.description.isValid &&
              state.formState == DiscountsAddEnum.descriptionInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.exclusions.isValid &&
              state.formState == DiscountsAddEnum.descriptionInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.failure != null,
        ),
      ],
    );
  });
}
