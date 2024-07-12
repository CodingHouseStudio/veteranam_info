import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class NawbarWidget extends SliverPersistentHeaderDelegate {
  const NawbarWidget({
    required this.isDesk,
    this.widgetKey,
    this.childWidget,
    this.maxMinHeight,
  });
  final bool isDesk;
  final Key? widgetKey;
  final Widget? childWidget;
  final double? maxMinHeight;

  @override
  double get maxExtent => maxMinHeight ?? KMinMaxSize.minmaxHeight94;

  @override
  double get minExtent => maxMinHeight ?? KMinMaxSize.minmaxHeight94;

  //Rebuild screen only when isDesk value change
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate is NawbarWidget && isDesk != oldDelegate.isDesk;

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
    );
  }
}

class _NawbarWidgetImplematation extends StatefulWidget {
  const _NawbarWidgetImplematation({
    required this.isDesk,
    super.key,
    this.childWidget,
  });
  final bool isDesk;
  final Widget? childWidget;

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
            left: widget.isDesk
                ? KPadding.kPaddingSize90
                : KPadding.kPaddingSize16,
            right: widget.isDesk
                ? KPadding.kPaddingSize90
                : KPadding.kPaddingSize16,
          ),
          padding: const EdgeInsets.only(
            left: KPadding.kPaddingSize32,
            right: KPadding.kPaddingSize16,
            top: KPadding.kPaddingSize12,
            bottom: KPadding.kPaddingSize12,
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.isDesk || !isFocused)
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => EasyDebounce.debounce(
                    context.l10n.logo,
                    Duration.zero,
                    () => context.goNamedWithScroll(KRoute.home.name),
                  ),
                  icon: KImage.logo(
                    key: KWidgetkeys.widget.nawbar.logo,
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
              else if (widget.isDesk) ...[
                Expanded(
                  child: TextButton.icon(
                    style: const ButtonStyle(alignment: Alignment.centerRight),
                    onPressed: () => context.goNamed(KRoute.discounts.name),
                    label: Text(
                      context.l10n.discounts,
                      style: AppTextStyle.materialThemeTitleMedium,
                    ),
                    icon: KIcon.tag,
                  ),
                ),
                KSizedBox.kWidthSizedBox64,
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => context.goNamed(KRoute.information.name),
                    label: Text(
                      context.l10n.information,
                      style: AppTextStyle.materialThemeTitleMedium,
                    ),
                    icon: KIcon.globe,
                  ),
                ),
                KSizedBox.kWidthSizedBox64,
                Expanded(
                  child: TextButton.icon(
                    style: const ButtonStyle(alignment: Alignment.centerLeft),
                    onPressed: () => context.goNamed(KRoute.investors.name),
                    label: Text(
                      context.l10n.investors,
                      style: AppTextStyle.materialThemeTitleMedium,
                    ),
                    icon: KIcon.fileText,
                  ),
                ),
              ],

              // if (widget.isDesk && widget.hasMicrophone)
              //   Padding(
              //     padding: const EdgeInsets.only(right:
              // KPadding.kPaddingSize32),
              //     child: IconWidget(
              //       key: KWidgetkeys.widget.nawbar.iconMic,
              //       icon: KIcon.mic,
              //     ),
              //   ),
              if (widget.isDesk || !isFocused) const LanguagesSwitcherWidget(),
              KSizedBox.kWidthSizedBox16,
              if (context.read<AuthenticationBloc>().state.status !=
                      AuthenticationStatus.authenticated &&
                  Config.isDevelopment)
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
              if (context.read<AuthenticationBloc>().state.status ==
                      AuthenticationStatus.authenticated &&
                  Config.isDevelopment)
                if (!isFocused || widget.isDesk)
                  UserPhotoWidget(
                    key: KWidgetkeys.widget.nawbar.iconPerson,
                    onPressed: () => context.goNamed(KRoute.profile.name),
                    imageUrl:
                        context.read<AuthenticationBloc>().state.user?.photo,
                  ),
            ],
          ),
        );
  }

  void loginNavigation(BuildContext context) =>
      context.goNamed(KRoute.login.name);
}
