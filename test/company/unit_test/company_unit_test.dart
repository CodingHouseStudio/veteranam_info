import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/company/bloc/company_form_bloc.dart';
import 'package:veteranam/components/company/field_models/field_models.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.company} ${KGroupText.bloc}', () {
    late CompanyFormBloc companyFormBloc;
    late IDataPickerRepository mockDataPickerRepository;
    late ICompanyRepository mockCompanyRepository;
    late IDiscountRepository mockDiscountRepository;
    setUp(() async {
      ExtendedDateTime.id = KTestVariables.id;
      mockCompanyRepository = MockICompanyRepository();
      mockDiscountRepository = MockIDiscountRepository();
      mockDataPickerRepository = MockIDataPickerRepository();

      when(
        mockDataPickerRepository.getImage,
      ).thenAnswer(
        (realInvocation) async => KTestVariables.filePickerItem,
      );

      when(
        mockCompanyRepository.updateCompany(
          company: KTestVariables.fullCompanyModel,
          imageItem: KTestVariables.filePickerItem,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );

      when(
        mockCompanyRepository.updateCompany(
          company: KTestVariables.fullCompanyModel.copyWith(link: null),
          imageItem: null,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
    });

    group('Start company full', () {
      setUp(() async {
        when(mockCompanyRepository.currentUserCompany).thenAnswer(
          (realInvocation) => KTestVariables.fullCompanyModel,
        );

        when(
          mockDiscountRepository
              .companyHasDiscount(KTestVariables.fullCompanyModel.id),
        ).thenAnswer(
          (realInvocation) async => true,
        );

        companyFormBloc = CompanyFormBloc(
          companyRepository: mockCompanyRepository,
          discountRepository: mockDiscountRepository,
          dataPickerRepository: mockDataPickerRepository,
        )..add(const CompanyFormEvent.started());
        await expectLater(
          companyFormBloc.stream,
          emitsInOrder([
            predicate<CompanyFormState>(
              (state) => state.formState == CompanyFormEnum.initial,
            ),
            predicate<CompanyFormState>(
              (state) => state.deleteIsPossible != null,
            ),
          ]),
          reason: 'Wait for loading data',
        );
      });
      blocTest<CompanyFormBloc, CompanyFormState>(
        'emits [CompanyFormState] with add all valid data and saved unmodified',
        build: () => companyFormBloc,
        act: (bloc) async => bloc
          ..add(
            const CompanyFormEvent.companyNameUpdated(
              KTestVariables.companyName,
            ),
          )
          ..add(
            const CompanyFormEvent.publicNameUpdated(
              KTestVariables.companyName,
            ),
          )
          ..add(const CompanyFormEvent.codeUpdated(KTestVariables.companyCode))
          ..add(const CompanyFormEvent.linkUpdated(KTestVariables.link))
          ..add(const CompanyFormEvent.save()),
        expect: () => [
          const CompanyFormState(
            companyName:
                CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName: PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: false,
            link: LinkFieldModel.dirty(KTestVariables.link),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          const CompanyFormState(
            companyName:
                CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName: PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: false,
            link: LinkFieldModel.dirty(KTestVariables.link),
            failure: null,
            formState: CompanyFormEnum.sendInProgress,
          ),
          const CompanyFormState(
            companyName:
                CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName: PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: false,
            link: LinkFieldModel.dirty(KTestVariables.link),
            failure: null,
            formState: CompanyFormEnum.succesesUnmodified,
          ),
        ],
      );
      blocTest<CompanyFormBloc, CompanyFormState>(
        'emits [CompanyFormState] delete company',
        build: () => companyFormBloc,
        act: (bloc) async {
          when(mockCompanyRepository.deleteCompany()).thenAnswer(
            (realInvocation) async => const Right(true),
          );
          bloc.add(
            const CompanyFormEvent.deleteCompany(),
          );
        },
        expect: () => <CompanyFormState>[],
      );
      blocTest<CompanyFormBloc, CompanyFormState>(
        'emits [CompanyFormState] delete company error',
        build: () => companyFormBloc,
        act: (bloc) async {
          when(mockCompanyRepository.deleteCompany()).thenAnswer(
            (realInvocation) async =>
                Left(SomeFailure.serverError(error: null)),
          );
          bloc.add(
            const CompanyFormEvent.deleteCompany(),
          );
        },
        expect: () => <CompanyFormState>[
          const CompanyFormState(
            companyName:
                CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName: PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: false,
            link: LinkFieldModel.dirty(KTestVariables.link),
            failure: CompanyFormFailure.error,
            formState: CompanyFormEnum.initial,
          ),
        ],
      );
    });

    group('Start company pure', () {
      setUp(() {
        when(mockCompanyRepository.currentUserCompany).thenAnswer(
          (realInvocation) => KTestVariables.pureCompanyModel.copyWith(id: ''),
        );

        when(
          mockDiscountRepository
              .companyHasDiscount(KTestVariables.pureCompanyModel.id),
        ).thenAnswer(
          (realInvocation) async => false,
        );

        companyFormBloc = CompanyFormBloc(
          companyRepository: mockCompanyRepository,
          discountRepository: mockDiscountRepository,
          dataPickerRepository: mockDataPickerRepository,
        )..add(const CompanyFormEvent.started());
        // await expectLater(
        //   companyFormBloc.stream,
        //   emitsInOrder([
        //     predicate<CompanyFormState>(
        //       (state) => state.formState == CompanyFormEnum.initial,
        //     ),
        //     predicate<CompanyFormState>(
        //       (state) => state.deleteIsPossible != null,
        //     ),
        //   ]),
        //   reason: 'Wait for loading data',
        // );
      });

      blocTest<CompanyFormBloc, CompanyFormState>(
        'emits [CompanyFormState] with add all valid data and saved it',
        build: () => companyFormBloc,
        act: (bloc) async {
          bloc.add(const CompanyFormEvent.imageUpdated());
          await expectLater(
            companyFormBloc.stream,
            emitsInOrder([
              predicate<CompanyFormState>(
                (state) => state.image.isValid,
              ),
            ]),
            reason: 'Wait for loading image',
          );
          bloc
            ..add(
              const CompanyFormEvent.companyNameUpdated(
                KTestVariables.companyName,
              ),
            )
            ..add(
              const CompanyFormEvent.publicNameUpdated(
                KTestVariables.companyName,
              ),
            )
            ..add(
              const CompanyFormEvent.codeUpdated(KTestVariables.companyCode),
            )
            ..add(const CompanyFormEvent.linkUpdated(KTestVariables.link))
            ..add(const CompanyFormEvent.save());
        },
        expect: () => [
          CompanyFormState(
            companyName: const CompanyNameFieldModel.pure(),
            publicName: const PublicNameFieldModel.pure(),
            image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
            code: const CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName: const PublicNameFieldModel.pure(),
            image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
            code: const CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName:
                const PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
            code: const CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName:
                const PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
            code: const CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName:
                const PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
            code: const CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: null,
            link: const LinkFieldModel.dirty(KTestVariables.link),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName:
                const PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
            code: const CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: null,
            link: const LinkFieldModel.dirty(KTestVariables.link),
            failure: null,
            formState: CompanyFormEnum.sendInProgress,
          ),
          const CompanyFormState(
            companyName:
                CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName: PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: null,
            link: LinkFieldModel.dirty(KTestVariables.link),
            failure: null,
            formState: CompanyFormEnum.success,
          ),
        ],
      );

      blocTest<CompanyFormBloc, CompanyFormState>(
        'emits [CompanyFormState] with add all valid(without photo and link)'
        ' data and saved it',
        build: () => companyFormBloc,
        act: (bloc) async => bloc
          ..add(
            const CompanyFormEvent.companyNameUpdated(
              KTestVariables.companyName,
            ),
          )
          ..add(
            const CompanyFormEvent.publicNameUpdated(
              KTestVariables.companyName,
            ),
          )
          ..add(const CompanyFormEvent.codeUpdated(KTestVariables.companyCode))
          ..add(const CompanyFormEvent.save()),
        expect: () => [
          const CompanyFormState(
            companyName:
                CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName: PublicNameFieldModel.pure(),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          const CompanyFormState(
            companyName:
                CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName: PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          const CompanyFormState(
            companyName:
                CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName: PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: null,
            link: LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          const CompanyFormState(
            companyName:
                CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName: PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: null,
            link: LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.sendInProgress,
          ),
          const CompanyFormState(
            companyName:
                CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName: PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: null,
            link: LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.success,
          ),
        ],
      );

      blocTest<CompanyFormBloc, CompanyFormState>(
        'emits [CompanyFormState] with add all invalid'
        ' data and saved it',
        build: () => companyFormBloc,
        act: (bloc) async => bloc..add(const CompanyFormEvent.save()),
        expect: () => [
          const CompanyFormState(
            companyName: CompanyNameFieldModel.pure(),
            publicName: PublicNameFieldModel.pure(),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.invalidData,
          ),
        ],
      );

      blocTest<CompanyFormBloc, CompanyFormState>(
        'emits [CompanyFormState] with add all valid data and saved error',
        build: () => companyFormBloc,
        act: (bloc) async {
          when(
            mockCompanyRepository.updateCompany(
              company: KTestVariables.fullCompanyModel,
              imageItem: KTestVariables.filePickerItem,
            ),
          ).thenAnswer(
            (realInvocation) async => Left(SomeFailure(error: null)),
          );
          bloc.add(const CompanyFormEvent.imageUpdated());
          await expectLater(
            companyFormBloc.stream,
            emitsInOrder([
              predicate<CompanyFormState>(
                (state) => state.image.isValid,
              ),
            ]),
            reason: 'Wait for loading image',
          );
          bloc
            ..add(
              const CompanyFormEvent.companyNameUpdated(
                KTestVariables.companyName,
              ),
            )
            ..add(
              const CompanyFormEvent.publicNameUpdated(
                KTestVariables.companyName,
              ),
            )
            ..add(
              const CompanyFormEvent.codeUpdated(KTestVariables.companyCode),
            )
            ..add(const CompanyFormEvent.linkUpdated(KTestVariables.link))
            ..add(const CompanyFormEvent.save());
        },
        expect: () => [
          CompanyFormState(
            companyName: const CompanyNameFieldModel.pure(),
            publicName: const PublicNameFieldModel.pure(),
            image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
            code: const CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName: const PublicNameFieldModel.pure(),
            image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
            code: const CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName:
                const PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
            code: const CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName:
                const PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
            code: const CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName:
                const PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
            code: const CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: null,
            link: const LinkFieldModel.dirty(KTestVariables.link),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName:
                const PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
            code: const CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: null,
            link: const LinkFieldModel.dirty(KTestVariables.link),
            failure: null,
            formState: CompanyFormEnum.sendInProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestVariables.companyName),
            publicName:
                const PublicNameFieldModel.dirty(KTestVariables.companyName),
            image: ImageFieldModel.dirty(KTestVariables.filePickerItem),
            code: const CompanyCodeFieldModel.dirty(KTestVariables.companyCode),
            deleteIsPossible: null,
            link: const LinkFieldModel.dirty(KTestVariables.link),
            failure: CompanyFormFailure.error,
            formState: CompanyFormEnum.initial,
          ),
        ],
      );
    });
  });
}
