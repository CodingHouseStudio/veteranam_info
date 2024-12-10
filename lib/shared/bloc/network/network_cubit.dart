import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@injectable
class NetworkCubit extends Cubit<NetworkStatus> {
  NetworkCubit({
    required NetworkRepository networkRepository,
  })  : _nerworkRepository = networkRepository,
        super(
          networkRepository.currentNetwork,
        ) {
    _networkInitialized();
  }

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
    }
  }

  void _networkInitialized() {
    networkStatusSubscription = _nerworkRepository.status.listen(
      networkStatusChanged,
    );
  }

  // Future<void> addEvent(void Function() event) async {
  //   networkStatusSubscription
  //       .onData((data) => data == NetworkStatus.network ? event : null);
  // }
}
