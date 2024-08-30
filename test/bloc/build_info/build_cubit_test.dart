import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.build} ${KGroupText.cubit}', () {
    late BuildCubit buildCubit;
    late BuildRepository mockBuildRepository;

    setUp(() {
      mockBuildRepository = MockBuildRepository();
      when(
        mockBuildRepository.getBuildInfo(),
      ).thenAnswer(
        (_) async => BuildRepository.defaultValue,
      );
      buildCubit = BuildCubit(
        buildRepository: mockBuildRepository,
      );
    });
    blocTest<BuildCubit, PackageInfo>(
      'emits [PackageInfo()] when initial',
      build: () => buildCubit,
      act: (bloc) async => bloc.started(),
      expect: () async => [BuildRepository.defaultValue],
    );
  });
}
