import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class NawbarWidget extends SliverPersistentHeaderDelegate {
  const NawbarWidget({
    required this.isDesk,
    required this.isTablet,
    this.widgetKey,
    this.childWidget,
    this.maxMinHeight,
    this.pageName,
    this.showMobileNawbar,
  });
  final bool isDesk;
  final bool isTablet;
  final Key? widgetKey;
  final Widget? childWidget;
  final double? maxMinHeight;
  final String? pageName;
  final bool? showMobileNawbar;

  @override
  double get maxExtent => maxMinHeight ?? KMinMaxSize.minmaxHeight94;

  @override
  double get minExtent => maxMinHeight ?? KMinMaxSize.minmaxHeight94;

  //Rebuild screen only when isDesk value change
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate is NawbarWidget &&
      (isDesk != oldDelegate.isDesk || isTablet != oldDelegate.isTablet);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return _NawbarWidgetImplematation(
      key: widgetKey,
      isDesk: isDesk,
      childWidget: childWidget,
      isTablet: isTablet,
      pageName: pageName,
      showMobileNawbar: showMobileNawbar ?? false,
    );
  }
}

class _NawbarWidgetImplematation extends StatefulWidget {
  const _NawbarWidgetImplematation({
    required this.isDesk,
    required this.isTablet,
    required this.showMobileNawbar,
    super.key,
    this.childWidget,
    this.pageName,
  });
  final bool isDesk;
  final Widget? childWidget;
  final bool isTablet;
  final String? pageName;
  final bool showMobileNawbar;

  @override
  State<_NawbarWidgetImplematation> createState() =>
      _NawbarWidgetImplematationState();
}

class _NawbarWidgetImplematationState
    extends State<_NawbarWidgetImplematation> {
  late FocusNode focusNode;
  late bool isFocused = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
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
    return widget.childWidget ??
        Container(
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
          child: KTest.testIsWeb || widget.showMobileNawbar
              ? Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.isDesk || !isFocused)
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => EasyDebounce.debounce(
                          KAppText.logo,
                          Duration.zero,
                          () {
                            if (KTest.testIsWeb || !widget.showMobileNawbar) {
                              context.goNamedWithScroll(KRoute.home.name);
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
                        child: Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _button(
                              ruoteName: KRoute.discounts.name,
                              text: context.l10n.discounts,
                              icon: const IconWidget(
                                icon: KIcon.tag,
                                background: AppColors.materialThemeSourceSeed,
                                padding: KPadding.kPaddingSize8,
                              ),
                              width: _isEnglish(context)
                                  ? KSize.kPixel72
                                  : KSize.kPixel56,
                            ),
                            KSizedBox.kWidthSizedBox32,
                            const CircleAvatar(
                              radius: KPadding.kPaddingSize2,
                            ),
                            KSizedBox.kWidthSizedBox32,
                            _button(
                              ruoteName: KRoute.investors.name,
                              text: context.l10n.investors,
                              width: _isEnglish(context)
                                  ? KSize.kPixel66
                                  : KSize.kPixel88,
                            ),
                            KSizedBox.kWidthSizedBox32,
                            const CircleAvatar(
                              radius: KPadding.kPaddingSize2,
                            ),
                            KSizedBox.kWidthSizedBox32,
                            _button(
                              ruoteName: KRoute.feedback.name,
                              text: context.l10n.contact,
                              width: _isEnglish(context)
                                  ? KSize.kPixel62
                                  : KSize.kPixel80,
                            ),
                          ],
                        ),
                      )
                    else
                      widget.pageName != null && !KTest.testIsWeb
                          ? Expanded(
                              child: Text(
                                '${widget.pageName}',
                                style: AppTextStyle.materialThemeTitleMedium,
                                textAlign: TextAlign.center,
                              ),
                            )
                          : const Spacer(),

                    // if (widget.isDesk && widget.hasMicrophone)
                    //   Padding(
                    //     padding: const EdgeInsets.only(right:
                    // KPadding.kPaddingSize32),
                    //     child: IconWidget(
                    //       key: KWidgetkeys.widget.nawbar.iconMic,
                    //       icon: KIcon.mic,
                    //     ),
                    //   ),
                    if (widget.isDesk || !isFocused)
                      widget.isTablet
                          ? const LanguagesSwitcherWidget()
                          : IconButtonWidget(
                              icon: KIcon.menu.copyWith(
                                color: AppColors.materialThemeWhite,
                              ),
                              background:
                                  AppColors.materialThemeKeyColorsSecondary,
                              onPressed: () async =>
                                  context.dialog.showMobileMenuDialog(),
                            ),
                    if (context.read<AuthenticationBloc>().state.status !=
                            AuthenticationStatus.authenticated &&
                        Config.isDevelopment) ...[
                      KSizedBox.kWidthSizedBox16,
                      if (widget.isDesk)
                        TextButton(
                          key: KWidgetkeys.widget.nawbar.button,
                          style: KButtonStyles.whiteButtonStyle,
                          onPressed: () => loginNavigation(context),
                          child: Text(
                            context.l10n.login,
                            style: AppTextStyle.text24,
                          ),
                        )
                      else if (!isFocused)
                        IconButtonWidget(
                          key: KWidgetkeys.widget.nawbar.iconPerson,
                          onPressed: () => loginNavigation(context),
                          icon: KIcon.person
                              .copyWith(color: AppColors.materialThemeWhite),
                          background: AppColors.materialThemeKeyColorsSecondary,
                        ),
                    ],
                    if (context.read<AuthenticationBloc>().state.status ==
                            AuthenticationStatus.authenticated &&
                        Config.isDevelopment)
                      if (!isFocused || widget.isDesk)
                        UserPhotoWidget(
                          key: KWidgetkeys.widget.nawbar.iconPerson,
                          onPressed: () => context.goNamed(KRoute.profile.name),
                          imageUrl: context
                              .read<AuthenticationBloc>()
                              .state
                              .user
                              ?.photo,
                        ),
                  ],
                )
              : Text(
                  '${widget.pageName}',
                  style: AppTextStyle.materialThemeTitleMedium,
                  textAlign: TextAlign.center,
                ),
        );
  }

  bool _isEnglish(BuildContext context) =>
      context.read<AuthenticationBloc>().state.userSetting.locale.isEnglish;

  double get padding => widget.isDesk
      ? KPadding.kPaddingSize90
      : widget.isTablet
          ? KPadding.kPaddingSize32
          : KPadding.kPaddingSize16;
  Widget _button({
    required String ruoteName,
    required String text,
    required double width,
    Widget? icon,
  }) =>
      ButtonBottomLineWidget(
        text: text,
        onPressed: () => context.goNamed(ruoteName),
        width: width,
        isDesk: widget.isDesk,
        icon: icon,
      );
  void loginNavigation(BuildContext context) =>
      context.goNamed(KRoute.login.name);
}
