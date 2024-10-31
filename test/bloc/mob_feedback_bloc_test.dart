import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.feedback} ${KGroupText.bloc} ', () {
    late MobFeedbackBloc mobFeedbackBloc;
    late IFeedbackRepository mockFeedbackRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late Uint8List image;
    late Uint8List wrongImage;
    setUp(() {
      ExtendedDateTime.current = KTestText.dateTime;
      ExtendedDateTime.id = KTestText.feedbackModel.id;
      image = Uint8List(1);
      wrongImage = Uint8List(2);
      mockFeedbackRepository = MockIFeedbackRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      when(
        mockFeedbackRepository.sendMobFeedback(
          feedback: KTestText.feedbackImageModel.copyWith(image: null),
          image: image,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(
        mockFeedbackRepository.sendMobFeedback(
          feedback: KTestText.feedbackImageModel.copyWith(image: null),
          image: wrongImage,
        ),
      ).thenAnswer(
        (realInvocation) async => Left(
          SomeFailure.serverError(
            error: null,
          ),
        ),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestText.user,
      );
      when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => KTestText.userSetting,
      );
      mobFeedbackBloc = MobFeedbackBloc(
        feedbackRepository: mockFeedbackRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<MobFeedbackBloc, MobFeedbackState>(
      'emits [FeedbackState] when valid message'
      ' are changed and send it',
      build: () => mobFeedbackBloc,
      act: (bloc) => bloc
        ..add(const MobFeedbackEvent.messageUpdated(KTestText.field))
        ..add(MobFeedbackEvent.send(image)),
      expect: () => [
        const MobFeedbackState(
          formState: MobFeedbackEnum.inProgress,
          message: MessageFieldModel.dirty(KTestText.field),
          failure: null,
        ),
        const MobFeedbackState(
          formState: MobFeedbackEnum.success,
          message: MessageFieldModel.pure(),
          failure: null,
        ),
      ],
    );
    blocTest<MobFeedbackBloc, MobFeedbackState>(
      'emits [FeedbackState] when invalid message'
      ' are changed and send it',
      build: () => mobFeedbackBloc,
      act: (bloc) => bloc
        ..add(const MobFeedbackEvent.messageUpdated(KTestText.fieldEmpty))
        ..add(MobFeedbackEvent.send(image)),
      expect: () => [
        const MobFeedbackState(
          formState: MobFeedbackEnum.inProgress,
          message: MessageFieldModel.dirty(),
          failure: null,
        ),
        const MobFeedbackState(
          formState: MobFeedbackEnum.invalidData,
          message: MessageFieldModel.dirty(),
          failure: null,
        ),
      ],
    );
    blocTest<MobFeedbackBloc, MobFeedbackState>(
      'emits [FeedbackState] when valid message'
      ' are changed and failure send it',
      build: () => mobFeedbackBloc,
      act: (bloc) => bloc
        ..add(const MobFeedbackEvent.messageUpdated(KTestText.field))
        ..add(MobFeedbackEvent.send(wrongImage)),
      expect: () => [
        const MobFeedbackState(
          formState: MobFeedbackEnum.inProgress,
          message: MessageFieldModel.dirty(KTestText.field),
          failure: null,
        ),
        const MobFeedbackState(
          formState: MobFeedbackEnum.inProgress,
          message: MessageFieldModel.dirty(KTestText.field),
          failure: MobFeedbackFailure.error,
        ),
      ],
    );
  });
}
