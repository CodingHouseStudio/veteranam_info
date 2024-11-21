import 'dart:async';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:veteranam/components/discounts/bloc/watcher/discount_watcher_bloc.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/components/mob_faq/bloc/mob_faq_watcher_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
          create: (context) => GetIt.I.get<UserWatcherBloc>()
            ..add(
              const UserWatcherEvent.started(),
            ),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<LanguageCubit>()..started(),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<UrlCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              GetIt.I.get<NetworkCubit>()..networkInitialized(),
        ),
        if (!Config.isWeb) ...[
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
        if (Config.isBusiness)
          BlocProvider(
            create: (context) => GetIt.I.get<CompanyWatcherBloc>()
              ..add(const CompanyWatcherEvent.started()),
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
    return BlocConsumer<LanguageCubit, Language>(
      listener: (context, language) => unawaited(
        initializeDateFormatting(language.value.languageCode),
      ),
      builder: (context, language) {
        return Config.isWeb
            ? body(language.value)
            : BetterFeedback(
                localizationsDelegates: locale,
                localeOverride: language.value,
                themeMode: ThemeMode.light,
                mode: FeedbackMode.navigate,
                feedbackBuilder: (context, onSubmit, scrollController) =>
                    MobFeedbackWidget(onSubmit: onSubmit),
                child: BlocBuilder<MobOfflineModeCubit, MobMode>(
                  builder: (context, _) {
                    return body(language.value);
                  },
                ),
              );
      },
    );
  }

  Widget body(Locale localeValue) => MaterialApp.router(
        key: KWidgetkeys.screen.app.screen,
        theme: themeData,
        restorationScopeId: KAppText.logo,
        // scrollBehavior: CustomScrollBehavior(),
        localizationsDelegates: locale,
        locale: localeValue,
        supportedLocales: supportedLocales,
        routerConfig: Config.isUser ? router : businessRouter,
      );
}
