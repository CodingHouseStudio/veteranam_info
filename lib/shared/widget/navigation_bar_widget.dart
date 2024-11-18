import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({
    required this.isDesk,
    required this.isTablet,
    super.key = const ValueKey('nav_bar'),
    this.childWidget,
    this.pageName,
    this.showMobBackButton,
    this.maxMinHeight,
  });

  final bool isDesk;
  final bool isTablet;
  final Widget? childWidget;
  final String? pageName;
  final bool? showMobBackButton;
  final double? maxMinHeight;
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: SliverHeaderWidget(
        childWidget: ({required overlapsContent, required shrinkOffset}) =>
            _NavbarWidget(
          isDesk: isDesk,
          // childWidget: childWidget,
          isTablet: isTablet,
          pageName: pageName,
          // showMobileNawbar: showMobileNawbar ?? false,
          showBackButton: showMobBackButton,
        ),
        rebuildValues: [isDesk, isTablet],
        maxMinHeight: maxMinHeight ?? KMinMaxSize.minmaxHeight94,
      ),
    );
  }
}

class _NavbarWidget extends StatefulWidget {
  const _NavbarWidget({
    required this.isDesk,
    required this.isTablet,
    // required this.showMobileNawbar,
    // this.childWidget,
    this.pageName,
    this.showBackButton,
  });
  final bool isDesk;
  // final Widget? childWidget;
  final bool isTablet;
  final String? pageName;
  // final bool showMobileNawbar;
  final bool? showBackButton;

