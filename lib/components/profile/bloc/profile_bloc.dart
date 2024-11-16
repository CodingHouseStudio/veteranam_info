import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'profile_bloc.freezed.dart';
part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required UserRepository userRepository,
    required IDataPickerRepository dataPickerRepository,
  })  : _userRepository = userRepository,
        _dataPickerRepository = dataPickerRepository,
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

  final UserRepository _userRepository;
  final IDataPickerRepository _dataPickerRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<ProfileState> emit,
  ) async {
    final user = _userRepository.currentUser;
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
    final imageBytes = await _dataPickerRepository.getImage;
    if (imageBytes == null || imageBytes.bytes.isEmpty) return;
    final imageFieldModel = ImageFieldModel.dirty(
      imageBytes,
    );

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
      final name = '${state.name.value} ${state.surname.value}';

      if (name == _userRepository.currentUser.name &&
          // state.nickname.value ==
          //     _authenticationRepository.currentUserSetting.nickname &&
          state.image.value == null) {
        emit(
          state.copyWith(
            formState: ProfileEnum.succesesUnmodified,
          ),
        );
        return;
      }
      final result = await _userRepository.updateUserData(
        user: _userRepository.currentUser.copyWith(
          name: name,
        ),
        nickname: state.nickname.isPure
            ? _userRepository.currentUserSetting.nickname
            : state.nickname.value,
        image: state.image.value,
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
            formState: ProfileEnum.success,
          ),
        ),
      );
    } else {
      emit(state.copyWith(formState: ProfileEnum.invalidData));
    }
  }
}
