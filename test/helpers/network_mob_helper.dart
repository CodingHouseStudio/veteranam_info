import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

Future<void> networkMobHelper({
  required WidgetTester tester,
  required Future<void> Function() pumpApp,
}) async {
  final NetworkRepository mcokNetworkdRepository = MockNetworkRepository();
  when(mcokNetworkdRepository.status).thenAnswer(
    (invocation) => Stream.value(NetworkStatus.offline),
  );
  final networkCubit = NetworkCubit(networkRepository: mcokNetworkdRepository);

  if (GetIt.I.isRegistered<NetworkCubit>()) {
    GetIt.I.unregister<NetworkCubit>();
  }
  GetIt.I.registerSingleton<NetworkCubit>(networkCubit);

  await pumpApp();

  expect(
    find.byKey(KWidgetkeys.widget.networkBanner.widget),
    findsOneWidget,
  );
  expect(
    find.byKey(KWidgetkeys.widget.networkBanner.iconNoInternet),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    scrollKey: KWidgetkeys.widget.nawbar.widget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.networkBanner.iconNoInternet),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp150,
  );

  expect(
    find.byKey(KWidgetkeys.widget.networkBanner.widget),
    findsOneWidget,
  );
  expect(
    find.byKey(KWidgetkeys.widget.networkBanner.iconNoInternet),
    findsOneWidget,
  );
}
