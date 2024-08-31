import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
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
        (_) async => Left(SomeFailure.serverError(error: null)),
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
        // const DiscountLinkFormState(
        //   link: LinkFieldModel.pure(),
        //   formState: LinkEnum.sending,
        // ),
        DiscountLinkFormState(
          link: LinkFieldModel.dirty(KTestText.linkModel.link),
          formState: LinkEnum.success,
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
        // const DiscountLinkFormState(
        //   link: LinkFieldModel.dirty(KTestText.field),
        //   formState: LinkEnum.invalidData,
        // ),
        const DiscountLinkFormState(
          link: LinkFieldModel.dirty(KTestText.field),
          formState: LinkEnum.success,
        ),
        DiscountLinkFormState(
          link: LinkFieldModel.dirty(KTestText.linkModelWrong.link),
          formState: LinkEnum.inProgress,
        ),

        DiscountLinkFormState(
          link: LinkFieldModel.dirty(KTestText.linkModelWrong.link),
          formState: LinkEnum.success,
        ),
        const DiscountLinkFormState(
          link: LinkFieldModel.pure(),
          formState: LinkEnum.success,
        ),
        // const DiscountLinkFormState(
        //   link: LinkFieldModel.pure(),
        //   formState: LinkEnum.sending,
        // ),
        // const DiscountLinkFormState(
        //   link: LinkFieldModel.pure(),
        //   formState: LinkEnum.initial,
        //   failure: DiscountLinkFormFailure.error,
        // ),
      ],
    );

    blocTest<DiscountLinkFormBloc, DiscountLinkFormState>(
      'emits [LinkEnum.inProgress, LinkEnum.success] when valid link'
      ' is provided',
      build: () => discountLinkFormBloc,
      act: (bloc) async => bloc
        ..add(DiscountLinkFormEvent.updateLink(KTestText.linkModel.link))
        ..add(const DiscountLinkFormEvent.sendLink()),
      expect: () async => [
        DiscountLinkFormState(
          link: LinkFieldModel.dirty(KTestText.linkModel.link),
          formState: LinkEnum.inProgress,
        ),
        DiscountLinkFormState(
          link: LinkFieldModel.dirty(KTestText.linkModel.link),
          formState: LinkEnum.success,
        ),
        const DiscountLinkFormState(
          link: LinkFieldModel.pure(),
          formState: LinkEnum.success,
        ),
      ],
    );

    blocTest<DiscountLinkFormBloc, DiscountLinkFormState>(
      'emits [LinkEnum.inProgress, LinkEnum.success] when invalid link'
      ' is provided',
      build: () => discountLinkFormBloc,
      act: (bloc) async => bloc
        ..add(DiscountLinkFormEvent.updateLink(KTestText.linkModel.link))
        ..add(const DiscountLinkFormEvent.sendLink()),
      expect: () async => [
        DiscountLinkFormState(
          link: LinkFieldModel.dirty(KTestText.linkModel.link),
          formState: LinkEnum.inProgress,
        ),
        DiscountLinkFormState(
          link: LinkFieldModel.dirty(KTestText.linkModel.link),
          formState: LinkEnum.success,
        ),
        const DiscountLinkFormState(
          link: LinkFieldModel.pure(),
          formState: LinkEnum.success,
        ),
      ],
    );

    blocTest<DiscountLinkFormBloc, DiscountLinkFormState>(
      'emits [LinkEnum.inProgress, LinkEnum.success] when link is updated and'
      ' sent multiple times',
      build: () => discountLinkFormBloc,
      act: (bloc) async => bloc
        ..add(
          const DiscountLinkFormEvent.sendLink(),
        ),
      seed: () => DiscountLinkFormState(
        link: LinkFieldModel.dirty(KTestText.linkModel.link),
        formState: LinkEnum.inProgress,
      ),
      expect: () async => [
        DiscountLinkFormState(
          link: LinkFieldModel.dirty(KTestText.linkModel.link),
          formState: LinkEnum.success,
        ),
        const DiscountLinkFormState(
          link: LinkFieldModel.pure(),
          formState: LinkEnum.success,
        ),
      ],
    );

    blocTest<DiscountLinkFormBloc, DiscountLinkFormState>(
      'emits [LinkEnum.inProgress, LinkEnum.success] when valid link is added'
      ' and sendLink is called',
      build: () {
        // Set up the mock responses for the repository and current user
        when(mockAppAuthenticationRepository.currentUser)
            .thenReturn(KTestText.user);
        when(mockdiscountRepository.sendLink(KTestText.linkModel)).thenAnswer(
          (_) async => const Right(true),
        );

        return discountLinkFormBloc;
      },
      seed: () => DiscountLinkFormState(
        link: LinkFieldModel.dirty(KTestText.linkModel.link),
        formState: LinkEnum.inProgress,
      ),
      act: (bloc) async {
        // Trigger the sendLink event
        bloc.add(const DiscountLinkFormEvent.sendLink());
      },
      expect: () async => [
        DiscountLinkFormState(
          link: LinkFieldModel.dirty(KTestText.linkModel.link),
          formState: LinkEnum.success,
        ),
        const DiscountLinkFormState(
          link: LinkFieldModel.pure(),
          formState: LinkEnum.success,
        ),
      ],
      verify: (_) {
        // Verify that the sendLink method is called with the correct LinkModel
        verify(mockdiscountRepository.sendLink(KTestText.linkModel)).called(1);
      },
    );
  });
}
