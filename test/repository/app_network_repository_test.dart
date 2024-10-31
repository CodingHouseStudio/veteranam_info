import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group(
      '${KScreenBlocName.appRepository} ${KScreenBlocName.network}'
      ' ${KGroupText.repository} ${KGroupText.successful}', () {
    late AppNetworkRepository appNetworkRepository;
    late Connectivity mockConnectivity;
    late CacheClient mockCache;
    setUp(() {
      mockConnectivity = MockConnectivity();
      mockCache = MockCacheClient();

      when(
        mockCache.read<List<ConnectivityResult>>(
          key: AppNetworkRepository.connectivityCacheKey,
        ),
      ).thenAnswer(
        (_) => [ConnectivityResult.none],
      );

      appNetworkRepository = AppNetworkRepository(
        mockConnectivity,
        mockCache,
      );
    });

    test('Current Connectivity Results', () {
      expect(
        appNetworkRepository.currentConnectivityResults,
        [ConnectivityResult.none],
      );
    });
    group('${KGroupText.stream} ', () {
      group('${KGroupText.empty} ', () {
        setUp(() {
          when(
            mockConnectivity.onConnectivityChanged,
          ).thenAnswer(
            (_) => Stream.value([]),
          );
        });
        test('Connectivity Results', () async {
          await expectLater(
            appNetworkRepository.connectivityResults,
            emitsInOrder([
              [ConnectivityResult.none],
            ]),
          );
        });
      });
      group('${KGroupText.successful} ', () {
        setUp(() {
          when(
            mockConnectivity.onConnectivityChanged,
          ).thenAnswer(
            (_) => Stream.value([ConnectivityResult.wifi]),
          );
        });
        test('Connectivity Results', () async {
          await expectLater(
            appNetworkRepository.connectivityResults,
            emitsInOrder([
              [ConnectivityResult.wifi],
            ]),
          );
        });
      });
    });
  });
}
