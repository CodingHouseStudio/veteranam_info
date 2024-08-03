import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.discount} Link From ${KGroupText.bloc}', () {
    late DiscountLinkFormBloc discountLinkFormBloc;
    late IDiscountRepository mockdiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;

    setUp(() {
      ExtendedDateTime.id = KTestText.id;
      ExtendedDateTime.current = KTestText.dateTime;
      mockdiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(mockdiscountRepository.sendLink(KTestText.linkModel)).thenAnswer(
        (_) async => const Right(true),
      );
      when(
        mockdiscountRepository.sendLink(
          KTestText.linkModelWrong,
        ),
      ).thenAnswer(
        (_) async => const Left(SomeFailure.serverError()),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestText.user,
      );
      discountLinkFormBloc = DiscountLinkFormBloc(
        discountRepository: mockdiscountRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<DiscountLinkFormBloc, DiscountLinkFormState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list',
      build: () => discountLinkFormBloc,
      act: (bloc) async => bloc
        ..add(DiscountLinkFormEvent.updateLink(KTestText.linkModel.link))
        ..add(const DiscountLinkFormEvent.sendLink()),
      expect: () async => [
        DiscountLinkFormState(
          link: LinkFieldModel.dirty(KTestText.linkModel.link),
          formState: LinkEnum.inProgress,
        ),
        const DiscountLinkFormState(
          link: LinkFieldModel.pure(),
          formState: LinkEnum.sending,
        ),
        const DiscountLinkFormState(
          link: LinkFieldModel.pure(),
          formState: LinkEnum.success,
        ),
      ],
    );

    blocTest<DiscountLinkFormBloc, DiscountLinkFormState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list',
      build: () => discountLinkFormBloc,
      act: (bloc) async => bloc
        ..add(const DiscountLinkFormEvent.updateLink(KTestText.field))
        ..add(const DiscountLinkFormEvent.sendLink())
        ..add(DiscountLinkFormEvent.updateLink(KTestText.linkModelWrong.link))
        ..add(const DiscountLinkFormEvent.sendLink()),
      expect: () async => [
        const DiscountLinkFormState(
          link: LinkFieldModel.dirty(KTestText.field),
          formState: LinkEnum.inProgress,
        ),
        const DiscountLinkFormState(
          link: LinkFieldModel.dirty(KTestText.field),
          formState: LinkEnum.invalidData,
        ),
        DiscountLinkFormState(
          link: LinkFieldModel.dirty(KTestText.linkModelWrong.link),
          formState: LinkEnum.inProgress,
        ),
        const DiscountLinkFormState(
          link: LinkFieldModel.pure(),
          formState: LinkEnum.sending,
        ),
        const DiscountLinkFormState(
          link: LinkFieldModel.pure(),
          formState: LinkEnum.initial,
          failure: DiscountLinkFormFailure.error,
        ),
      ],
    );
  });
}
