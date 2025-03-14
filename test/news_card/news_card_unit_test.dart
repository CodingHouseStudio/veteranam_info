import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/news_card/bloc/news_card_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.newsCard} ${KGroupText.bloc}', () {
    late NewsCardWatcherBloc newsCardWatcherBloc;
    late IInformationRepository mockInformationRepository;

    setUp(() {
      mockInformationRepository = MockIInformationRepository();
      newsCardWatcherBloc = NewsCardWatcherBloc(
        informationRepository: mockInformationRepository,
      );
    });

    blocTest<NewsCardWatcherBloc, NewsCardWatcherState>(
      'emits [NewsCardWatcherState()]'
      ' when load InformationModel wuth wrong id and correct',
      build: () => newsCardWatcherBloc,
      act: (bloc) async {
        when(
          mockInformationRepository.getInformation(
            KTestVariables.informationModelItems.first.id,
          ),
        ).thenAnswer(
          (_) async => Right(KTestVariables.informationModelItems.first),
        );
        bloc
          ..add(const NewsCardWatcherEvent.started(''))
          ..add(
            NewsCardWatcherEvent.started(
              KTestVariables.informationModelItems.first.id,
            ),
          );
      },
      expect: () async => [
        const NewsCardWatcherState(
          informationModel: null,
          loadingStatus: LoadingStatus.error,
          failure: SomeFailure.wrongID,
        ),
        const NewsCardWatcherState(
          informationModel: null,
          loadingStatus: LoadingStatus.loading,
          failure: null,
        ),
        NewsCardWatcherState(
          informationModel: KTestVariables.informationModelItems.first,
          loadingStatus: LoadingStatus.loaded,
          failure: null,
        ),
      ],
    );

    blocTest<NewsCardWatcherBloc, NewsCardWatcherState>(
      'emits [NewsCardWatcherState()]'
      ' when load InformationModel ${KGroupText.failure}',
      build: () => newsCardWatcherBloc,
      act: (bloc) async {
        when(
          mockInformationRepository.getInformation(
            KTestVariables.informationModelItems.first.id,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        bloc.add(
          NewsCardWatcherEvent.started(
            KTestVariables.informationModelItems.first.id,
          ),
        );
      },
      expect: () async => [
        const NewsCardWatcherState(
          informationModel: null,
          loadingStatus: LoadingStatus.loading,
          failure: null,
        ),
        const NewsCardWatcherState(
          informationModel: null,
          loadingStatus: LoadingStatus.error,
          failure: SomeFailure.serverError,
        ),
      ],
    );
  });
}
