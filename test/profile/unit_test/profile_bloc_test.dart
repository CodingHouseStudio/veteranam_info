import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);

  group('ProfileBloc Tests', () {
    late ProfileBloc profileBloc;
    late AuthenticationRepository mockAuthenticationRepository;
    late ImagePicker mockImagePicker;
    late XFile image;

    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
      mockImagePicker = MockImagePicker();
      image = XFile(KTestText.imageModels.downloadURL);

      when(mockAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestText.user,
      );

      when(
        mockAuthenticationRepository.updateUserData(
          user: KTestText.profileUser,
          image: KTestText.imageModels,
          nickname: KTestText.nicknameCorrect,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );

      when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => KTestText.userSettingModel,
      );

      when(mockImagePicker.pickImage(source: ImageSource.gallery)).thenAnswer(
        (realInvocation) async => image,
      );
      ProfileBloc.imagePickerValue = mockImagePicker;

      profileBloc = ProfileBloc(
        authenticationRepository: mockAuthenticationRepository,
      );
    });

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileState] when name is updated',
      build: () => profileBloc,
      act: (bloc) =>
          bloc.add(const ProfileEvent.nameUpdated(KTestText.nameCorrect)),
      expect: () => [
        const ProfileState(
          name: NameFieldModel.dirty(KTestText.nameCorrect),
          surname: SurnameFieldModel.pure(),
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
      act: (bloc) =>
          bloc.add(const ProfileEvent.surnameUpdated(KTestText.surnameCorrect)),
      expect: () => [
        const ProfileState(
          name: NameFieldModel.pure(),
          surname: SurnameFieldModel.dirty(KTestText.surnameCorrect),
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
      act: (bloc) => bloc
          .add(const ProfileEvent.nicknameUpdated(KTestText.nicknameCorrect)),
      expect: () => [
        const ProfileState(
          name: NameFieldModel.pure(),
          surname: SurnameFieldModel.pure(),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.dirty(KTestText.nicknameCorrect),
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
        ..add(const ProfileEvent.nameUpdated(KTestText.nameCorrect))
        ..add(const ProfileEvent.surnameUpdated(KTestText.surnameCorrect))
        ..add(const ProfileEvent.nicknameUpdated(KTestText.nicknameCorrect))
        ..add(const ProfileEvent.imageUpdated())
        ..add(const ProfileEvent.save()),
      expect: () => [
        const ProfileState(
          name: NameFieldModel.dirty(KTestText.nameCorrect),
          surname: SurnameFieldModel.pure(),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestText.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestText.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestText.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestText.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.dirty(KTestText.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        ProfileState(
          name: const NameFieldModel.dirty(KTestText.nameCorrect),
          surname: const SurnameFieldModel.dirty(KTestText.surnameCorrect),
          image: ImageFieldModel.dirty(image),
          nickname: const NicknameFieldModel.dirty(KTestText.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        ProfileState(
          name: const NameFieldModel.dirty(KTestText.nameCorrect),
          surname: const SurnameFieldModel.dirty(KTestText.surnameCorrect),
          image: ImageFieldModel.dirty(image),
          nickname: const NicknameFieldModel.dirty(KTestText.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.sendInProgress,
        ),
        ProfileState(
          name: const NameFieldModel.dirty(KTestText.nameCorrect),
          surname: const SurnameFieldModel.dirty(KTestText.surnameCorrect),
          image: ImageFieldModel.dirty(image),
          nickname: const NicknameFieldModel.dirty(KTestText.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.success,
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileState] with failure when saving fails',
      build: () => profileBloc,
      act: (bloc) async => bloc
        ..add(const ProfileEvent.nameUpdated(KTestText.nameIncorrect))
        ..add(const ProfileEvent.surnameUpdated(KTestText.surnameCorrect))
        ..add(const ProfileEvent.nicknameUpdated(KTestText.nicknameCorrect))
        ..add(const ProfileEvent.imageUpdated())
        ..add(const ProfileEvent.save()),
      expect: () => [
        const ProfileState(
          name: NameFieldModel.dirty(KTestText.nameIncorrect),
          surname: SurnameFieldModel.pure(),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestText.nameIncorrect),
          surname: SurnameFieldModel.dirty(KTestText.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestText.nameIncorrect),
          surname: SurnameFieldModel.dirty(KTestText.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.dirty(KTestText.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        ProfileState(
          name: const NameFieldModel.dirty(KTestText.nameIncorrect),
          surname: const SurnameFieldModel.dirty(KTestText.surnameCorrect),
          image: ImageFieldModel.dirty(image),
          nickname: const NicknameFieldModel.dirty(KTestText.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.inProgress,
        ),
        ProfileState(
          name: const NameFieldModel.dirty(KTestText.nameIncorrect),
          surname: const SurnameFieldModel.dirty(KTestText.surnameCorrect),
          image: ImageFieldModel.dirty(image),
          nickname: const NicknameFieldModel.dirty(KTestText.nicknameCorrect),
          failure: null,
          formState: ProfileEnum.invalidData,
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileState] with unmodify success',
      build: () {
        when(mockAuthenticationRepository.currentUser).thenAnswer(
          (realInvocation) => KTestText.profileUser,
        );

        when(
          mockAuthenticationRepository.updateUserData(
            user: KTestText.profileUser,
            image: null,
            nickname: KTestText.nicknameCorrect,
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
          name: NameFieldModel.dirty(KTestText.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestText.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.initial,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestText.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestText.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.sendInProgress,
        ),
        const ProfileState(
          name: NameFieldModel.dirty(KTestText.nameCorrect),
          surname: SurnameFieldModel.dirty(KTestText.surnameCorrect),
          image: ImageFieldModel.pure(),
          nickname: NicknameFieldModel.pure(),
          failure: null,
          formState: ProfileEnum.succesesUnmodified,
        ),
      ],
    );
  });
}
