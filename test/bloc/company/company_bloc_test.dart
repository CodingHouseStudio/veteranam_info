import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

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
        (realInvocation) => KTestVariables.pureCompanyModel,
      );
      when(mockCompanyRepository.company).thenAnswer(
        (realInvocation) => Stream.value(KTestVariables.fullCompanyModel),
      );
      // companyWatcherBloc =
      //     CompanyWatcherBloc(companyRepository: mockCompanyRepository);
    });
    group(
      'emits [CompanyWatcherState] when loaded user and updated'
      ' ${KGroupText.successful}',
      () {
        setUp(
          () {
            when(mockCompanyRepository.company).thenAnswer(
              (realInvocation) => Stream.value(KTestVariables.fullCompanyModel),
            );
            companyWatcherBloc =
                CompanyWatcherBloc(companyRepository: mockCompanyRepository);
          },
        );
        blocTest<CompanyWatcherBloc, CompanyWatcherState>(
          'emits [CompanyWatcherState] when loaded user and updated'
          ' ${KGroupText.successful}',
          build: () => companyWatcherBloc,
          act: (bloc) async {
            // bloc.add(
            //   const CompanyWatcherEvent.started(),
            // );
            await expectLater(
              bloc.stream,
              emitsInOrder([
                predicate<CompanyWatcherState>(
                  (state) => state.company.isNotEmpty,
                ),
              ]),
              reason: 'Wait for loading data',
            );
            bloc.add(
              const CompanyWatcherEvent.updated(
                KTestVariables.pureCompanyModel,
              ),
            );
          },
          expect: () async => [
            const CompanyWatcherState(
              company: KTestVariables.fullCompanyModel,
              failure: null,
            ),
            const CompanyWatcherState(
              company: KTestVariables.pureCompanyModel,
              failure: null,
            ),
          ],
        );
      },
    );
    group(
        'emits [CompanyWatcherState] when loaded user failure'
        ' ${KGroupText.successful}', () {
      setUp(
        () {
          when(mockCompanyRepository.company).thenAnswer(
            (realInvocation) => Stream.error(KGroupText.failureGet),
          );
          companyWatcherBloc =
              CompanyWatcherBloc(companyRepository: mockCompanyRepository);
        },
      );
      blocTest<CompanyWatcherBloc, CompanyWatcherState>(
        'Bloc Test',
        build: () => companyWatcherBloc,
        act: (bloc) async {
          // bloc.add(
          //   const CompanyWatcherEvent.started(),
          // );
        },
        expect: () async => [
          const CompanyWatcherState(
            company: KTestVariables.pureCompanyModel,
            failure: SomeFailure.serverError,
          ),
        ],
      );
    });
  });
}
