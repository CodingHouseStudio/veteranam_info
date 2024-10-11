import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'company_form_bloc.freezed.dart';
part 'company_form_event.dart';
part 'company_form_state.dart';

@Injectable(
  env: [Config.business],
)
class CompanyFormBloc extends Bloc<CompanyFormEvent, CompanyFormState> {
  CompanyFormBloc({
    required ICompanyRepository companyRepository,
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _companyRepository = companyRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const CompanyFormState(
            companyName: CompanyNameFieldModel.pure(),
            code: CompanyCodeFieldModel.pure(),
            image: ImageFieldModel.pure(),
            link: LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.initial,
          ),
        ) {
    on<_CompanyNameUpdated>(_onCompanyNameUpdated);
    on<_CodeUpdated>(_onCodeUpdated);
    on<_ImageUpdated>(_onImageUpdated);
    on<_LinkUpdated>(_onLinkUpdated);
    on<_Save>(_onSave);
  }

  final IAppAuthenticationRepository _appAuthenticationRepository;
  final ICompanyRepository _companyRepository;
  //final imagePicker = imagePickerValue;
  @visibleForTesting
  static ImagePicker imagePickerValue = ImagePicker();

  Future<void> _onCompanyNameUpdated(
    _CompanyNameUpdated event,
    Emitter<CompanyFormState> emit,
  ) async {
    final companyNameFieldModel =
        CompanyNameFieldModel.dirty(event.companyName);
    emit(
      state.copyWith(
        companyName: companyNameFieldModel,
        formState: CompanyFormEnum.inProgress,
        failure: null,
      ),
    );
  }

  Future<void> _onCodeUpdated(
    _CodeUpdated event,
    Emitter<CompanyFormState> emit,
  ) async {
    final companyCodeFieldModel = CompanyCodeFieldModel.dirty(event.code);
    emit(
      state.copyWith(
        code: companyCodeFieldModel,
        formState: CompanyFormEnum.inProgress,
        failure: null,
      ),
    );
  }

  Future<void> _onImageUpdated(
    _ImageUpdated event,
    Emitter<CompanyFormState> emit,
  ) async {
    final imageFieldModel = ImageFieldModel.dirty(
      await imagePickerValue.pickImage(source: ImageSource.gallery),
    );
    if (imageFieldModel.value == null) return;

    emit(
      state.copyWith(
        image: imageFieldModel,
        formState: CompanyFormEnum.inProgress,
        failure: null,
      ),
    );
  }

  Future<void> _onLinkUpdated(
    _LinkUpdated event,
    Emitter<CompanyFormState> emit,
  ) async {
    emit(
      state.copyWith(
        link: LinkFieldModel.dirty(event.link),
        formState: CompanyFormEnum.inProgress,
        failure: null,
      ),
    );
  }

  Future<void> _onSave(
    _Save event,
    Emitter<CompanyFormState> emit,
  ) async {
    final companyName = state.companyName.isPure
        ? CompanyNameFieldModel.dirty(
            _companyRepository.currentUserCompany.companyName ?? '',
          )
        : state.companyName;
    final companyLink = state.link.isPure
        ? LinkFieldModel.dirty(
            _companyRepository.currentUserCompany.link ?? '',
          )
        : state.link;
    final companyCode = state.code.isPure
        ? CompanyCodeFieldModel.dirty(
            _companyRepository.currentUserCompany.code ?? '',
          )
        : state.code;
    if (Formz.validate(
      [
        companyName,
        companyCode,
        companyLink,
        state.image,
      ],
    )) {
      emit(state.copyWith(formState: CompanyFormEnum.sendInProgress));

      final result = await _companyRepository.updateCompany(
        _companyRepository.currentUserCompany.id.isEmpty
            ? CompanyModel(
                id: ExtendedDateTime.id,
                companyName: state.companyName.value,
                userEmails: [_appAuthenticationRepository.currentUser.email!],
                image: state.image.value != null
                    ? ImageModel(
                        downloadURL: state.image.value!.path,
                        name: state.image.value!.name,
                        ref: state.image.value!.path,
                      )
                    : _companyRepository.currentUserCompany.image,
                code: state.code.value,
                link: state.link.value,
              )
            : _companyRepository.currentUserCompany.copyWith(
                companyName: state.companyName.value,
                image: state.image.value != null
                    ? ImageModel(
                        downloadURL: state.image.value!.path,
                        name: state.image.value!.name,
                        ref: state.image.value!.path,
                      )
                    : _companyRepository.currentUserCompany.image,
                code: state.code.value,
                link: state.link.value,
              ),
      );

      result.fold(
        (l) => emit(
          state.copyWith(
            failure: l._toCompanyError(),
            formState: CompanyFormEnum.initial,
          ),
        ),
        (r) => emit(
          state.copyWith(
            failure: null,
            image: const ImageFieldModel.pure(),
            formState: r
                ? CompanyFormEnum.success
                : CompanyFormEnum.succesesUnmodified,
          ),
        ),
      );
    } else {
      emit(state.copyWith(formState: CompanyFormEnum.invalidData));
    }
  }
}
