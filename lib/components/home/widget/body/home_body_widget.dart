import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/components/home/home.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final aboutProjectKey = GlobalKey();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
        final isTablet =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        final padding = EdgeInsets.symmetric(
          horizontal: (isDesk
              ? KPadding.kPaddingSize90 +
                  ((constraints.maxWidth >
                          KPlatformConstants.maxWidthThresholdTablet)
                      ? (constraints.maxWidth -
                              KPlatformConstants.maxWidthThresholdTablet) /
                          2
                      : 0)
              : KPadding.kPaddingSize16),
        );
        final body = [
          NawbarWidget(isDesk: isDesk, isTablet: isTablet),
          KSizedBox.kHeightSizedBox24,
          Padding(
            padding: padding,
            child: BoxWidgetList(
              isDesk: isDesk,
              isTablet: isTablet,
              aboutProjectKey: aboutProjectKey,
            ),
          ),
          SizedBox(
            key: aboutProjectKey,
            height: KSize.kPixel48,
          ),
          Padding(
            padding: padding,
            child: Text(
              context.l10n.aboutProject,
              key: KWidgetkeys.screen.home.aboutProjecSubtitle,
              style: isDesk
                  ? AppTextStyle.materialThemeDisplayMedium
                  : isTablet
                      ? AppTextStyle.materialThemeDisplaySmall
                      : AppTextStyle.materialThemeHeadlineSmall,
            ),
          ),
          if (isTablet)
            KSizedBox.kHeightSizedBox160
          else
            KSizedBox.kHeightSizedBox48,
          DiscountSection(
            isDesk: isDesk,
            isTablet: isTablet,
            padding: padding,
          ),
          if (Config.isDevelopment) ...[
            if (isTablet)
              KSizedBox.kHeightSizedBox160
            else
              KSizedBox.kHeightSizedBox40,
            InformationSection(
              isDesk: isDesk,
              isTablet: isTablet,
              padding: padding,
            ),
          ],
          if (isDesk || isTablet)
            KSizedBox.kHeightSizedBox160
          else
            KSizedBox.kHeightSizedBox40,
          Padding(
            padding: padding,
            child: FAQSectionWidget(
              isDesk: isDesk,
              isTablet: isTablet,
            ),
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox160
          else if (isTablet)
            KSizedBox.kHeightSizedBox64
          else
            KSizedBox.kHeightSizedBox48,
          Padding(
            padding: padding,
            child: DecoratedBox(
              decoration: KWidgetTheme.boxDecorationFooter,
              child: Padding(
                padding: isDesk
                    ? const EdgeInsets.all(
                        KPadding.kPaddingSize32,
                      ).copyWith(left: KPadding.kPaddingSize46)
                    : isTablet
                        ? const EdgeInsets.all(
                            KPadding.kPaddingSize46,
                          )
                        : const EdgeInsets.symmetric(
                            vertical: KPadding.kPaddingSize32,
                            horizontal: KPadding.kPaddingSize16,
                          ),
                child: FooterWidget(
                  isTablet: isTablet,
                  isDesk: isDesk,
                ),
              ),
            ),
          ),
        ];
        return BlocListener<HomeWatcherBloc, HomeWatcherState>(
          listener: (context, state) => context.dialog.showGetErrorDialog(
            error: state.failure?.value(context),
            onPressed: () => context
                .read<HomeWatcherBloc>()
                .add(const HomeWatcherEvent.started()),
          ),
          child: ListView.builder(
            key: KWidgetkeys.widget.scaffold.scroll,
            primary: false,
            itemCount: body.length,
            itemBuilder: (context, index) => body.elementAt(index),
          ),
        );
      },
    );
  }
}
