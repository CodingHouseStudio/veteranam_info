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
            create: (context) => GetIt.I.get<MobOfflineModeCubit>(),
          ),
          BlocProvider(
            create: (context) => GetIt.I.get<MobFaqWatcherBloc>()
              ..add(
                const MobFaqWatcherEvent.started(),
              ),
          ),
        ],
      ],
      child: const AppWidget(),
    );
  }
}

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  AppWidgetState createState() => AppWidgetState();
}

class AppWidgetState extends State<AppWidget> {
  bool offline = false;
  bool slow = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkStatus>(
      listener: (context, status) {
        setState(() {
          if (status == NetworkStatus.offline) {
            offline = true;
            slow = false;
          } else if (status == NetworkStatus.slow) {
            slow = true;
            offline = false;
          } else if (status == NetworkStatus.network) {
            offline = false;
            slow = false;
          }
        });
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.unknown) {
            return const SizedBox.shrink();
          }
          final localeValue = state.userSetting.locale.value;
          return kIsWeb
              ? body(localeValue)
              : BetterFeedback(
                  localizationsDelegates: locale,
                  localeOverride: localeValue,
                  mode: FeedbackMode.navigate,
                  feedbackBuilder: (context, onSubmit, scrollController) =>
                      MobFeedbackWidget(onSubmit: onSubmit),
                  child: BlocBuilder<MobOfflineModeCubit, MobMode>(
                    builder: (context, _) {
                      return body(localeValue);
                    },
                  ),
                );
        },
      ),
    );
  }

  Widget body(Locale localeValue) {
    return MaterialApp.router(
      key: KWidgetkeys.screen.app.screen,
      theme: themeData,
      scrollBehavior: CustomScrollBehavior(),
      localizationsDelegates: locale,
      locale: localeValue,
      supportedLocales: supportedLocales,
      routerConfig: router,
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            if (offline && !kIsWeb)
              SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.materialThemeSysLightError,
                      borderRadius: KBorderRadius.kBorderRadius32,
                    ),
                    padding: const EdgeInsets.all(KPadding.kPaddingSize12),
                    child: Text(
                      context.l10n.noInternet,
                      style: AppTextStyle.materialThemeTitleSmallNeutral,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            else if (slow && !kIsWeb)
              SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: KBorderRadius.kBorderRadius32,
                    ),
                    padding: const EdgeInsets.all(KPadding.kPaddingSize12),
                    child: Text(
                      context.l10n.slowInternet,
                      style: AppTextStyle.materialThemeTitleSmallNeutral,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
