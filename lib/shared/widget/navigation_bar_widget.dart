import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({
    // required this.isDesk,
    // required this.isTablet,
    super.key = const ValueKey('nav_bar'),
    this.childWidget,
    this.pageName,
    this.showMobBackButton,
    this.maxMinHeight,
    this.backButtonPathName,
  });

  // final bool isDesk;
  // final bool isTablet;
  final Widget? childWidget;
  final String? pageName;
  final bool? showMobBackButton;
  final double? maxMinHeight;
  final String? backButtonPathName;
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: SliverHeaderWidget(
        childWidget: ({required overlapsContent, required shrinkOffset}) =>
            _NavbarWidget(
          // isDesk: isDesk,
          // childWidget: childWidget,
          // isTablet: isTablet,
          pageName: pageName,
          // showMobileNawbar: showMobileNawbar ?? false,
          showBackButton: showMobBackButton,
          backButtonPathName: backButtonPathName,
        ),
        // rebuildValues: [isDesk, isTablet],
        maxMinHeight: maxMinHeight ?? KMinMaxSize.minmaxHeight94,
      ),
    );
  }
}

class _NavbarWidget extends StatelessWidget {
  const _NavbarWidget({
    // required this.isDesk,
    // required this.isTablet,
    // required this.showMobileNawbar,
    // this.childWidget,
    this.pageName,
    this.showBackButton,
    this.backButtonPathName,
  });
  // final bool isDesk;
  // final Widget? childWidget;
  // final bool isTablet;
  final String? pageName;
  // final bool showMobileNawbar;
  final bool? showBackButton;
  final String? backButtonPathName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLayoutBloc, AppLayoutState>(
      builder: (context, state) => Container(
        key: NawbarKeys.widget,
        decoration: KWidgetTheme.boxDecorationNawbar,
        margin: EdgeInsets.only(
          top: KPadding.kPaddingSize24,
          left: state.appVersionEnum.horizontalPadding,
          right: state.appVersionEnum.horizontalPadding,
        ),
        padding: state.appVersionEnum.isTablet
            ? const EdgeInsets.only(
                left: KPadding.kPaddingSize32,
                right: KPadding.kPaddingSize16,
                top: KPadding.kPaddingSize12,
                bottom: KPadding.kPaddingSize12,
              )
            : const EdgeInsets.only(
                left: KPadding.kPaddingSize16,
                right: KPadding.kPaddingSize8,
                top: KPadding.kPaddingSize8,
                bottom: KPadding.kPaddingSize8,
              ),
        child: Config.isWeb
            ? Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => EasyDebounce.debounce(
                      KAppText.logo,
                      Duration.zero,
                      () {
                        // if (Config.isWeb
                        //     // || !widget.showMobileNawbar
                        //     ) {
                        context.goNamed(
                          Config.isWeb
                              ? Config.isUser
                                  ? KRoute.home.name
                                  : KRoute.myDiscounts.name
                              : KRoute.discounts
                                  .name, //KRoute.businessDashboard.name,
                        );
                        // }
                      },
                    ),
                    icon: KIcon.logo.copyWith(
                      key: NawbarKeys.logo,
                      // width: 78,
                    ),
                  ),
                  // if (Config.isDevelopment)
                  //   if (widget.isDesk)
                  //     KSizedBox.kWidthSizedBox40
                  //   else
                  //     KSizedBox.kWidthSizedBox22,
                  // if (Config.isDevelopment)
                  //   Expanded(
                  //     child: TextFieldWidget(
                  //       key: _formKey,
                  //       widgetKey: NawbarKeys.field,
                  //       labelTextStyle: widget.isDesk
                  //           ? AppTextStyle.text24
                  //           : AppTextStyle.text16,
                  //       focusNode: focusNode,
                  //       prefixIcon: KIcon.search,
                  //       onChanged: (text) {},
                  //       labelText: context.l10n.search,
                  //       // suffixIcon: widget.isDesk || !widget.hasMicrophone
                  //       //     ? null
                  //       //     : KIcon.mic.setIconKey(
                  //       //         NawbarKeys.iconMic,
                  //       //       ),
                  //       isDesk: widget.isDesk,
                  //       contentPadding: widget.isDesk
                  //           ? EdgeInsets.zero
                  //           :
                  // const EdgeInsets.all(KPadding.kPaddingSize16),
                  //     ),
                  //   )
                  // else
                  _NavigationCenterWebWidget(
                    appVersionEnum: state.appVersionEnum,
                  ),
                  // if (widget.isDesk && widget.hasMicrophone)
                  //   Padding(
                  //     padding: const EdgeInsets.only(right:
                  // KPadding.kPaddingSize32),
                  //     child: IconWidget(
                  //       key: NawbarKeys.iconMic,
                  //       icon: KIcon.mic,
                  //     ),
                  //   ),
                  if (!Config.isBusiness)
                    if (state.appVersionEnum.isTablet)
                      const LanguagesSwitcherWidget(
                        key: NawbarKeys.language,
                      )
                    else
                      IconButtonWidget(
                        key: NawbarKeys.menuButton,
                        icon: KIcon.menuWhite,
                        background: AppColors.materialThemeKeyColorsSecondary,
                        onPressed: () async =>
                            context.dialog.showMobileMenuDialog(),
                      ),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, _) {
                      return Row(
                        children: _.status != AuthenticationStatus.authenticated
                            //      &&
                            // (Config.isDevelopment || Config.isBusiness)
                            ? state.appVersionEnum.isDesk
                                ? [
                                    KSizedBox.kWidthSizedBox16,
                                    DoubleButtonWidget(
                                      widgetKey: NawbarKeys.loginButton,
                                      onPressed: () =>
                                          context.goNamed(loginPath),
                                      text: context.l10n.login,
                                      isDesk: true,
                                      darkMode: true,
                                    ),
                                  ]
                                : [
                                    KSizedBox.kWidthSizedBox4,
                                    IconButtonWidget(
                                      key: NawbarKeys.loginIcon,
                                      onPressed: () =>
                                          context.goNamed(loginPath),
                                      icon: KIcon.personWhite,
                                      background: AppColors
                                          // ignore: lines_longer_than_80_chars
                                          .materialThemeKeyColorsSecondary,
                                    ),
                                  ]
                            : [
                                KSizedBox.kWidthSizedBox8,
                                getImageWidget,
                              ],
                      );
                    },
                  ),
                ],
              )
            : showBackButton ?? false
                ? Row(
                    children: [
                      IconButton(
                        key: NawbarKeys.backButton,
                        style: KButtonStyles.withoutStyleNavBar,
                        onPressed: () => context.goNamed(
                          backButtonPathName ?? KRoute.discounts.name,
                        ),
                        icon: KIcon.arrowBack,
                      ),
                      Expanded(
                        child: Text(
                          '$pageName',
                          key: NawbarKeys.pageName,
                          style: AppTextStyle.materialThemeTitleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      KSizedBox.kWidthSizedBox56,
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: KPadding.kPaddingSize8,
                    ),
                    child: Text(
                      '$pageName',
                      key: NawbarKeys.pageName,
                      style: AppTextStyle.materialThemeTitleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
      ),
    );
  }

  String get loginPath =>
      Config.isBusiness ? KRoute.login.name : KRoute.userRole.name;

  Widget get getImageWidget => Config.isBusiness
      ? BlocSelector<CompanyWatcherBloc, CompanyWatcherState, String?>(
          // buildWhen: (previous, current) =>
          //     previous.company.image != current.company.image,
          selector: (state) => state.company.imageUrl,
          builder: (context, imageUrl) {
            return UserPhotoWidget(
              key: NawbarKeys.loginIcon,
              onPressed: () => context.goNamed(KRoute.company.name),
              imageUrl: imageUrl,
            );
          },
        )
      : BlocSelector<UserWatcherBloc, UserWatcherState, String?>(
          // buildWhen: (previous, current) =>
          //     previous.user.photo != current.user.photo,
          selector: (state) => state.user.photo,
          builder: (context, photo) {
            return UserPhotoWidget(
              key: NawbarKeys.loginIcon,
              onPressed: () => context.goNamed(KRoute.profile.name),
              imageUrl: photo,
            );
          },
        );
}

