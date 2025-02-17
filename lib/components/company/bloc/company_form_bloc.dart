import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/components/company/field_models/field_models.dart';
import 'package:veteranam/shared/shared_dart.dart';

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
    required IDiscountRepository discountRepository,
  })  : _companyRepository = companyRepository,
        _dataPickerRepository = dataPickerRepository,
        _discountRepository = discountRepository,
        super(
          const CompanyFormState(
            companyName: CompanyNameFieldModel.pure(),
            publicName: PublicNameFieldModel.pure(),
            code: CompanyCodeFieldModel.pure(),
            image: ImageFieldModel.pure(),
            link: LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.initial,
            deleteIsPossible: null,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_CompanyNameUpdated>(_onCompanyNameUpdated);
    on<_PublicNameUpdated>(_onPublicNameUpdated);
    on<_CodeUpdated>(_onCodeUpdated);
    on<_ImageUpdated>(_onImageUpdated);
    on<_LinkUpdated>(_onLinkUpdated);
    on<_DeleteCompany>(_onDeleteCompany);
    on<_Save>(_onSave);
    add(const CompanyFormEvent.started());
  }

  final ICompanyRepository _companyRepository;
  final IDataPickerRepository _dataPickerRepository;
  final IDiscountRepository _discountRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<CompanyFormState> emit,
  ) async {
    final company = _companyRepository.currentUserCompany;
    if (company.id.isNotEmpty) {
      emit(
        CompanyFormState(
          companyName: company.companyName == null
              ? const CompanyNameFieldModel.pure()
              : CompanyNameFieldModel.dirty(company.companyName!),
          publicName: company.publicName == null
              ? const PublicNameFieldModel.pure()
              : PublicNameFieldModel.dirty(company.publicName!),
          code: company.code == null
              ? const CompanyCodeFieldModel.pure()
              : CompanyCodeFieldModel.dirty(company.code!),
          image: const ImageFieldModel.pure(),
          link: company.link == null
              ? const LinkFieldModel.pure()
              : LinkFieldModel.dirty(company.link),
          failure: null,
          formState: CompanyFormEnum.initial,
          deleteIsPossible: null,
        ),
      );
      final companyHasDiscount = await _discountRepository
          .companyHasDiscount(_companyRepository.currentUserCompany.id);
      emit(
        state.copyWith(
          deleteIsPossible: !companyHasDiscount,
        ),
      );
    }
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

  Future<void> _onPublicNameUpdated(
    _PublicNameUpdated event,
    Emitter<CompanyFormState> emit,
  ) async {
    final publicNameFieldModel = PublicNameFieldModel.dirty(event.publicName);
    emit(
      state.copyWith(
        publicName: publicNameFieldModel,
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
    // Not need to check error. If we have error we don't show image for user
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
          failure: l,
        ),
      ),
      (r) => emit(
        state.copyWith(
          // formState: CompanyFormEnum.delete,
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
        state.publicName,
        // state.image,
      ],
    )) {
      emit(state.copyWith(formState: CompanyFormEnum.sendInProgress));

      final company = _companyRepository.currentUserCompany.copyWith(
        id: _companyRepository.currentUserCompany.id.isEmpty
            ? ExtendedDateTime.id
            : _companyRepository.currentUserCompany.id,
        companyName: state.companyName.value,
        code: state.code.value,
        link: state.link.value,
        publicName: state.publicName.value,
      );

      if (company != _companyRepository.currentUserCompany ||
          state.image.value != null) {
        final result = await _companyRepository.createUpdateCompany(
          company: company,
          imageItem: state.image.value,
        );

        result.fold(
          (l) => emit(
            state.copyWith(
              failure: l,
              formState: CompanyFormEnum.initial,
            ),
          ),
          (r) => emit(
            state.copyWith(
              failure: null,
              image: const ImageFieldModel.pure(),
              formState: CompanyFormEnum.success,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            failure: null,
            formState: CompanyFormEnum.succesesUnmodified,
          ),
        );
      }
    } else {
      emit(state.copyWith(formState: CompanyFormEnum.invalidData));
    }
  }
}
