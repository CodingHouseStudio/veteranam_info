// ignore_for_file: unused_import

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.network} ${KGroupText.repository}', () {
    late NetworkRepository networkRepository;
    late IAppNetworkRepository mockAppnetworkRepository;
    late StreamController<List<ConnectivityResult>>
        connectivityResultsStreamController;

    setUp(() {
      connectivityResultsStreamController =
          StreamController<List<ConnectivityResult>>();
      mockAppnetworkRepository = MockIAppNetworkRepository();

      when(mockAppnetworkRepository.connectivityResults).thenAnswer(
        (_) => connectivityResultsStreamController.stream,
      );

      when(mockAppnetworkRepository.currentConnectivityResults).thenAnswer(
        (_) => [ConnectivityResult.none],
      );

      networkRepository =
          NetworkRepository(appNetworkRepository: mockAppnetworkRepository);
    });

    group('${KGroupText.stream} ', () {
      setUp(() {
        connectivityResultsStreamController.add([ConnectivityResult.none]);
      });
      group('Network', () {
        setUp(() async {
          connectivityResultsStreamController.add([ConnectivityResult.wifi]);
        });

        test('Connectivity Results', () async {
          await expectLater(
            networkRepository.status,
            emitsInOrder([
              NetworkStatus.offline,
              NetworkStatus.network,
            ]),
            // reason: 'Wait for getting status',
          );
        });
      });
      group('Ofline', () {
        setUp(() async {
          connectivityResultsStreamController.add([ConnectivityResult.none]);
        });

        test('Connectivity Results', () async {
          await expectLater(
            networkRepository.status,
            emitsInOrder([
              NetworkStatus.offline,
              NetworkStatus.offline,
            ]),
            // reason: 'Wait for getting status',
          );
        });
      });

      tearDown(() async => connectivityResultsStreamController.close());
    });

    test('Current Network', () {
      final networkStatus = networkRepository.currentNetwork;

      expect(networkStatus, NetworkStatus.offline);
    });
  });
}
