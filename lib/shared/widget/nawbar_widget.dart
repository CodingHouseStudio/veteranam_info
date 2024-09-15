import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

// class NawbarWidget extends SliverPersistentHeaderDelegate {
//   const NawbarWidget({
//     required this.isDesk,
//     required this.isTablet,
//     this.widgetKey,
//     this.childWidget,
//     this.maxMinHeight,
//     this.pageName,
//     // this.showMobileNawbar,
//     this.showMobBackButton,
//   });
//   final bool isDesk;
//   final bool isTablet;
//   final Key? widgetKey;
//   final Widget? childWidget;
//   final double? maxMinHeight;
//   final String? pageName;
//   // final bool? showMobileNawbar;
//   final bool? showMobBackButton;

//   @override
//   double get maxExtent => maxMinHeight ?? KMinMaxSize.minmaxHeight94;

//   @override
//   double get minExtent => maxMinHeight ?? KMinMaxSize.minmaxHeight94;

//   //Rebuild screen only when isDesk value change
//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
//       oldDelegate is NawbarWidget &&
//       (isDesk != oldDelegate.isDesk || isTablet != oldDelegate.isTablet);

//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     return
//     _NawbarWidgetImplematation(
//       key: widgetKey,
//       isDesk: isDesk,
//       childWidget: childWidget,
//       isTablet: isTablet,
//       pageName: pageName,
//       // showMobileNawbar: showMobileNawbar ?? false,
//       showBackButton: showMobBackButton,
//     );
//   }
// }

