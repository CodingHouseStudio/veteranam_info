import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/helper/get_it_service_locator.config.dart';

final getIt = GetIt.instance;

/// COMMENT: Method registers all classes that use Injectable
@InjectableInit()
void configureDependencies() => getIt.init(
      // environment: Config.flavour,
      environmentFilter: const NoEnvOrContainsAny(
        {Config.flavour, Config.role, Config.platform},
      ),
    );
