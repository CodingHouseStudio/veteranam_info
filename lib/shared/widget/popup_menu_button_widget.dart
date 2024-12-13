import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class PopupMenuButtonWidget<T> extends StatefulWidget {
  /// Creates a button that shows a popup menu.
  const PopupMenuButtonWidget({
    required this.items,
    required this.buttonStyle,
    required this.buttonText,
    super.key,
    this.initialValue,
    this.onOpened,
    this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.menuPadding =
        const EdgeInsets.symmetric(vertical: KPadding.kPaddingSize8),
    this.menuItemsPadding =
        const EdgeInsets.symmetric(vertical: KPadding.kPaddingSize8),
    this.icon,
    this.enabled = true,
    this.shape = KWidgetTheme.outlineBorder,
    this.color = AppColors.materialThemeKeyColorsNeutral,
    this.constraints = const BoxConstraints(),
    this.position = PopupMenuButtonPosition.bottomCenter,
    this.clipBehavior = Clip.none,
    this.useRootNavigator = false,
    this.popUpAnimationStyle,
    this.routeSettings,
    this.menuTextStyle = AppTextStyle.materialThemeBodyMedium,
    this.menuTopSpace = KPadding.kPaddingSize8,
    this.itemAlignment = Alignment.center,
    this.iconAlignment = IconAlignment.start,
    this.closeIcon,
    this.showIcon,
    this.iconButton,
    this.textUnderButton,
    this.itemPadding,
  });

  /// Called when the button is pressed to create the items to show in the menu.
  final List<DropDownItem<T>> items;

  /// The value of the menu item, if any, that should be highlighted when
  /// the menu opens.
  final T? initialValue;

  /// Called when the popup menu is shown.
  final VoidCallback? onOpened;

  /// Called when the user selects a value from the popup menu created by this
  /// button.
  ///
  /// If the popup menu is dismissed without selecting a value, [onCanceled] is
  /// called instead.
  final PopupMenuItemSelected<T>? onSelected;

  /// Called when the user dismisses the popup menu without selecting an item.
  ///
  /// If the user selects a value, [onSelected] is called instead.
  final PopupMenuCanceled? onCanceled;

  /// Text that describes the action that will occur when the button is pressed.
  ///
  /// This text is displayed when the user long-presses on the button and is
  /// used for accessibility.
  final String? tooltip;

  /// The z-coordinate at which to place the menu when open. This controls the
  /// size of the shadow below the menu.
  ///
  /// Defaults to 8, the appropriate elevation for popup menus.
  final double? elevation;

  /// The color used to paint the shadow below the menu.
  ///
  /// If null then the ambient [PopupMenuThemeData.shadowColor] is used.
  /// If that is null too, then the overall theme's [ThemeData.shadowColor]
  /// (default black) is used.
  final Color? shadowColor;

  /// The color used as an overlay on [color] to indicate elevation.
  ///
  /// This is not recommended for use. [Material 3 spec](https://m3.material.io/styles/color/the-color-system/color-roles)
  /// introduced a set of tone-based surfaces and surface containers in its
  /// [ColorScheme],
  /// which provide more flexibility. The intention is to eventually remove
  /// surface tint color from
  /// the framework.
  ///
  /// If null, [PopupMenuThemeData.surfaceTintColor] is used. If that
  /// is also null, the default value is [Colors.transparent].
  ///
  /// See [Material.surfaceTintColor] for more details on how this
  /// overlay is applied.
  final Color? surfaceTintColor;

  /// If provided, menu padding is used for empty space around the outside
  /// of the popup menu.
  ///
  /// If this property is null, then [PopupMenuThemeData.menuPadding] is used.
  /// If [PopupMenuThemeData.menuPadding] is also null, then vertical padding
  /// of 8 pixels is used.
  final EdgeInsetsGeometry menuPadding;

  final EdgeInsets menuItemsPadding;

  /// If provided, the [icon] is used for this button
  /// and the button will behave like an.
  final Widget? icon;

  /// The offset is applied relative to the initial position
  /// set by the [position].
  ///
  /// When not set, the offset defaults to [Offset.zero].
  // final Offset offset;

  /// Whether this popup menu button is interactive.
  ///
  /// Defaults to true.
  ///
  /// If true, the button will respond to presses by displaying the menu.
  ///
  /// If false, the button is styled with the disabled color from the
  /// current [Theme] and will not respond to presses or show the popup
  /// menu and [onSelected], [onCanceled] and [items] will not be called.
  ///
  /// This can be useful in situations where the app needs to show the button,
  /// but doesn't currently have anything to show in the menu.
  final bool enabled;

  /// If provided, the shape used for the menu.
  ///
  /// If this property is null, then [PopupMenuThemeData.shape] is used.
  /// If [PopupMenuThemeData.shape] is also null, then the default shape for
  /// [MaterialType.card] is used. This default shape is a rectangle with
  /// rounded edges of BorderRadius.circular(2.0).
  final ShapeBorder? shape;

  /// If provided, the background color used for the menu.
  ///
  /// If this property is null, then [PopupMenuThemeData.color] is used.
  /// If [PopupMenuThemeData.color] is also null, then
  /// [ThemeData.cardColor] is used in Material 2. In Material3, defaults to
  /// [ColorScheme.surfaceContainer].
  final Color color;

  /// Optional size constraints for the menu.
  ///
  /// The default constraints ensure that the menu width matches maximum width
  /// recommended by the Material Design guidelines.
  /// Specifying this parameter enables creation of menu wider than
  /// the default maximum width.
  final BoxConstraints? constraints;

  /// Whether the popup menu is positioned over or under the popup menu button.
  ///
  /// If this property is `null`, then [PopupMenuThemeData.position] is used. If
  /// [PopupMenuThemeData.position] is also `null`, then the position defaults
  /// to [PopupMenuButtonPosition.bottomCenter] which makes the popup menu
  /// appear directly
  /// over the button that was used to create it.
  final PopupMenuButtonPosition position;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// The [clipBehavior] argument is used the clip shape of the menu.
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// Used to determine whether to push the menu to the [Navigator] furthest
  /// from or nearest to the given `context`.
  ///
  /// Defaults to false.
  final bool useRootNavigator;

  /// Used to override the default animation curves and durations of the popup
  /// menu's open and close transitions.
  ///
  /// If [AnimationStyle.curve] is provided, it will be used to override
  /// the default popup animation curve. Otherwise, defaults to [Curves.linear].
  ///
  /// If [AnimationStyle.reverseCurve] is provided, it will be used to
  /// override the default popup animation reverse curve. Otherwise, defaults to
  /// `Interval(0.0, 2.0 / 3.0)`.
  ///
  /// If [AnimationStyle.duration] is provided, it will be used to override
  /// the default popup animation duration. Otherwise, defaults to 300ms.
  ///
  /// To disable the theme animation, use [AnimationStyle.noAnimation].
  ///
  /// If this is null, then the default animation will be used.
  final AnimationStyle? popUpAnimationStyle;

  /// Optional route settings for the menu.
  ///
  /// See [RouteSettings] for details.
  final RouteSettings? routeSettings;

  final TextStyle menuTextStyle;

  final ButtonStyle buttonStyle;

  final String buttonText;

  final double menuTopSpace;

  final Alignment itemAlignment;

  final IconAlignment iconAlignment;

  final Widget? closeIcon;

  final Widget? showIcon;

  final Icon? iconButton;

  final String? textUnderButton;

  final EdgeInsetsGeometry? itemPadding;

  @override
  PopupMenuButtonWidgetState<T> createState() =>
      PopupMenuButtonWidgetState<T>();
}

