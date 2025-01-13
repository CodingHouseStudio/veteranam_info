import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/repositories/screen_size_repository.dart';
import 'package:veteranam/shared/shared_dart.dart';

@injectable
class AppLayoutCubit extends Cubit<AppVersionEnum> {
  AppLayoutCubit({
    required ScreenSizeRepository screenSizeRepository,
  })  : _screenSizeRepository = screenSizeRepository,
        super(screenSizeRepository.getCurrentScreenSize.appVersionEnum) {
    _init();
  }
  final ScreenSizeRepository _screenSizeRepository;
  StreamSubscription<Size>? _subscription;

  void _init() {
    _subscription = _screenSizeRepository.sizeStream.listen(
      _changeAppVersion,
      onError: (Object error, StackTrace stack) =>
          _error(error: error, stack: stack),
    );
  }

  void _changeAppVersion(Size size) {
    emit(size.appVersionEnum);
  }

  void _error({
    required Object error,
    required StackTrace stack,
  }) {
    SomeFailure.value(
      error: error,
      stack: stack,
      tag: 'App Layout Cubit(Screen Size)',
      tagKey: ErrorText.streamBlocKey,
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _screenSizeRepository.dispose();
    return super.close();
  }
}

extension _SizeExtension on Size {
  AppVersionEnum get appVersionEnum {
    if (width > KPlatformConstants.minWidthThresholdDesk) {
      return AppVersionEnum.desk;
    } else if (width > KPlatformConstants.minWidthThresholdTablet) {
      return AppVersionEnum.tablet;
    } else {
      return AppVersionEnum.mobile;
    }
  }
}
