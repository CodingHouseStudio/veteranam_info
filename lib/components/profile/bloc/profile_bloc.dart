import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'profile_bloc.freezed.dart';
part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          const ProfileState(
            name: NameFieldModel.pure(),
            surname: SurnameFieldModel.pure(),
            image: ImageFieldModel.pure(),
            nickname: NicknameFieldModel.pure(),
            failure: null,
            formState: ProfileEnum.initial,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_NameUpdated>(_onNameUpdated);
    on<_SurnameUpdated>(_onSurnameUpdated);
    on<_ImageUpdated>(_onImageUpdated);
    on<_NicknameUpdated>(_onNicknameUpdated);
    on<_Save>(_onSave);
  }

  final AuthenticationRepository _authenticationRepository;
  //final imagePicker = imagePickerValue;
  @visibleForTesting
  static ImagePicker imagePickerValue = ImagePicker();

  Future<void> _onStarted(
    _Started event,
    Emitter<ProfileState> emit,
  ) async {
    final user = _authenticationRepository.currentUser;
    final nameFieldModel = NameFieldModel.dirty(
      user.firstName ?? '',
    );
    final surnameFieldModel = SurnameFieldModel.dirty(
      user.lastName ?? '',
    );
    emit(
      ProfileState(
        name: nameFieldModel,
        surname: surnameFieldModel,
        image: const ImageFieldModel.pure(),
        nickname: const NicknameFieldModel.pure(),
        failure: null,
        formState: ProfileEnum.initial,
      ),
    );
  }

  Future<void> _onNameUpdated(
    _NameUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    final nameFieldModel = NameFieldModel.dirty(event.name);
    emit(
      state.copyWith(
        name: nameFieldModel,
        formState: ProfileEnum.inProgress,
        failure: null,
      ),
    );
  }

  Future<void> _onSurnameUpdated(
    _SurnameUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    final surnameFieldModel = SurnameFieldModel.dirty(event.surname);
    emit(
      state.copyWith(
        surname: surnameFieldModel,
        formState: ProfileEnum.inProgress,
        failure: null,
      ),
    );
  }

  Future<void> _onImageUpdated(
    _ImageUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    final imageFieldModel = ImageFieldModel.dirty(
      await imagePickerValue.pickImage(source: ImageSource.gallery),
    );
    if (imageFieldModel.value == null) return;

    emit(
      state.copyWith(
        image: imageFieldModel,
        formState: ProfileEnum.inProgress,
        failure: null,
      ),
    );
  }

  Future<void> _onNicknameUpdated(
    _NicknameUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        nickname: NicknameFieldModel.dirty(event.nickname),
        formState: ProfileEnum.inProgress,
        failure: null,
      ),
    );
  }

  Future<void> _onSave(
    _Save event,
    Emitter<ProfileState> emit,
  ) async {
    if (Formz.validate(
      [
        state.name,
        state.surname,
        state.nickname,
      ],
    )) {
      emit(state.copyWith(formState: ProfileEnum.sendInProgress));

      final result = await _authenticationRepository.updateUserData(
        user: _authenticationRepository.currentUser.copyWith(
          name: '${state.name.value} ${state.surname.value}',
        ),
        image: state.image.value != null
            ? ImageModel(
                downloadURL: state.image.value!.path,
                name: state.image.value!.name,
                ref: state.image.value!.path,
              )
            : null,
        nickname: state.nickname.isPure
            ? _authenticationRepository.currentUserSetting.nickname
            : state.nickname.value,
      );

      result.fold(
        (l) => emit(
          state.copyWith(
            failure: l._toProfileError(),
            formState: ProfileEnum.initial,
          ),
        ),
        (r) => emit(
          state.copyWith(
            failure: null,
            image: const ImageFieldModel.pure(),
            formState: r ? ProfileEnum.success : ProfileEnum.succesesUnmodified,
          ),
        ),
      );
    } else {
      emit(state.copyWith(formState: ProfileEnum.invalidData));
    }
  }
}
