import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/components/story_add/bloc/story_add_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
  group(
      '${KScreenBlocName.storyAdd} ${KGroupText.bloc} ${KGroupText.uncorrect}',
      () {
    late StoryAddBloc storyAddBloc;
    late IStoryRepository mockStoryRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late IDataPickerRepository mockDataPickerRepository;

    setUp(() {
      ExtendedDateTime.id = KTestVariables.storyModelItems.first.id;
      ExtendedDateTime.current = KTestVariables.dateTime;
      mockDataPickerRepository = MockIDataPickerRepository();

      when(
        mockDataPickerRepository.getImage,
      ).thenAnswer(
        (realInvocation) async => KTestVariables.filePickerItem,
      );

      mockStoryRepository = MockIStoryRepository();
      when(
        mockStoryRepository.addStory(
          imageItem: KTestVariables.filePickerItem,
          storyModel: KTestVariables.storyModelItems.first.copyWith(
            userPhoto: KTestVariables.userPhotoModel,
          ),
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(
        mockStoryRepository.addStory(
          imageItem: KTestVariables.filePickerItem,
          storyModel: KTestVariables.storyModelItems.first
              .copyWith(userName: null, userPhoto: null),
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      // when(
      //   mockStoryRepository.addStory(
      //     imageItem: null,
      //     storyModel: KTestVariables.storyModelItems.first.copyWith(
      //       userPhoto: KTestVariables.userPhotoModel,
      //     ),
      //   ),
      // ).thenAnswer(
      //   (realInvocation) async => const Right(true),
      // );
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestVariables.user,
      );
      storyAddBloc = StoryAddBloc(
        storyRepository: mockStoryRepository,
        iAppAuthenticationRepository: mockAppAuthenticationRepository,
        dataPickerRepository: mockDataPickerRepository,
      );
    });

    blocTest<StoryAddBloc, StoryAddState>(
      'emits [StoryAddState()] when story, photo updated and save',
      build: () => storyAddBloc,
      act: (bloc) async {
        bloc
          ..add(
            StoryAddEvent.storyUpdated(
              KTestVariables.storyModelItems.last.story,
            ),
          )
          ..add(const StoryAddEvent.imageUpdated())
          ..add(const StoryAddEvent.save());
      },
      expect: () async => [
        predicate<StoryAddState>(
          (state) =>
              state.story ==
                  MessageFieldModel.dirty(
                    KTestVariables.storyModelItems.last.story,
                  ) &&
              state.formStatus == FormzSubmissionStatus.inProgress,
        ),
        predicate<StoryAddState>(
          (state) =>
              state.image != const ImageFieldModel.pure() &&
              state.formStatus == FormzSubmissionStatus.inProgress,
        ),
        predicate<StoryAddState>(
          (state) => state.formStatus == FormzSubmissionStatus.success,
        ),
      ],
    );
    blocTest<StoryAddBloc, StoryAddState>(
      'emits [StoryAddState()] when story, anonymously, photo updated'
      ' and save',
      build: () => storyAddBloc,
      act: (bloc) async {
        bloc
          ..add(
            StoryAddEvent.storyUpdated(
              KTestVariables.storyModelItems.last.story,
            ),
          )
          ..add(const StoryAddEvent.anonymouslyUpdated())
          ..add(const StoryAddEvent.imageUpdated())
          ..add(const StoryAddEvent.save());
      },
      expect: () async => [
        predicate<StoryAddState>(
          (state) =>
              state.story ==
                  MessageFieldModel.dirty(
                    KTestVariables.storyModelItems.last.story,
                  ) &&
              state.formStatus == FormzSubmissionStatus.inProgress,
        ),
        predicate<StoryAddState>(
          (state) =>
              state.isAnonymously == true &&
              state.formStatus == FormzSubmissionStatus.inProgress,
        ),
        predicate<StoryAddState>(
          (state) =>
              state.image != const ImageFieldModel.pure() &&
              state.formStatus == FormzSubmissionStatus.inProgress,
        ),
        predicate<StoryAddState>(
          (state) => state.formStatus == FormzSubmissionStatus.success,
        ),
      ],
    );
    // blocTest<StoryAddBloc, StoryAddState>(
    //   'emits [StoryAddState()] when story and save',
    //   build: () => storyAddBloc,
    //   act: (bloc) async {
    //     bloc
    //       ..add(
    //         StoryAddEvent.storyUpdated(KTestVariables.storyModelItems.first
    // .story),
    //       )
    //       ..add(const StoryAddEvent.save());
    //   },
    //   expect: () async => [
    //     predicate<StoryAddState>(
    //       (state) =>
    //           state.story ==
    //               MessageFieldModel.dirty(
    //                 KTestVariables.storyModelItems.first.story,
    //               ) &&
    //           state.formStatus == FormzSubmissionStatus.inProgress,
    //     ),
    //     predicate<StoryAddState>(
    //       (state) => state.formStatus == FormzSubmissionStatus.success,
    //     ),
    //   ],
    // );
  });
}
