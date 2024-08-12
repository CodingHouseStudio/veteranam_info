import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.url} ', () {
    late UrlCubit discountLinkCubit;
    late IUrlRepository mockUrlRepository;

    setUp(() {
      mockUrlRepository = MockIUrlRepository();
      discountLinkCubit = UrlCubit(
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
        when(mockUrlRepository.copy(KTestText.downloadURL)).thenAnswer(
          (invocation) async => const Right(true),
        );
      });
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when load discountModel list',
        build: () => discountLinkCubit,
        act: (bloc) async => bloc.launchUrl(url: KTestText.downloadURL),
        expect: () async => [
          null,
        ],
      );
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when load discountModel list',
        build: () => discountLinkCubit,
        act: (bloc) async => bloc.share(KTestText.downloadURL),
        expect: () async => [
          null,
        ],
      );
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when copy email',
        build: () => discountLinkCubit,
        act: (bloc) async => bloc.copy(KTestText.downloadURL),
        expect: () async => [
          UrlEnum.copySucceed,
        ],
      );
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when email was copied',
        build: () => discountLinkCubit,
        act: (bloc) async => bloc.reset(),
        expect: () async => [
          null,
        ],
      );
    });

    group('${KGroupText.failure} ', () {
      setUp(() {
        when(mockUrlRepository.launchUrl(url: KTestText.downloadURL))
            .thenAnswer(
          (invocation) async => const Left(SomeFailure.link()),
        );
        when(mockUrlRepository.share(KTestText.downloadURL)).thenAnswer(
          (invocation) async => const Left(SomeFailure.share()),
        );
        when(mockUrlRepository.copy(KTestText.downloadURL)).thenAnswer(
          (invocation) async => const Left(SomeFailure.copy()),
        );
      });
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when load discountModel list',
        build: () => discountLinkCubit,
        act: (bloc) async => bloc.launchUrl(url: KTestText.downloadURL),
        expect: () async => [
          UrlEnum.linkError,
        ],
      );
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when load discountModel list',
        build: () => discountLinkCubit,
        act: (bloc) async => bloc.share(KTestText.downloadURL),
        expect: () async => [
          UrlEnum.shareError,
        ],
      );
      blocTest<UrlCubit, UrlEnum?>(
        'emits [discountWatcherState()]'
        ' when copy email',
        build: () => discountLinkCubit,
        act: (bloc) async => bloc.copy(KTestText.downloadURL),
        expect: () async => [
          UrlEnum.copyError,
        ],
      );
    });
  });
}
