import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/components/company/company.dart';
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
    required IDataPickerRepository dataPickerRepository,
  })  : _companyRepository = companyRepository,
        _dataPickerRepository = dataPickerRepository,
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
    on<_Started>(_onStarted);
    on<_CompanyNameUpdated>(_onCompanyNameUpdated);
    on<_CodeUpdated>(_onCodeUpdated);
    on<_ImageUpdated>(_onImageUpdated);
    on<_LinkUpdated>(_onLinkUpdated);
    on<_DeleteCompany>(_onDeleteCompany);
    on<_Save>(_onSave);
  }

  final ICompanyRepository _companyRepository;
  final IDataPickerRepository _dataPickerRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<CompanyFormState> emit,
  ) async {
    final company = _companyRepository.currentUserCompany;
    emit(
      CompanyFormState(
        companyName: CompanyNameFieldModel.dirty(company.companyName ?? ''),
        code: CompanyCodeFieldModel.dirty(company.code ?? ''),
        image: const ImageFieldModel.pure(),
        link: LinkFieldModel.dirty(company.link ?? ''),
        failure: null,
        formState: CompanyFormEnum.initial,
      ),
    );
  }

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
    final image = await _dataPickerRepository.getImage;
    if (image == null || image.bytes.isEmpty) return;
    final imageFieldModel = ImageFieldModel.dirty(image);

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

  Future<void> _onDeleteCompany(
    _DeleteCompany event,
    Emitter<CompanyFormState> emit,
  ) async {
    final result = await _companyRepository.deleteCompany();
    result.fold(
      (l) => emit(
        state.copyWith(
          failure: l._toCompanyError(),
        ),
      ),
      (r) => emit(
        state.copyWith(
          formState: CompanyFormEnum.delete,
          failure: null,
        ),
      ),
    );
  }

  Future<void> _onSave(
    _Save event,
    Emitter<CompanyFormState> emit,
  ) async {
    if (Formz.validate(
      [
        state.companyName,
        state.code,
        state.link,
        // state.image,
      ],
    )) {
      emit(state.copyWith(formState: CompanyFormEnum.sendInProgress));

      final result = await _companyRepository.updateCompany(
        company: _companyRepository.currentUserCompany.copyWith(
          id: _companyRepository.currentUserCompany.id.isEmpty
              ? ExtendedDateTime.id
              : _companyRepository.currentUserCompany.id,
          companyName: state.companyName.value,
          code: state.code.value,
          link: state.link.value,
        ),
        imageItem: state.image.value,
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
