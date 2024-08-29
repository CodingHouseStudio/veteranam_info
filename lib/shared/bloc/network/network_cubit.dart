import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton()
class NetworkCubit extends Cubit<NetworkStatus> {
  NetworkCubit({
    required NetworkRepository networkRepository,
  })  : _nerworkRepository = networkRepository,
        super(
          networkRepository.currentNetwork,
        );

  final NetworkRepository _nerworkRepository;
  late StreamSubscription<NetworkStatus> networkStatusSubscription;

  @override
  Future<void> close() {
    networkStatusSubscription.cancel();
    _nerworkRepository.dispose();
    return super.close();
  }

  @visibleForTesting
  void networkStatusChanged(
    NetworkStatus status,
  ) {
    log('NetworkStatusChanged: $status');
    switch (status) {
      case NetworkStatus.network:
        return emit(
          NetworkStatus.network,
        );
      case NetworkStatus.offline:
        return emit(
          NetworkStatus.offline,
        );
      case NetworkStatus.slow:
        return emit(
          NetworkStatus.slow,
        );
    }
  }

  void networkInitialized() {
    networkStatusSubscription = _nerworkRepository.status.listen(
      networkStatusChanged,
    );
  }

  // Future<void> addEvent(void Function() event) async {
  //   networkStatusSubscription
  //       .onData((data) => data == NetworkStatus.network ? event : null);
  // }
}
