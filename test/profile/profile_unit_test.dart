import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/profile/bloc/profile_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.profile} ${KGroupText.bloc}', () {
    late ProfileBloc profileBloc;
    late UserRepository mockUserRepository;
    late IDataPickerRepository mockDataPickerRepository;

    setUp(() {
      mockUserRepository = MockUserRepository();
      mockDataPickerRepository = MockIDataPickerRepository();

      when(mockUserRepository.currentUser).thenAnswer(
        (realInvocation) => KTestVariables.user,
      );

      when(
        mockDataPickerRepository.getImage,
      ).thenAnswer(
        (realInvocation) async => KTestVariables.filePickerItem,
      );

      when(
        mockUserRepository.updateUserData(
          user: KTestVariables.profileUser,
          image: KTestVariables.filePickerItem,
          nickname: KTestVariables.nicknameCorrect,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );

      when(mockUserRepository.currentUserSetting).thenAnswer(
        (realInvocation) => KTestVariables.userSettingModel,
      );

      profileBloc = ProfileBloc(
        userRepository: mockUserRepository,
        dataPickerRepository: mockDataPickerRepository,
      )..add(const ProfileEvent.started());
    });

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileState] when name is updated',
      build: () => profileBloc,
      act: (bloc) =>
          bloc.add(const ProfileEvent.nameUpdated(KTestVariables.nameCorrect)),
      expect: () => [
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.usernameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileState] when surname is updated',
      build: () => profileBloc,
      act: (bloc) => bloc.add(
        const ProfileEvent.surnameUpdated(KTestVariables.surnameCorrect),
      ),
      expect: () => [
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.usernameCorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileState] when nickname is updated',
      build: () => profileBloc,
      act: (bloc) => bloc.add(
        const ProfileEvent.nicknameUpdated(KTestVariables.nicknameCorrect),
      ),
      expect: () => [
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.usernameCorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.usernameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.dirty(KTestVariables.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileState] with success when valid data is saved',
      build: () {
        return profileBloc;
      },
      act: (bloc) async => bloc
        ..add(const ProfileEvent.nameUpdated(KTestVariables.nameCorrect))
        ..add(const ProfileEvent.surnameUpdated(KTestVariables.surnameCorrect))
        ..add(
          const ProfileEvent.nicknameUpdated(KTestVariables.nicknameCorrect),
        )
        ..add(const ProfileEvent.imageUpdated())
        ..add(const ProfileEvent.save()),
      expect: () => [
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.usernameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.dirty(KTestVariables.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        ProfileState(
          name: const NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: const SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
          nickname:
              const NicknameFieldModel.dirty(KTestVariables.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        ProfileState(
          name: const NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: const SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
          nickname:
              const NicknameFieldModel.dirty(KTestVariables.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.sendInProgress,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.dirty(KTestVariables.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.success,
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileState] with failure when saving fails',
      build: () => profileBloc,
      act: (bloc) async => bloc
        ..add(const ProfileEvent.nameUpdated(KTestVariables.nameIncorrect))
        ..add(const ProfileEvent.surnameUpdated(KTestVariables.surnameCorrect))
        ..add(
          const ProfileEvent.nicknameUpdated(KTestVariables.nicknameCorrect),
        )
        ..add(const ProfileEvent.imageUpdated())
        ..add(const ProfileEvent.save()),
      expect: () => [
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.nameIncorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.usernameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.nameIncorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.nameIncorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.dirty(KTestVariables.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        ProfileState(
          name: const NameFieldModel.dirty(KTestVariables.nameIncorrect),
          surname: const SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
          nickname:
              const NicknameFieldModel.dirty(KTestVariables.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        ProfileState(
          name: const NameFieldModel.dirty(KTestVariables.nameIncorrect),
          surname: const SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
          nickname:
              const NicknameFieldModel.dirty(KTestVariables.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.invalidData,
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileState] with unmodify success',
      build: () {
        when(mockUserRepository.currentUser).thenAnswer(
          (realInvocation) => KTestVariables.profileUser,
        );

        when(
          mockUserRepository.updateUserData(
            user: KTestVariables.profileUser,
            image: null,
            nickname: KTestVariables.nicknameCorrect,
          ),
        ).thenAnswer(
          (realInvocation) async => const Right(false),
        );

        return profileBloc;
      },
      act: (bloc) async => bloc
        ..add(const ProfileEvent.started())
        ..add(const ProfileEvent.save()),
      expect: () => [
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.initial,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.sendInProgress,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.succesesUnmodified,
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [FeedbackState] when valid data is submitted '
      'with incorrect credentials',
      build: () => profileBloc,
      act: (bloc) {
        when(
          mockUserRepository.updateUserData(
            user: KTestVariables.profileUser,
            image: KTestVariables.filePickerItem,
            nickname: KTestVariables.nicknameCorrect,
          ),
        ).thenAnswer(
          (realInvocation) async => Left(
            SomeFailure.serverError(
              error: KGroupText.failureSend,
            ),
          ),
        );

        bloc
          ..add(const ProfileEvent.nameUpdated(KTestVariables.nameCorrect))
          ..add(
            const ProfileEvent.surnameUpdated(KTestVariables.surnameCorrect),
          )
          ..add(
            const ProfileEvent.nicknameUpdated(
              KTestVariables.nicknameCorrect,
            ),
          )
          ..add(const ProfileEvent.imageUpdated())
          ..add(const ProfileEvent.save());
      },
      expect: () => [
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.usernameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.dirty(KTestVariables.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        ProfileState(
          name: const NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: const SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
          nickname:
              const NicknameFieldModel.dirty(KTestVariables.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        ProfileState(
          name: const NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: const SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
          nickname:
              const NicknameFieldModel.dirty(KTestVariables.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.sendInProgress,
        ),
        ProfileState(
          name: const NameFieldModel.dirty(KTestVariables.nameCorrect),
          surname: const SurnameFieldModel.dirty(KTestVariables.surnameCorrect),
          image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
          nickname:
              const NicknameFieldModel.dirty(KTestVariables.nicknameCorrect),
          failure: ProfileFailure.error,
          formState: ProfileEnum.initial,
        ),
      ],
    );
  });
}
