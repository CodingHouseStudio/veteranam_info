import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/news_card/bloc/news_card_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
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
            KTestText.informationModelItems.first.id,
          ),
        ).thenAnswer(
          (_) async => Right(KTestText.informationModelItems.first),
        );
        bloc
          ..add(const NewsCardWatcherEvent.started(''))
          ..add(
            NewsCardWatcherEvent.started(
              KTestText.informationModelItems.first.id,
            ),
          );
      },
      expect: () async => [
        const NewsCardWatcherState(
          informationModel: null,
          loadingStatus: LoadingStatus.error,
          failure: NewsCardFailure.wrongID,
        ),
        const NewsCardWatcherState(
          informationModel: null,
          loadingStatus: LoadingStatus.loading,
          failure: null,
        ),
        NewsCardWatcherState(
          informationModel: KTestText.informationModelItems.first,
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
            KTestText.informationModelItems.first.id,
          ),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        bloc.add(
          NewsCardWatcherEvent.started(
            KTestText.informationModelItems.first.id,
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
          failure: NewsCardFailure.error,
        ),
      ],
    );
  });
}