/// The [State] for a [PopupMenuButtonWidget].
///
/// See [showButtonMenu] for a way to programmatically open the popup menu
/// of your button state.
class PopupMenuButtonWidgetState<T> extends State<PopupMenuButtonWidget<T>> {
  late List<PopupMenuEntry<T?>> items;
  late double menuWidth;
  late bool _showMenu;

  @override
  void initState() {
    super.initState();
    getItems();
    var longItem = '';
    for (final element in widget.items) {
      if (element.text.length > longItem.length) longItem = element.text;
    }
    menuWidth = longItem.getTextWidth(textStyle: widget.menuTextStyle);

    _showMenu = false;
  }

  @override
  void didUpdateWidget(covariant PopupMenuButtonWidget<T> oldWidget) {
    if (widget.items != oldWidget.items) getItems();
    super.didUpdateWidget(oldWidget);
  }

  void getItems() => items = List.generate(
        widget.items.length,
        (index) {
          final item = widget.items.elementAt(index);
          return _PopupMenuItemWidget<T>(
            key: item.key,
            padding: widget.menuItemsPadding,
            text: item.text,
            textStyle: widget.menuTextStyle,
            onTap: item.event,
            enabled: item.enabled && widget.initialValue != item.value,
            alignment: widget.itemAlignment,
            value: item.value,
            icon: item.icon,
            itemPadding: item.padding,
          );
        },
        growable: false,
      );

