import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<AuthenticationBloc>()
        ..add(
          AuthenticationInitialized(),
        ),
      child: const AppWidget(),
    );
  }
}

class AppWidget extends StatelessWidget {
  const AppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, _) {
        if (_.status == AuthenticationStatus.unknown) {
          return const SizedBox.shrink();
        }
        return MaterialApp.router(
          key: KWidgetkeys.screen.app.screen,
          theme: themeData,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            // GlobalCupertinoLocalizations.delegate,
            // GlobalMaterialLocalizations.delegate,
            // GlobalWidgetsLocalizations.delegate,
          ],
          locale: _.userSetting.locale.value,
          supportedLocales: AppLocalizations.delegate.supportedLocales,
          routerConfig: router,
        );
      },
    );
  }
}
