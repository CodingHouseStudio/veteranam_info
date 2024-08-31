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

  group('${KScreenBlocName.network} ${KGroupText.bloc} ', () {
    late NetworkRepository mockNetworkRepository;
    late NetworkCubit networkCubit;
    setUp(() {
      mockNetworkRepository = MockNetworkRepository();
      when(mockNetworkRepository.currentNetwork).thenAnswer(
        (realInvocation) => NetworkStatus.offline,
      );
      networkCubit = NetworkCubit(
        networkRepository: mockNetworkRepository,
      )..networkInitialized();
    });
    blocTest<NetworkCubit, NetworkStatus>(
      'emits [NetworkStatus] when'
      ' NetworkStatusChanged',
      build: () => networkCubit,
      act: (bloc) => bloc
        ..networkStatusChanged(NetworkStatus.network)
        ..networkStatusChanged(NetworkStatus.offline),
      expect: () async => [
        NetworkStatus.network,
        NetworkStatus.offline,
      ],
    );
  });
}