  @override
  State<_NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<_NavbarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: KWidgetkeys.widget.nawbar.widget,
      decoration: KWidgetTheme.boxDecorationNawbar,
      margin: EdgeInsets.only(
        top: KPadding.kPaddingSize24,
        left: padding,
        right: padding,
      ),
      padding: widget.isTablet
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
          // || widget.showMobileNawbar
          ? Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => EasyDebounce.debounce(
                    KAppText.logo,
                    Duration.zero,
                    () {
                      if (Config.isWeb
                          // || !widget.showMobileNawbar
                          ) {
                        context.goNamed(
                          Config.isUser
                              ? KRoute.home.name
                              : KRoute.myDiscounts
                                  .name, //KRoute.businessDashboard.name,
                        );
                      }
                    },
                  ),
                  icon: KImage.logo(
                    key: KWidgetkeys.widget.nawbar.logo,
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
                //       widgetKey: KWidgetkeys.widget.nawbar.field,
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
                //       //         KWidgetkeys.widget.nawbar.iconMic,
                //       //       ),
                //       isDesk: widget.isDesk,
                //       contentPadding: widget.isDesk
                //           ? EdgeInsets.zero
                //           : const EdgeInsets.all(KPadding.kPaddingSize16),
                //     ),
                //   )
                // else
                if (widget.isTablet)
                  Expanded(
                    child: Wrap(
                      // mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (Config.isUser)
                          _button(
                            key: KWidgetkeys.widget.nawbar.discountsButton,
                            ruoteName: KRoute.discounts.name,
                            text: context.l10n.discounts,
                            icon: const IconWidget(
                              icon: KIcon.tag,
                              background: AppColors.materialThemeSourceSeed,
                              padding: KPadding.kPaddingSize8,
                            ),
                            // width: context.isEnglish
                            //     ? KSize.kPixel72
                            //     : KSize.kPixel56,
                          ),
                        if (Config.isBusiness &&
                            context.read<AuthenticationBloc>().state.status ==
                                AuthenticationStatus.authenticated)
                          _button(
                            key: KWidgetkeys.widget.nawbar.myDiscountsButton,
                            ruoteName: KRoute.myDiscounts.name,
                            text: context.l10n.myDiscounts,
                            icon: const IconWidget(
                              icon: KIcon.tag,
                              background: AppColors.materialThemeSourceSeed,
                              padding: KPadding.kPaddingSize8,
                            ),
                            // width: context.isEnglish
                            //     ? KSize.kPixel72
                            //     : KSize.kPixel56,
                          ),
                        if (Config.isUser ||
                            (Config.isBusiness &&
                                context
                                        .read<AuthenticationBloc>()
                                        .state
                                        .status ==
                                    AuthenticationStatus.authenticated)) ...[
                          if (widget.isDesk)
                            KSizedBox.kWidthSizedBox32
                          else
                            KSizedBox.kWidthSizedBox16,
                          const CircleAvatar(
                            radius: KPadding.kPaddingSize2,
                          ),
                          if (widget.isDesk)
                            KSizedBox.kWidthSizedBox32
                          else
                            KSizedBox.kWidthSizedBox16,
                          _button(
                            key: KWidgetkeys.widget.nawbar.investorsButton,
                            ruoteName: KRoute.support.name,
                            text: context.l10n.investors,
                            // width: context.isEnglish
                            //     ? KSize.kPixel60
                            //     : KSize.kPixel80,
                          ),
                        ],
                        if (widget.isDesk)
                          KSizedBox.kWidthSizedBox32
                        else
                          KSizedBox.kWidthSizedBox16,
                        if (Config.isUser ||
                            (Config.isBusiness &&
                                context
                                        .read<AuthenticationBloc>()
                                        .state
                                        .status ==
                                    AuthenticationStatus.authenticated))
                          const CircleAvatar(
                            radius: KPadding.kPaddingSize2,
                          ),
                        if (widget.isDesk)
                          KSizedBox.kWidthSizedBox32
                        else
                          KSizedBox.kWidthSizedBox16,
                        if (Config.isUser || Config.isBusiness)
                          _button(
                            key: KWidgetkeys.widget.nawbar.feedbackButton,
                            ruoteName: KRoute.feedback.name,
                            text: context.l10n.contacts,
                            // width: KSize.kPixel70,
                          ),
                      ],
                    ),
                  )
                else
                  // widget.pageName != null && !Config.isWeb
                  //     ? Expanded(
                  //         child: Text(
                  //           '${widget.pageName}',
                  //           key: widget.pageNameKey,
                  //           style: AppTextStyle.materialThemeTitleMedium,
                  //           textAlign: TextAlign.center,
                  //         ),
                  //       )
                  //     :
                  const Spacer(),
                // if (widget.isDesk && widget.hasMicrophone)
                //   Padding(
                //     padding: const EdgeInsets.only(right:
                // KPadding.kPaddingSize32),
                //     child: IconWidget(
                //       key: KWidgetkeys.widget.nawbar.iconMic,
                //       icon: KIcon.mic,
                //     ),
                //   ),
                if (!Config.isBusiness)
                  if (widget.isTablet)
                    LanguagesSwitcherWidget(
                      key: KWidgetkeys.widget.nawbar.language,
                    )
                  else
                    IconButtonWidget(
                      key: KWidgetkeys.widget.nawbar.menuButton,
                      icon: KIcon.menu.copyWith(
                        color: AppColors.materialThemeWhite,
                      ),
                      background: AppColors.materialThemeKeyColorsSecondary,
                      onPressed: () async =>
                          context.dialog.showMobileMenuDialog(),
                    ),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        if (context.read<AuthenticationBloc>().state.status !=
                                AuthenticationStatus.authenticated
                            //      &&
                            // (Config.isDevelopment || Config.isBusiness)
                            ) ...[
                          if (widget.isDesk) ...[
                            KSizedBox.kWidthSizedBox16,
                            DoubleButtonWidget(
                              widgetKey: KWidgetkeys.widget.nawbar.loginButton,
                              onPressed: () =>
                                  context.goNamed(KRoute.userRole.name),
                              text: context.l10n.login,
                              isDesk: true,
                              darkMode: true,
                            ),
                          ] else ...[
                            KSizedBox.kWidthSizedBox4,
                            IconButtonWidget(
                              key: KWidgetkeys.widget.nawbar.loginIcon,
                              onPressed: () =>
                                  context.goNamed(KRoute.userRole.name),
                              icon: KIcon.person.copyWith(
                                color: AppColors.materialThemeWhite,
                              ),
                              background:
                                  AppColors.materialThemeKeyColorsSecondary,
                            ),
                          ],
                        ]
                        // if (context.read<AuthenticationBloc>()
                        //.state.status ==
                        //         AuthenticationStatus.authenticated &&
                        //     (Config.isDevelopment || Config.isBusiness))
                        else ...[
                          KSizedBox.kWidthSizedBox8,
                          getImageWidget,
                        ],
                      ],
                    );
                  },
                ),
              ],
            )
          : widget.showBackButton ?? false
              ? Row(
                  children: [
                    TextButton(
                      key: KWidgetkeys.widget.nawbar.backButton,
                      style: KButtonStyles.withoutStyle.copyWith(
                        padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(
                            vertical: KPadding.kPaddingSize12,
                            horizontal: KPadding.kPaddingSize16,
                          ),
                        ),
                      ),
                      onPressed: () => context.pop(),
                      child: KIcon.arrowBack,
                    ),
                    Expanded(
                      child: pageName(
                        showBackButton: true, // widget.networkStatus,
                      ),
                    ),
                    KSizedBox.kWidthSizedBox56,
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: KPadding.kPaddingSize8,
                  ),
                  child: pageName(
                    showBackButton: false,
                  ),
                ),
    );
  }

  Widget get getImageWidget => Config.isBusiness
      ? BlocBuilder<CompanyWatcherBloc, CompanyWatcherState>(
          buildWhen: (previous, current) =>
              previous.company.image != current.company.image,
          builder: (context, state) {
            return UserPhotoWidget(
              key: KWidgetkeys.widget.nawbar.loginIcon,
              onPressed: () => context.goNamed(KRoute.company.name),
              imageUrl: state.company.imageUrl,
            );
          },
        )
      : BlocBuilder<UserWatcherBloc, UserWatcherState>(
          buildWhen: (previous, current) =>
              previous.user.photo != current.user.photo,
          builder: (context, state) {
            return UserPhotoWidget(
              key: KWidgetkeys.widget.nawbar.loginIcon,
              onPressed: () => context.goNamed(KRoute.profile.name),
              imageUrl: context.read<UserWatcherBloc>().state.user.photo,
            );
          },
        );

  Widget pageName({
    required bool showBackButton,
  }) {
    return Row(
      key: KWidgetkeys.widget.nawbar.pageName,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            '${widget.pageName}',
            style: AppTextStyle.materialThemeTitleMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  double get padding => widget.isDesk
      ? KPadding.kPaddingSize90
      : widget.isTablet
          ? KPadding.kPaddingSize32
          : KPadding.kPaddingSize16;
  Widget _button({
    required String ruoteName,
    required String text,
    // required double width,
    required Key key,
    Widget? icon,
  }) =>
      ButtonBottomLineWidget(
        widgetKey: key,
        text: text,
        onPressed: () => context.goNamed(ruoteName),
        // width: width,
        // isDesk: widget.isTablet,
        icon: icon,
      );
}
