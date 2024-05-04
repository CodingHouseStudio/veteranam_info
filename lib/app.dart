import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/constants/theme/theme.dart';
import 'package:kozak/shared/shared.dart';

class App extends StatelessWidget {
  const App({super.key});

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

class AppWidget extends StatefulWidget {
  const AppWidget({
    super.key,
  });

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late final MaterialTheme themeDataNew;

  @override
  void initState() {
    super.initState();

    themeDataNew = const MaterialTheme(TextTheme());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, _) {
        return MaterialApp.router(
          key: KWidgetkeys.screen.app.screen,
          theme: themeDataNew.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: _.userSetting.locale.value,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        );
      },
    );
  }
}
