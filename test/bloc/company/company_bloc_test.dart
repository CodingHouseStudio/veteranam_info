import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.company} Watcher ${KGroupText.bloc} ', () {
    late ICompanyRepository mockCompanyRepository;
    late CompanyWatcherBloc companyWatcherBloc;
    setUp(() {
      mockCompanyRepository = MockICompanyRepository();
      when(mockCompanyRepository.currentUserCompany).thenAnswer(
        (realInvocation) => KTestText.pureCompanyModel,
      );
      when(mockCompanyRepository.company).thenAnswer(
        (realInvocation) => Stream.value(KTestText.fullCompanyModel),
      );
      companyWatcherBloc =
          CompanyWatcherBloc(companyRepository: mockCompanyRepository);
    });
    blocTest<CompanyWatcherBloc, CompanyWatcherState>(
      'emits [CompanyWatcherState] when loaded user and updated'
      ' ${KGroupText.successful}',
      build: () => companyWatcherBloc,
      act: (bloc) async {
        when(mockCompanyRepository.company).thenAnswer(
          (realInvocation) => Stream.value(KTestText.fullCompanyModel),
        );
        bloc.add(
          const CompanyWatcherEvent.started(),
        );
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<CompanyWatcherState>(
              (state) => state.company.isNotEmpty,
            ),
          ]),
          reason: 'Wait for loading data',
        );
        bloc.add(const CompanyWatcherEvent.updated(KTestText.pureCompanyModel));
      },
      expect: () async => [
        const CompanyWatcherState(
          company: KTestText.fullCompanyModel,
          failure: null,
        ),
        const CompanyWatcherState(
          company: KTestText.pureCompanyModel,
          failure: null,
        ),
      ],
    );
    blocTest<CompanyWatcherBloc, CompanyWatcherState>(
      'emits [CompanyWatcherState] when loaded user failure'
      ' ${KGroupText.successful}',
      build: () => companyWatcherBloc,
      act: (bloc) async {
        when(mockCompanyRepository.company).thenAnswer(
          (realInvocation) => Stream.error(KGroupText.failureGet),
        );
        bloc.add(
          const CompanyWatcherEvent.started(),
        );
      },
      expect: () async => [
        const CompanyWatcherState(
          company: KTestText.pureCompanyModel,
          failure: CompanyWatcherFailure.error,
        ),
      ],
    );
  });
}