class NawbarWidget extends StatefulWidget {
  const NawbarWidget({
    required this.isDesk,
    required this.isTablet,
    // required this.showMobileNawbar,
    super.key,
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
  State<NawbarWidget> createState() => _NawbarWidgetState();

  static SliverPersistentHeaderDelegate getSliverHeader({
    required bool isDesk,
    required bool isTablet,
    Widget? childWidget,
    String? pageName,
    bool? showMobBackButton,
    double? maxMinHeight,
  }) =>
      SliverHeaderWidget(
        childWidget: ({required overlapsContent, required shrinkOffset}) =>
            NawbarWidget(
          isDesk: isDesk,
          // childWidget: childWidget,
          isTablet: isTablet,
          pageName: pageName,
          // showMobileNawbar: showMobileNawbar ?? false,
          showBackButton: showMobBackButton,
        ),
        rebuildValues: [isDesk, isTablet],
        maxMinHeight: maxMinHeight ?? KMinMaxSize.minmaxHeight94,
      );
}

class _NawbarWidgetState extends State<NawbarWidget> {
  late FocusNode focusNode;
  late bool isFocused;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    isFocused = false;
    focusNode = FocusNode();
    focusNode.addListener(
      () => setState(() {
        isFocused = focusNode.hasFocus;
      }),
    );
    super.initState();
  }

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
      child: KTest.testIsWeb
          // || widget.showMobileNawbar
          ? Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.isTablet || !isFocused)
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => EasyDebounce.debounce(
                      KAppText.logo,
                      Duration.zero,
                      () {
                        if (KTest.testIsWeb
                            // || !widget.showMobileNawbar
                            ) {
                          context.goNamed(KRoute.home.name);
                        }
                      },
                    ),
                    icon: KImage.logo(
                      key: KWidgetkeys.widget.nawbar.logo,
                      // width: 78,
                    ),
                  ),
                if (Config.isDevelopment)
                  if (widget.isDesk)
                    KSizedBox.kWidthSizedBox40
                  else
                    KSizedBox.kWidthSizedBox22,
                if (Config.isDevelopment)
                  Expanded(
                    child: TextFieldWidget(
                      key: _formKey,
                      widgetKey: KWidgetkeys.widget.nawbar.field,
                      hintStyle: widget.isDesk
                          ? AppTextStyle.text24
                          : AppTextStyle.text16,
                      focusNode: focusNode,
                      prefixIcon: KIcon.search,
                      onChanged: (text) {},
                      hintText: context.l10n.search,
                      // suffixIcon: widget.isDesk || !widget.hasMicrophone
                      //     ? null
                      //     : KIcon.mic.setIconKey(
                      //         KWidgetkeys.widget.nawbar.iconMic,
                      //       ),
                      isDesk: widget.isDesk,
                      contentPadding: widget.isDesk
                          ? EdgeInsets.zero
                          : const EdgeInsets.all(KPadding.kPaddingSize16),
                    ),
                  )
                else if (widget.isTablet)
                  Expanded(
                    child: Wrap(
                      // mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _button(
                          key: KWidgetkeys.widget.nawbar.discountsButton,
                          ruoteName: KRoute.discounts.name,
                          text: context.l10n.discounts,
                          icon: const IconWidget(
                            icon: KIcon.tag,
                            background: AppColors.materialThemeSourceSeed,
                            padding: KPadding.kPaddingSize8,
                          ),
                          width: context.isEnglish
                              ? KSize.kPixel72
                              : KSize.kPixel56,
                        ),
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
                          width: context.isEnglish
                              ? KSize.kPixel60
                              : KSize.kPixel80,
                        ),
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
                          key: KWidgetkeys.widget.nawbar.feedbackButton,
                          ruoteName: KRoute.feedback.name,
                          text: context.l10n.contacts,
                          width: KSize.kPixel70,
                        ),
                      ],
                    ),
                  )
                else
                  // widget.pageName != null && !KTest.testIsWeb
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
                if (widget.isTablet)
                  LanguagesSwitcherWidget(
                    key: KWidgetkeys.widget.nawbar.language,
                  )
                else if (!isFocused)
                  IconButtonWidget(
                    key: KWidgetkeys.widget.nawbar.menuButton,
                    icon: KIcon.menu.copyWith(
                      color: AppColors.materialThemeWhite,
                    ),
                    background: AppColors.materialThemeKeyColorsSecondary,
                    onPressed: () async =>
                        context.dialog.showMobileMenuDialog(),
                  ),
                if (context.read<AuthenticationBloc>().state.status !=
                        AuthenticationStatus.authenticated &&
                    Config.isDevelopment) ...[
                  if (widget.isDesk) ...[
                    KSizedBox.kWidthSizedBox16,
                    DoubleButtonWidget(
                      widgetKey: KWidgetkeys.widget.nawbar.loginButton,
                      onPressed: () => userRoleNavigation(context),
                      text: context.l10n.login,
                      isDesk: true,
                      darkMode: true,
                    ),
                  ] else if (!isFocused) ...[
                    KSizedBox.kWidthSizedBox4,
                    IconButtonWidget(
                      key: KWidgetkeys.widget.nawbar.loginIcon,
                      onPressed: () => userRoleNavigation(context),
                      icon: KIcon.person
                          .copyWith(color: AppColors.materialThemeWhite),
                      background: AppColors.materialThemeKeyColorsSecondary,
                    ),
                  ],
                ],
                if (context.read<AuthenticationBloc>().state.status ==
                        AuthenticationStatus.authenticated &&
                    Config.isDevelopment)
                  if (!isFocused || widget.isTablet)
                    UserPhotoWidget(
                      key: KWidgetkeys.widget.nawbar.loginIcon,
                      onPressed: () => context.goNamed(KRoute.profile.name),
                      imageUrl:
                          context.read<AuthenticationBloc>().state.user?.photo,
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
    required double width,
    required Key key,
    Widget? icon,
  }) =>
      ButtonBottomLineWidget(
        text: text,
        onPressed: () => context.goNamed(ruoteName),
        width: width,
        // isDesk: widget.isTablet,
        icon: icon,
        widgetKey: key,
      );
  void userRoleNavigation(BuildContext context) =>
      context.goNamed(KRoute.userRole.name);
}
