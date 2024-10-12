import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'story_add_bloc.freezed.dart';
part 'story_add_event.dart';
part 'story_add_state.dart';

@Injectable(env: [Config.development])
class StoryAddBloc extends Bloc<StoryAddEvent, StoryAddState> {
  StoryAddBloc({
    required IStoryRepository storyRepository,
    required IAppAuthenticationRepository iAppAuthenticationRepository,
    required IDataPickerRepository dataPickerRepository,
  })  : _storyRepository = storyRepository,
        _iAppAuthenticationRepository = iAppAuthenticationRepository,
        _dataPickerRepository = dataPickerRepository,
        super(
          const _Initial(
            story: MessageFieldModel.pure(),
            image: ImageFieldModel.pure(),
            isAnonymously: false,
            formStatus: FormzSubmissionStatus.initial,
            failure: null,
          ),
        ) {
    on<_StoryUpdated>(_onStoryUpdated);
    on<_AnonymouslyUpdated>(_onAnonymouslyUpdated);
    on<_ImageUpdated>(_onImageUpdated);
    on<_Save>(_onSave);
  }
  final IStoryRepository _storyRepository;
  final IAppAuthenticationRepository _iAppAuthenticationRepository;
  final IDataPickerRepository _dataPickerRepository;
  void _onStoryUpdated(
    _StoryUpdated event,
    Emitter<StoryAddState> emit,
  ) {
    final messageFieldModel = MessageFieldModel.dirty(event.story);
    emit(
      state.copyWith(
        story: messageFieldModel,
        formStatus: FormzSubmissionStatus.inProgress,
      ),
    );
  }

  void _onAnonymouslyUpdated(
    _AnonymouslyUpdated event,
    Emitter<StoryAddState> emit,
  ) {
    emit(
      state.copyWith(
        isAnonymously: !state.isAnonymously,
        formStatus: FormzSubmissionStatus.inProgress,
      ),
    );
  }

  Future<void> _onImageUpdated(
    _ImageUpdated event,
    Emitter<StoryAddState> emit,
  ) async {
    final imageBytes = await _dataPickerRepository.getImage;
    if (imageBytes == null || imageBytes.bytes.isEmpty) return;
    final imageFieldModel = ImageFieldModel.dirty(
      imageBytes,
    );

    emit(
      state.copyWith(
        image: imageFieldModel,
        formStatus: FormzSubmissionStatus.inProgress,
      ),
    );
  }

  Future<void> _onSave(
    _Save event,
    Emitter<StoryAddState> emit,
  ) async {
    if (!Formz.validate([state.story, state.image]) ||
        _iAppAuthenticationRepository.currentUser.name == null ||
        _iAppAuthenticationRepository.isAnonymously) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.failure));
      return;
    }
    final result = await _storyRepository.addStory(
      storyModel: StoryModel(
        id: ExtendedDateTime.id,
        date: ExtendedDateTime.current,
        story: state.story.value,
        userName: state.isAnonymously
            ? null
            : _iAppAuthenticationRepository.currentUser.name,
        userPhoto: _iAppAuthenticationRepository.currentUser.photo != null &&
                !state.isAnonymously
            ? ImageModel(
                downloadURL: _iAppAuthenticationRepository.currentUser.photo!,
              )
            : null,
        userId: _iAppAuthenticationRepository.currentUser.id,
      ),
      imageItem: state.image.value,
    );
    result.fold(
      (l) => emit(state.copyWith(failure: l._toStoryAdd())),
      (r) => emit(
        state.copyWith(
          formStatus: FormzSubmissionStatus.success,
          failure: null,
        ),
      ),
    );
  }
}