  /// A method to show a popup menu with the items supplied to
  /// [PopupMenuButtonWidget.items] at the position of your
  ///  [PopupMenuButtonWidget].
  ///
  /// By default, it is called when the user taps the button and
  /// [PopupMenuButtonWidget.enabled]
  /// is set to `true`. Moreover, you can open the button by calling the method
  /// manually.
  ///
  /// You would access your [PopupMenuButtonWidgetState] using a [GlobalKey] and
  /// show the menu of the button with `globalKey.currentState.showButtonMenu`.
  void showButtonMenu() {
    setState(() {
      _showMenu = true;
    });
    final button = context.findRenderObject()! as RenderBox;
    final overlay = Navigator.of(
      context,
      rootNavigator: widget.useRootNavigator,
    ).overlay!.context.findRenderObject()! as RenderBox;
    final menuSizeWidth = menuWidth +
        widget.menuPadding.horizontal +
        widget.menuItemsPadding.horizontal +
        // Standart padding for PopupMenuEntry
        KPadding.kPaddingSize20;
    late Offset offset;
    switch (widget.position) {
      case PopupMenuButtonPosition.bottomRight:
        offset = button.size.bottomRight(
          Offset(
            menuSizeWidth - button.size.width,
            widget.menuTopSpace,
          ),
        );
      case PopupMenuButtonPosition.bottomLeft:
        offset = button.size.bottomLeft(
          Offset(
            button.size.width,
            widget.menuTopSpace,
          ),
        );
      case PopupMenuButtonPosition.bottomCenter:
        offset = button.size.bottomCenter(
          Offset(
            -menuSizeWidth / 2,
            widget.menuTopSpace,
          ),
        );
    }

    final buttonOffset = button.localToGlobal(offset, ancestor: overlay);

    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        buttonOffset,
        buttonOffset,
      ),
      Offset.zero & overlay.size,
    );
    // Only show the menu if there is something to show
    if (items.isNotEmpty) {
      widget.onOpened?.call();
      showMenu<T?>(
        context: context,
        elevation: widget.elevation,
        shadowColor: widget.shadowColor,
        surfaceTintColor: widget.surfaceTintColor,
        items: items,
        initialValue: widget.initialValue,
        position: position,
        shape: widget.shape,
        menuPadding: widget.menuPadding,
        color: widget.color,
        constraints: widget.constraints,
        clipBehavior: widget.clipBehavior,
        useRootNavigator: widget.useRootNavigator,
        popUpAnimationStyle: widget.popUpAnimationStyle,
        routeSettings: widget.routeSettings,
      ).then<void>((T? newValue) {
        setState(() {
          _showMenu = false;
        });
        if (!mounted) {
          return null;
        }
        if (newValue == null) {
          widget.onCanceled?.call();
          return null;
        }
        widget.onSelected?.call(newValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.iconButton != null
        ? widget.textUnderButton != null
            ? TextButton(
                onPressed: widget.enabled ? showButtonMenu : null,
                style: KButtonStyles.noBackgroundOnHoverButtonStyle,
                child: Column(
                  children: [
                    IconWidget(
                      decoration: KWidgetTheme.boxDecorationPopupMenuBorder,
                      icon: widget.iconButton!,
                      padding: KPadding.kPaddingSize12,
                    ),
                    KSizedBox.kHeightSizedBox6,
                    Text(
                      widget.textUnderButton!,
                      style: AppTextStyle.materialThemeLabelSmallBlack,
                    ),
                  ],
                ),
              )
            : IconButton(
                style: KButtonStyles.borderWhiteButtonStyle,
                onPressed: widget.enabled ? showButtonMenu : null,
                icon: KIcon.moreVert,
                padding: const EdgeInsets.all(
                  KPadding.kPaddingSize12,
                ),
              )
        : TextButton.icon(
            onPressed: widget.enabled ? showButtonMenu : null,
            style: widget.buttonStyle,
            icon: _showMenu
                ? widget.closeIcon ?? KIcon.trailingUp
                : widget.showIcon ?? KIcon.keyboardArrowDown,
            iconAlignment: widget.iconAlignment,
            label: widget.icon ??
                Text(
                  widget.buttonText,
                  style: AppTextStyle.materialThemeTitleMedium,
                ),
          );
  }
}

enum PopupMenuButtonPosition {
  bottomCenter,
  bottomRight,
  bottomLeft,
}

class _PopupMenuItemWidget<T> extends PopupMenuEntry<T> {
  const _PopupMenuItemWidget({
    required this.text,
    required this.textStyle,
    required this.alignment,
    required this.value,
    required this.padding,
    required this.onTap,
    required this.enabled,
    this.height = kMinInteractiveDimension,
    this.icon,
    this.itemPadding,
    super.key,
  });

  final T? value;
  final VoidCallback? onTap;
  final bool enabled;
  final EdgeInsets padding;
  final Widget? icon;
  final EdgeInsets? itemPadding;

  @override
  final double height;

  final String text;

  final TextStyle textStyle;

  final Alignment alignment;

  @override
  bool represents(T? value) => value == this.value;

  @override
  _PopupMenuItemState<T, _PopupMenuItemWidget<T>> createState() =>
      _PopupMenuItemState<T, _PopupMenuItemWidget<T>>();
}

class _PopupMenuItemState<T, W extends _PopupMenuItemWidget<T>>
    extends State<W> {
  @protected
  void handleTap() {
    context.pop<T>(widget.value);
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(
        enabled: widget.enabled,
        button: true,
        onTap: widget.enabled ? handleTap : null,
        child: Padding(
          padding: widget.itemPadding ?? EdgeInsets.zero,
          child: TextButton(
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(widget.padding),
              shape: const WidgetStatePropertyAll(
                KWidgetTheme.outlineBorder,
              ),
              alignment: widget.alignment,
            ),
            onPressed: widget.enabled ? handleTap : null,
            child: ListTileTheme.merge(
              contentPadding: EdgeInsets.zero,
              child: widget.icon != null
                  ? Row(
                      children: [
                        widget.icon!,
                        KSizedBox.kWidthSizedBox16,
                        Text(
                          widget.text,
                          textAlign: TextAlign.start,
                          style: widget.textStyle,
                        ),
                      ],
                    )
                  : Text(
                      widget.text,
                      textAlign: TextAlign.start,
                      style: widget.textStyle,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
