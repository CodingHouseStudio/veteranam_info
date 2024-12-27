import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/field_model/field_model.dart';
import 'package:veteranam/shared/shared_dart.dart';

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
      ExtendedDateTime.id = KTestVariables.id;
      ExtendedDateTime.current = KTestVariables.dateTime;
      mockdiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(mockdiscountRepository.sendLink(KTestVariables.linkModel))
          .thenAnswer(
        (_) async => const Right(true),
      );
      when(
        mockdiscountRepository.sendLink(
          KTestVariables.linkModelWrong,
        ),
      ).thenAnswer(
        (_) async => Left(SomeFailure.serverError(error: null)),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestVariables.user,
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
        ..add(DiscountLinkFormEvent.updateLink(KTestVariables.linkModel.link))
        ..add(const DiscountLinkFormEvent.sendLink()),
      expect: () async => [
        DiscountLinkFormState(
          link: DiscountLinkFieldModel.dirty(KTestVariables.linkModel.link),
          formState: LinkEnum.inProgress,
        ),
        // const DiscountLinkFormState(
        //   link: DiscountLinkFieldModel.pure(),
        //   formState: LinkEnum.sending,
        // ),
        DiscountLinkFormState(
          link: DiscountLinkFieldModel.dirty(KTestVariables.linkModel.link),
          formState: LinkEnum.success,
        ),
        const DiscountLinkFormState(
          link: DiscountLinkFieldModel.pure(),
          formState: LinkEnum.success,
        ),
      ],
    );

    blocTest<DiscountLinkFormBloc, DiscountLinkFormState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list',
      build: () => discountLinkFormBloc,
      act: (bloc) async => bloc
        ..add(const DiscountLinkFormEvent.updateLink(KTestVariables.field))
        ..add(const DiscountLinkFormEvent.sendLink())
        ..add(
          DiscountLinkFormEvent.updateLink(
            KTestVariables.linkModelWrong.link,
          ),
        )
        ..add(const DiscountLinkFormEvent.sendLink()),
      expect: () async => [
        const DiscountLinkFormState(
          link: DiscountLinkFieldModel.dirty(KTestVariables.field),
          formState: LinkEnum.inProgress,
        ),
        // const DiscountLinkFormState(
        //   link: DiscountLinkFieldModel.dirty(KTestText.field),
        //   formState: LinkEnum.invalidData,
        // ),
        const DiscountLinkFormState(
          link: DiscountLinkFieldModel.dirty(KTestVariables.field),
          formState: LinkEnum.success,
        ),
        DiscountLinkFormState(
          link:
              DiscountLinkFieldModel.dirty(KTestVariables.linkModelWrong.link),
          formState: LinkEnum.inProgress,
        ),

        DiscountLinkFormState(
          link:
              DiscountLinkFieldModel.dirty(KTestVariables.linkModelWrong.link),
          formState: LinkEnum.success,
        ),
        const DiscountLinkFormState(
          link: DiscountLinkFieldModel.pure(),
          formState: LinkEnum.success,
        ),
        // const DiscountLinkFormState(
        //   link: DiscountLinkFieldModel.pure(),
        //   formState: LinkEnum.sending,
        // ),
        // const DiscountLinkFormState(
        //   link: DiscountLinkFieldModel.pure(),
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
        ..add(DiscountLinkFormEvent.updateLink(KTestVariables.linkModel.link))
        ..add(const DiscountLinkFormEvent.sendLink()),
      expect: () async => [
        DiscountLinkFormState(
          link: DiscountLinkFieldModel.dirty(KTestVariables.linkModel.link),
          formState: LinkEnum.inProgress,
        ),
        DiscountLinkFormState(
          link: DiscountLinkFieldModel.dirty(KTestVariables.linkModel.link),
          formState: LinkEnum.success,
        ),
        const DiscountLinkFormState(
          link: DiscountLinkFieldModel.pure(),
          formState: LinkEnum.success,
        ),
      ],
    );

    blocTest<DiscountLinkFormBloc, DiscountLinkFormState>(
      'emits [LinkEnum.inProgress, LinkEnum.success] when invalid link'
      ' is provided',
      build: () => discountLinkFormBloc,
      act: (bloc) async => bloc
        ..add(DiscountLinkFormEvent.updateLink(KTestVariables.linkModel.link))
        ..add(const DiscountLinkFormEvent.sendLink()),
      expect: () async => [
        DiscountLinkFormState(
          link: DiscountLinkFieldModel.dirty(KTestVariables.linkModel.link),
          formState: LinkEnum.inProgress,
        ),
        DiscountLinkFormState(
          link: DiscountLinkFieldModel.dirty(KTestVariables.linkModel.link),
          formState: LinkEnum.success,
        ),
        const DiscountLinkFormState(
          link: DiscountLinkFieldModel.pure(),
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
        link: DiscountLinkFieldModel.dirty(KTestVariables.linkModel.link),
        formState: LinkEnum.inProgress,
      ),
      expect: () async => [
        DiscountLinkFormState(
          link: DiscountLinkFieldModel.dirty(KTestVariables.linkModel.link),
          formState: LinkEnum.success,
        ),
        const DiscountLinkFormState(
          link: DiscountLinkFieldModel.pure(),
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
            .thenReturn(KTestVariables.user);
        when(mockdiscountRepository.sendLink(KTestVariables.linkModel))
            .thenAnswer(
          (_) async => const Right(true),
        );

        return discountLinkFormBloc;
      },
      seed: () => DiscountLinkFormState(
        link: DiscountLinkFieldModel.dirty(KTestVariables.linkModel.link),
        formState: LinkEnum.inProgress,
      ),
      act: (bloc) async {
        // Trigger the sendLink event
        bloc.add(const DiscountLinkFormEvent.sendLink());
      },
      expect: () async => [
        DiscountLinkFormState(
          link: DiscountLinkFieldModel.dirty(KTestVariables.linkModel.link),
          formState: LinkEnum.success,
        ),
        const DiscountLinkFormState(
          link: DiscountLinkFieldModel.pure(),
          formState: LinkEnum.success,
        ),
      ],
      verify: (_) {
        // Verify that the sendLink method is called with the correct LinkModel
        verify(mockdiscountRepository.sendLink(KTestVariables.linkModel))
            .called(1);
      },
    );
  });
}
