import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

part 'story_add_event.dart';
part 'story_add_state.dart';
part 'story_add_bloc.freezed.dart';

@Injectable()
class StoryAddBloc extends Bloc<StoryAddEvent, StoryAddState> {
  StoryAddBloc({
    required IStoryRepository storyRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _storyRepository = storyRepository,
        _authenticationRepository = authenticationRepository,
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
  final AuthenticationRepository _authenticationRepository;

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
    final imageFieldModel = ImageFieldModel.dirty(
      await ImagePicker().pickImage(source: ImageSource.gallery),
    );
    if (imageFieldModel.value == null) return;

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
        _authenticationRepository.currentUser.name == null) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.failure));
      return;
    }
    if (_authenticationRepository.currentUser.isNotEmpty) {
      final result = await _storyRepository.addStory(
        StoryModel(
          id: ExtendedDateTime.id,
          date: ExtendedDateTime.current,
          story: state.story.value,
          userName: state.isAnonymously
              ? null
              : _authenticationRepository.currentUser.name,
          image: state.image.value != null
              ? [
                  ImageModel(
                    downloadURL: '',
                    name: state.image.value!.name,
                    ref: state.image.value!.path,
                  ),
                ]
              : null,
          userPhoto: _authenticationRepository.currentUser.photo != null &&
                  !state.isAnonymously
              ? [
                  ImageModel(
                    downloadURL: _authenticationRepository.currentUser.photo!,
                  ),
                ]
              : null,
          userId: _authenticationRepository.currentUser.id,
        ),
      );
      result.fold(
        (l) => emit(state.copyWith(failure: l.toStoryAdd())),
        (r) => emit(
          state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            failure: null,
          ),
        ),
      );
    }
  }
}