class _NavigationCenterWebWidget extends StatelessWidget {
  const _NavigationCenterWebWidget({
    required this.appVersionEnum,
  });
  final AppVersionEnum appVersionEnum;

  @override
  Widget build(BuildContext context) {
    if (appVersionEnum.isTablet) {
      return Expanded(
        child: BlocSelector<UserWatcherBloc, UserWatcherState, Language>(
          selector: (state) => state.userSetting.locale,
          builder: (context, language) {
            return Wrap(
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              alignment: WrapAlignment.center,
              runSpacing: KPadding.kPaddingSize8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (Config.isUser)
                  _button(
                    key: NawbarKeys.discountsButton,
                    ruoteName: KRoute.discounts.name,
                    text: context.l10n.discounts,
                    icon: const IconWidget(
                      icon: KIcon.tag,
                      background: AppColors.materialThemeSourceSeed,
                      padding: KPadding.kPaddingSize8,
                    ),
                    locale: language,
                    context: context,
                    // width: context.isEnglish
                    //     ? KSize.kPixel72
                    //     : KSize.kPixel56,
                  ),
                if (Config.isBusiness &&
                    context.read<AuthenticationBloc>().state.status ==
                        AuthenticationStatus.authenticated)
                  _button(
                    key: NawbarKeys.myDiscountsButton,
                    ruoteName: KRoute.myDiscounts.name,
                    text: context.l10n.myDiscounts,
                    icon: const IconWidget(
                      icon: KIcon.tag,
                      background: AppColors.materialThemeSourceSeed,
                      padding: KPadding.kPaddingSize8,
                    ),
                    locale: language,
                    context: context,
                    // width: context.isEnglish
                    //     ? KSize.kPixel72
                    //     : KSize.kPixel56,
                  ),
                if (Config.isUser ||
                    (Config.isBusiness &&
                        context.read<AuthenticationBloc>().state.status ==
                            AuthenticationStatus.authenticated)) ...[
                  if (appVersionEnum.isDesk)
                    KSizedBox.kWidthSizedBox32
                  else
                    KSizedBox.kWidthSizedBox16,
                  const CircleAvatar(
                    radius: KPadding.kPaddingSize2,
                  ),
                  if (appVersionEnum.isDesk)
                    KSizedBox.kWidthSizedBox32
                  else
                    KSizedBox.kWidthSizedBox16,
                  _button(
                    key: NawbarKeys.investorsButton,
                    ruoteName: KRoute.support.name,
                    text: context.l10n.investors,
                    context: context,
                    locale: language,
                    // width: context.isEnglish
                    //     ? KSize.kPixel60
                    //     : KSize.kPixel80,
                  ),
                ],
                if (appVersionEnum.isDesk)
                  KSizedBox.kWidthSizedBox32
                else
                  KSizedBox.kWidthSizedBox16,
                if (Config.isUser ||
                    (Config.isBusiness &&
                        context.read<AuthenticationBloc>().state.status ==
                            AuthenticationStatus.authenticated))
                  const CircleAvatar(
                    radius: KPadding.kPaddingSize2,
                  ),
                if (appVersionEnum.isDesk)
                  KSizedBox.kWidthSizedBox32
                else
                  KSizedBox.kWidthSizedBox16,
                if (Config.isUser || Config.isBusiness)
                  _button(
                    key: NawbarKeys.feedbackButton,
                    ruoteName: KRoute.feedback.name,
                    text: context.l10n.contacts,
                    context: context,
                    locale: language,
                    // width: KSize.kPixel70,
                  ),
              ],
            );
          },
        ),
      );
    } else {
      return const Spacer();
    }
  }

  Widget _button({
    required String ruoteName,
    required String text,
    // required double width,
    required Key key,
    required BuildContext context,
    required Language locale,
    Widget? icon,
  }) =>
      ButtonBottomLineWidget(
        widgetKey: key,
        text: text, locale: locale,
        onPressed: () => context.goNamed(ruoteName),
        // width: width,
        // isDesk: widget.isTablet,
        icon: icon,
      );
}
