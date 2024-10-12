import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group(
      '${KScreenBlocName.storyAdd} ${KGroupText.bloc} ${KGroupText.uncorrect}',
      () {
    late StoryAddBloc storyAddBloc;
    late IStoryRepository mockStoryRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late IDataPickerRepository mockDataPickerRepository;

    setUp(() {
      ExtendedDateTime.id = KTestText.storyModelItems.last.id;
      ExtendedDateTime.current = KTestText.dateTime;
      mockDataPickerRepository = MockIDataPickerRepository();

      when(
        mockDataPickerRepository.getImage,
      ).thenAnswer(
        (realInvocation) async => KTestText.imagePickerItem,
      );

      mockStoryRepository = MockIStoryRepository();
      when(
        mockStoryRepository.addStory(
          imageItem: KTestText.imagePickerItem,
          storyModel: KTestText.storyModelItems.first.copyWith(
            userPhoto: KTestText.userPhotoModel,
            id: KTestText.storyModelItems.last.id,
          ),
        ),
      ).thenAnswer(
        (realInvocation) async => Left(
          SomeFailure.serverError(
            error: null,
          ),
        ),
      );
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestText.user,
      );
      storyAddBloc = StoryAddBloc(
        storyRepository: mockStoryRepository,
        iAppAuthenticationRepository: mockAppAuthenticationRepository,
        dataPickerRepository: mockDataPickerRepository,
      );
    });

    blocTest<StoryAddBloc, StoryAddState>(
      'emits [StoryAddState()] when photo updated and save',
      build: () => storyAddBloc,
      act: (bloc) async {
        bloc
          ..add(const StoryAddEvent.imageUpdated())
          ..add(const StoryAddEvent.save());
      },
      expect: () async => [
        predicate<StoryAddState>(
          (state) =>
              state.image != const ImageFieldModel.pure() &&
              state.formStatus == FormzSubmissionStatus.inProgress,
        ),
        predicate<StoryAddState>(
          (state) =>
              state.story == const MessageFieldModel.pure() &&
              state.formStatus == FormzSubmissionStatus.failure,
        ),
      ],
    );
    blocTest<StoryAddBloc, StoryAddState>(
      'emits [StoryAddState()] when empty story, photo updated and save',
      build: () => storyAddBloc,
      act: (bloc) async {
        bloc
          ..add(
            const StoryAddEvent.storyUpdated(KTestText.fieldEmpty),
          )
          ..add(const StoryAddEvent.imageUpdated())
          ..add(const StoryAddEvent.save());
      },
      expect: () async => [
        predicate<StoryAddState>(
          (state) =>
              state.story == const MessageFieldModel.dirty() &&
              state.formStatus == FormzSubmissionStatus.inProgress,
        ),
        predicate<StoryAddState>(
          (state) =>
              state.image != const ImageFieldModel.pure() &&
              state.formStatus == FormzSubmissionStatus.inProgress,
        ),
        predicate<StoryAddState>(
          (state) => state.formStatus == FormzSubmissionStatus.failure,
        ),
      ],
    );

    blocTest<StoryAddBloc, StoryAddState>(
      'emits [StoryAddState()] when story, empty photo updated and save',
      build: () => storyAddBloc,
      act: (bloc) async {
        bloc
          ..add(
            StoryAddEvent.storyUpdated(KTestText.storyModelItems.last.story),
          )
          ..add(const StoryAddEvent.imageUpdated())
          ..add(const StoryAddEvent.save());
      },
      expect: () async => [
        predicate<StoryAddState>(
          (state) =>
              state.story ==
                  MessageFieldModel.dirty(
                    KTestText.storyModelItems.last.story,
                  ) &&
              state.formStatus == FormzSubmissionStatus.inProgress,
        ),
        predicate<StoryAddState>(
          (state) =>
              state.image != const ImageFieldModel.pure() &&
              state.formStatus == FormzSubmissionStatus.inProgress,
        ),
        predicate<StoryAddState>(
          (state) => state.formStatus == FormzSubmissionStatus.failure,
        ),
      ],
    );

    blocTest<StoryAddBloc, StoryAddState>(
      'emits [StoryAddState()] when story and save',
      build: () => storyAddBloc,
      act: (bloc) async {
        bloc
          ..add(
            StoryAddEvent.storyUpdated(KTestText.storyModelItems.first.story),
          )
          ..add(const StoryAddEvent.save());
      },
      expect: () async => [
        predicate<StoryAddState>(
          (state) =>
              state.story ==
                  MessageFieldModel.dirty(
                    KTestText.storyModelItems.first.story,
                  ) &&
              state.formStatus == FormzSubmissionStatus.inProgress,
        ),
        predicate<StoryAddState>(
          (state) => state.failure == StoryAddFailure.error,
        ),
      ],
    );
  });
}
