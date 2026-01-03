import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.feedback} ${KGroupText.bloc} ', () {
    late MobFeedbackBloc mobFeedbackBloc;
    late IFeedbackRepository mockFeedbackRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late Uint8List image;
    late Uint8List wrongImage;
    setUp(() {
      ExtendedDateTime.current = KTestVariables.dateTime;
      ExtendedDateTime.id = KTestVariables.feedbackModel.id;
      image = Uint8List(1);
      wrongImage = Uint8List(2);
      mockFeedbackRepository = MockIFeedbackRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      when(
        mockFeedbackRepository.sendMobFeedback(
          feedback: KTestVariables.feedbackImageModel.copyWith(image: null),
          image: image,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(
        mockFeedbackRepository.sendMobFeedback(
          feedback: KTestVariables.feedbackImageModel.copyWith(image: null),
          image: wrongImage,
        ),
      ).thenAnswer(
        (realInvocation) async => const Left(
          SomeFailure.serverError,
        ),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestVariables.user,
      );
      when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => KTestVariables.userSetting,
      );
      mobFeedbackBloc = MobFeedbackBloc(
        feedbackRepository: mockFeedbackRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<MobFeedbackBloc, MobFeedbackState>(
      'emits [FeedbackState] when valid message, email'
      ' are changed and send it',
      build: () => mobFeedbackBloc,
      act: (bloc) => bloc
        ..add(const MobFeedbackEvent.messageUpdated(KTestVariables.field))
        ..add(const MobFeedbackEvent.emailUpdated(KTestVariables.userEmail))
        ..add(MobFeedbackEvent.send(image)),
      expect: () => [
        const MobFeedbackState(
          formState: MobFeedbackEnum.inProgress,
          message: MessageFieldModel.dirty(KTestVariables.field),
          email: EmailFieldModel.pure(),
          failure: null,
        ),
        const MobFeedbackState(
          formState: MobFeedbackEnum.inProgress,
          message: MessageFieldModel.dirty(KTestVariables.field),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          failure: null,
        ),
        const MobFeedbackState(
          formState: MobFeedbackEnum.success,
          message: MessageFieldModel.pure(),
          email: EmailFieldModel.pure(),
          failure: null,
        ),
      ],
    );
    blocTest<MobFeedbackBloc, MobFeedbackState>(
      'emits [FeedbackState] when invalid message, email'
      ' are changed and send it',
      build: () => mobFeedbackBloc,
      act: (bloc) => bloc
        ..add(const MobFeedbackEvent.messageUpdated(KTestVariables.fieldEmpty))
        ..add(
          const MobFeedbackEvent.emailUpdated(
            KTestVariables.userEmailIncorrect,
          ),
        )
        ..add(MobFeedbackEvent.send(image)),
      expect: () => [
        const MobFeedbackState(
          formState: MobFeedbackEnum.inProgress,
          message: MessageFieldModel.dirty(),
          email: EmailFieldModel.pure(),
          failure: null,
        ),
        const MobFeedbackState(
          formState: MobFeedbackEnum.inProgress,
          message: MessageFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
          failure: null,
        ),
        const MobFeedbackState(
          formState: MobFeedbackEnum.invalidData,
          message: MessageFieldModel.dirty(),
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
          failure: null,
        ),
      ],
    );
    blocTest<MobFeedbackBloc, MobFeedbackState>(
      'emits [FeedbackState] when message, invalid email'
      ' are changed and send it',
      build: () => mobFeedbackBloc,
      act: (bloc) => bloc
        ..add(const MobFeedbackEvent.messageUpdated(KTestVariables.field))
        ..add(
          const MobFeedbackEvent.emailUpdated(
            KTestVariables.userEmailIncorrect,
          ),
        )
        ..add(MobFeedbackEvent.send(image)),
      expect: () => [
        const MobFeedbackState(
          formState: MobFeedbackEnum.inProgress,
          message: MessageFieldModel.dirty(KTestVariables.field),
          email: EmailFieldModel.pure(),
          failure: null,
        ),
        const MobFeedbackState(
          formState: MobFeedbackEnum.inProgress,
          message: MessageFieldModel.dirty(KTestVariables.field),
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
          failure: null,
        ),
        const MobFeedbackState(
          formState: MobFeedbackEnum.success,
          message: MessageFieldModel.pure(),
          email: EmailFieldModel.pure(),
          failure: null,
        ),
      ],
    );
    blocTest<MobFeedbackBloc, MobFeedbackState>(
      'emits [FeedbackState] when valid message, email'
      ' are changed and failure send it',
      build: () => mobFeedbackBloc,
      act: (bloc) => bloc
        ..add(const MobFeedbackEvent.messageUpdated(KTestVariables.field))
        ..add(const MobFeedbackEvent.emailUpdated(KTestVariables.userEmail))
        ..add(MobFeedbackEvent.send(wrongImage)),
      expect: () => [
        const MobFeedbackState(
          formState: MobFeedbackEnum.inProgress,
          message: MessageFieldModel.dirty(KTestVariables.field),
          email: EmailFieldModel.pure(),
          failure: null,
        ),
        const MobFeedbackState(
          formState: MobFeedbackEnum.inProgress,
          message: MessageFieldModel.dirty(KTestVariables.field),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          failure: null,
        ),
        const MobFeedbackState(
          formState: MobFeedbackEnum.inProgress,
          message: MessageFieldModel.dirty(KTestVariables.field),
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          failure: SomeFailure.serverError,
        ),
      ],
    );
  });
}
