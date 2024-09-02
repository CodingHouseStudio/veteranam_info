import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
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
          create: (context) => GetIt.I.get<InvestorsWatcherBloc>()
            ..add(const InvestorsWatcherEvent.started()),
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
        BlocProvider(
          create: (context) =>
              GetIt.I.get<NetworkCubit>()..networkInitialized(),
        ),
        if (!kIsWeb) ...[
          BlocProvider(
            create: (context) => GetIt.I.get<MobFeedbackBloc>(),
          ),
          BlocProvider(
            create: (context) => GetIt.I.get<MobOfflineModeCubit>()..started(),
          ),
          BlocProvider(
            create: (context) => GetIt.I.get<MobFaqWatcherBloc>()
              ..add(
                const MobFaqWatcherEvent.started(),
              ),
          ),
          BlocProvider(
            create: (context) => GetIt.I.get<AppVersionCubit>()..started(),
          ),
        ],
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
        final localeValue = _.userSetting.locale.value;
        return kIsWeb
            ? body(localeValue)
            : BetterFeedback(
                localizationsDelegates: locale,
                localeOverride: localeValue,
                themeMode: ThemeMode.light,
                mode: FeedbackMode.navigate,
                feedbackBuilder: (context, onSubmit, scrollController) =>
                    MobFeedbackWidget(
                  onSubmit: onSubmit,
                  // scrollController: scrollController,
                ),
                child: BlocBuilder<MobOfflineModeCubit, MobMode>(
                  builder: (context, state) {
                    return body(localeValue);
                  },
                ),
              );
      },
    );
  }

  Widget body(Locale localeValue) => MaterialApp.router(
        key: KWidgetkeys.screen.app.screen,
        theme: themeData,
        // scrollBehavior: CustomScrollBehavior(),
        localizationsDelegates: locale,
        locale: localeValue,
        supportedLocales: supportedLocales,
        routerConfig: router,
      );
}
