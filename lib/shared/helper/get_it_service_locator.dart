import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

final getIt = GetIt.instance;

/// COMMENT: Method registers all classes that use Injectable
@InjectableInit()
Future<void> configureDependencies() async => getIt.init(
      // environment: Config.flavour,
      environmentFilter: NoEnvOrContains(Config.flavour),
    );
