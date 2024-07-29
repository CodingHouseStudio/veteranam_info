import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I.get<DiscountWatcherBloc>()
            ..add(const DiscountWatcherEvent.started()),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<AuthenticationBloc>()
            ..add(
              AuthenticationInitialized(),
            ),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<UrlCubit>(),
        ),
      ],
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
          scrollBehavior: CustomScrollBehavior(),
          localizationsDelegates: locale,
          locale: _.userSetting.locale.value,
          supportedLocales: supportedLocales,
          routerConfig: router,
        );
      },
    );
  }
}
