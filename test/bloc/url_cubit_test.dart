import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.url} ', () {
    late UrlCubit urlCubit;
    late IUrlRepository mockUrlRepository;

    setUp(() {
      mockUrlRepository = MockIUrlRepository();
      urlCubit = UrlCubit(
        urlRepository: mockUrlRepository,
      );
    });

    group('${KGroupText.successful} ', () {
      setUp(() {
        when(mockUrlRepository.launchUrl(url: KTestText.downloadURL))
            .thenAnswer(
          (invocation) async => const Right(true),
        );
        when(mockUrlRepository.share(KTestText.downloadURL)).thenAnswer(
          (invocation) async => const Right(true),
        );
        when(mockUrlRepository.copy(KAppText.email)).thenAnswer(
          (invocation) async => const Right(true),
        );
      });
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when load discountModel list',
        build: () => urlCubit,
        act: (bloc) async => bloc.launchUrl(url: KTestText.downloadURL),
        expect: () async => [
          null,
        ],
      );
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when load discountModel list',
        build: () => urlCubit,
        act: (bloc) async => bloc.share(KTestText.downloadURL),
        expect: () async => [
          null,
        ],
      );
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when copy email',
        build: () => urlCubit,
        act: (bloc) async => bloc.copy(text: KAppText.email),
        expect: () async => [
          UrlEnum.copyPhoneNumberSucceed,
        ],
      );
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when email was copied',
        build: () => urlCubit,
        act: (bloc) async => bloc.reset(),
        expect: () async => [
          null,
        ],
      );
    });

    group('${KGroupText.successful} FALSE', () {
      setUp(() {
        when(mockUrlRepository.share(KTestText.downloadURL)).thenAnswer(
          (invocation) async => const Right(false),
        );
        when(mockUrlRepository.copy(KAppText.email)).thenAnswer(
          (invocation) async => const Right(false),
        );
      });
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when load discountModel list',
        build: () => urlCubit,
        act: (bloc) async => bloc.share(KTestText.downloadURL),
        expect: () async => [
          UrlEnum.copyLinkSucceed,
        ],
      );
    });

    group('${KGroupText.failure} ', () {
      setUp(() {
        when(mockUrlRepository.launchUrl(url: KTestText.downloadURL))
            .thenAnswer(
          (invocation) async => Left(SomeFailure.link(error: null)),
        );
        when(mockUrlRepository.share(KTestText.downloadURL)).thenAnswer(
          (invocation) async => Left(SomeFailure.share(error: null)),
        );
        when(mockUrlRepository.copy(KAppText.email)).thenAnswer(
          (invocation) async => Left(SomeFailure.copy(error: null)),
        );
      });
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when load discountModel list',
        build: () => urlCubit,
        act: (bloc) async => bloc.launchUrl(url: KTestText.downloadURL),
        expect: () async => [
          UrlEnum.linkError,
        ],
      );
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when load discountModel list',
        build: () => urlCubit,
        act: (bloc) async => bloc.share(KTestText.downloadURL),
        expect: () async => [
          null,
          // UrlEnum.copyEmailSucceed,
        ],
      );
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when copy email',
        build: () => urlCubit,
        act: (bloc) async => bloc.copy(text: KAppText.email),
        expect: () async => [
          UrlEnum.copyError,
        ],
      );
    });
  });
}
