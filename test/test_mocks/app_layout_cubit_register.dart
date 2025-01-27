import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/bloc/app_layout/app_layout_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

late StreamController<AppVersionEnum> appVersionController;

void appLayoutCubitInit() {
  final IAppLayoutRepository mockAppLayoutRepository =
      MockIAppLayoutRepository();
  appVersionController = StreamController<AppVersionEnum>.broadcast()
    ..add(AppVersionEnum.mobile);
  when(mockAppLayoutRepository.appVersionStream).thenAnswer(
    (realInvocation) => appVersionController.stream,
  );
  when(mockAppLayoutRepository.getCurrentAppVersion).thenAnswer(
    (realInvocation) => AppVersionEnum.mobile,
  );
  if (GetIt.I.isRegistered<IAppLayoutRepository>()) {
    GetIt.I.unregister<IAppLayoutRepository>();
  }
  GetIt.I.registerSingleton<IAppLayoutRepository>(mockAppLayoutRepository);

  if (GetIt.I.isRegistered<AppLayoutBloc>()) {
    GetIt.I.unregister<AppLayoutBloc>();
  }
  GetIt.I.registerFactory<AppLayoutBloc>(
    () => AppLayoutBloc(appLayoutRepository: mockAppLayoutRepository),
  );
}
