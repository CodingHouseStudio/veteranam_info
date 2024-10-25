import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

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
      ExtendedDateTime.id = KTestText.id;
      mockCompanyRepository = MockICompanyRepository();
      mockDiscountRepository = MockIDiscountRepository();
      mockDataPickerRepository = MockIDataPickerRepository();

      when(
        mockDataPickerRepository.getImage,
      ).thenAnswer(
        (realInvocation) async => KTestText.filePickerItem,
      );

      when(
        mockCompanyRepository.updateCompany(
          company: KTestText.fullCompanyModel,
          imageItem: KTestText.filePickerItem,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );

      when(
        mockCompanyRepository.updateCompany(
          company: KTestText.fullCompanyModel.copyWith(link: null),
          imageItem: null,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
    });

    group('Start company full', () {
      setUp(() async {
        when(mockCompanyRepository.currentUserCompany).thenAnswer(
          (realInvocation) => KTestText.fullCompanyModel,
        );

        when(
          mockDiscountRepository
              .companyHasDiscount(KTestText.fullCompanyModel.id),
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
            const CompanyFormEvent.companyNameUpdated(KTestText.companyName),
          )
          ..add(
            const CompanyFormEvent.publicNameUpdated(KTestText.companyName),
          )
          ..add(const CompanyFormEvent.codeUpdated(KTestText.companyCode))
          ..add(const CompanyFormEvent.linkUpdated(KTestText.link))
          ..add(const CompanyFormEvent.save()),
        expect: () => [
          const CompanyFormState(
            companyName: CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestText.companyCode),
            deleteIsPossible: false,
            link: LinkFieldModel.dirty(KTestText.link),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          const CompanyFormState(
            companyName: CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestText.companyCode),
            deleteIsPossible: false,
            link: LinkFieldModel.dirty(KTestText.link),
            failure: null,
            formState: CompanyFormEnum.sendInProgress,
          ),
          const CompanyFormState(
            companyName: CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestText.companyCode),
            deleteIsPossible: false,
            link: LinkFieldModel.dirty(KTestText.link),
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
            companyName: CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestText.companyCode),
            deleteIsPossible: false,
            link: LinkFieldModel.dirty(KTestText.link),
            failure: CompanyFormFailure.error,
            formState: CompanyFormEnum.initial,
          ),
        ],
      );
    });

    group('Start company pure', () {
      setUp(() {
        when(mockCompanyRepository.currentUserCompany).thenAnswer(
          (realInvocation) => KTestText.pureCompanyModel.copyWith(id: ''),
        );

        when(
          mockDiscountRepository
              .companyHasDiscount(KTestText.pureCompanyModel.id),
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
              const CompanyFormEvent.companyNameUpdated(KTestText.companyName),
            )
            ..add(
              const CompanyFormEvent.publicNameUpdated(KTestText.companyName),
            )
            ..add(const CompanyFormEvent.codeUpdated(KTestText.companyCode))
            ..add(const CompanyFormEvent.linkUpdated(KTestText.link))
            ..add(const CompanyFormEvent.save());
        },
        expect: () => [
          CompanyFormState(
            companyName: const CompanyNameFieldModel.pure(),
            publicName: const PublicNameFieldModel.pure(),
            image: ImageFieldModel.dirty(KTestText.filePickerItem),
            code: const CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: const PublicNameFieldModel.pure(),
            image: ImageFieldModel.dirty(KTestText.filePickerItem),
            code: const CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: const PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.dirty(KTestText.filePickerItem),
            code: const CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: const PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.dirty(KTestText.filePickerItem),
            code: const CompanyCodeFieldModel.dirty(KTestText.companyCode),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: const PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.dirty(KTestText.filePickerItem),
            code: const CompanyCodeFieldModel.dirty(KTestText.companyCode),
            deleteIsPossible: null,
            link: const LinkFieldModel.dirty(KTestText.link),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: const PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.dirty(KTestText.filePickerItem),
            code: const CompanyCodeFieldModel.dirty(KTestText.companyCode),
            deleteIsPossible: null,
            link: const LinkFieldModel.dirty(KTestText.link),
            failure: null,
            formState: CompanyFormEnum.sendInProgress,
          ),
          const CompanyFormState(
            companyName: CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestText.companyCode),
            deleteIsPossible: null,
            link: LinkFieldModel.dirty(KTestText.link),
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
            const CompanyFormEvent.companyNameUpdated(KTestText.companyName),
          )
          ..add(
            const CompanyFormEvent.publicNameUpdated(KTestText.companyName),
          )
          ..add(const CompanyFormEvent.codeUpdated(KTestText.companyCode))
          ..add(const CompanyFormEvent.save()),
        expect: () => [
          const CompanyFormState(
            companyName: CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: PublicNameFieldModel.pure(),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          const CompanyFormState(
            companyName: CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          const CompanyFormState(
            companyName: CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestText.companyCode),
            deleteIsPossible: null,
            link: LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          const CompanyFormState(
            companyName: CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestText.companyCode),
            deleteIsPossible: null,
            link: LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.sendInProgress,
          ),
          const CompanyFormState(
            companyName: CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.pure(),
            code: CompanyCodeFieldModel.dirty(KTestText.companyCode),
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
              company: KTestText.fullCompanyModel,
              imageItem: KTestText.filePickerItem,
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
              const CompanyFormEvent.companyNameUpdated(KTestText.companyName),
            )
            ..add(
              const CompanyFormEvent.publicNameUpdated(KTestText.companyName),
            )
            ..add(const CompanyFormEvent.codeUpdated(KTestText.companyCode))
            ..add(const CompanyFormEvent.linkUpdated(KTestText.link))
            ..add(const CompanyFormEvent.save());
        },
        expect: () => [
          CompanyFormState(
            companyName: const CompanyNameFieldModel.pure(),
            publicName: const PublicNameFieldModel.pure(),
            image: ImageFieldModel.dirty(KTestText.filePickerItem),
            code: const CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: const PublicNameFieldModel.pure(),
            image: ImageFieldModel.dirty(KTestText.filePickerItem),
            code: const CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: const PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.dirty(KTestText.filePickerItem),
            code: const CompanyCodeFieldModel.pure(),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: const PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.dirty(KTestText.filePickerItem),
            code: const CompanyCodeFieldModel.dirty(KTestText.companyCode),
            deleteIsPossible: null,
            link: const LinkFieldModel.pure(),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: const PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.dirty(KTestText.filePickerItem),
            code: const CompanyCodeFieldModel.dirty(KTestText.companyCode),
            deleteIsPossible: null,
            link: const LinkFieldModel.dirty(KTestText.link),
            failure: null,
            formState: CompanyFormEnum.inProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: const PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.dirty(KTestText.filePickerItem),
            code: const CompanyCodeFieldModel.dirty(KTestText.companyCode),
            deleteIsPossible: null,
            link: const LinkFieldModel.dirty(KTestText.link),
            failure: null,
            formState: CompanyFormEnum.sendInProgress,
          ),
          CompanyFormState(
            companyName:
                const CompanyNameFieldModel.dirty(KTestText.companyName),
            publicName: const PublicNameFieldModel.dirty(KTestText.companyName),
            image: ImageFieldModel.dirty(KTestText.filePickerItem),
            code: const CompanyCodeFieldModel.dirty(KTestText.companyCode),
            deleteIsPossible: null,
            link: const LinkFieldModel.dirty(KTestText.link),
            failure: CompanyFormFailure.error,
            formState: CompanyFormEnum.initial,
          ),
        ],
      );
    });
  });
}
