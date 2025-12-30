import 'package:flutter/material.dart';

import 'package:basic_dropdown_button/basic_dropdown_button.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class PopupMenuButtonWidget<T> extends StatelessWidget {
  const PopupMenuButtonWidget({
    required this.items,
    required this.buttonStyle,
    required this.buttonText,
    // required this.buttonItemStyle,
    this.menuPadding,
    this.getMenuWidthFromButton = false,
    super.key,
    // this.onSelected,
    // this.menuItemsPadding =
    //     const EdgeInsets.symmetric(vertical: KPadding.kPaddingSize8),
    this.buttonChild,
    this.position = DropDownButtonPosition.bottomCenter,
    // this.menuTextStyle = AppTextStyle.materialThemeBodyMedium,
    this.menuTopSpace = KPadding.kPaddingSize8,
    // this.itemAlignment = Alignment.center,
    this.iconAlignment = IconAlignment.start,
    this.closeIcon,
    this.showIcon,
    // this.showIndicatorIcon = true,
    this.borderRadius,
    this.currentValue,
    this.iconSpace = KPadding.kPaddingSize16,
    this.menuColor = AppColors.materialThemeKeyColorsNeutral,
    this.itemsSpacing = KPadding.kPaddingSize8,
    // this.textUnderButton,
  });

  /// Called when the button is pressed to create the items to show in the menu.
  final List<CustomDropDownButtonItem<T>> items;

  // final PopupMenuItemSelected<T>? onSelected;

  // final EdgeInsets menuItemsPadding;

  /// If provided, the [buttonChild] is used for this button
  /// and the button will behave like an.
  final Widget? buttonChild;

  final BorderRadius? borderRadius;

  /// Whether the popup menu is positioned over or under the popup menu button.
  ///
  /// If this property is `null`, then [PopupMenuThemeData.position] is used. If
  /// [PopupMenuThemeData.position] is also `null`, then the position defaults
  /// to [DropDownButtonPosition.bottomCenter] which makes the popup menu
  /// appear directly
  /// over the button that was used to create it.
  final DropDownButtonPosition position;

  final ButtonStyle buttonStyle;

  final String? buttonText;

  final double menuTopSpace;

  // final Alignment itemAlignment;

  final IconAlignment iconAlignment;

  final Widget? closeIcon;

  final Widget? showIcon;

  // final Icon? iconButton;
  // final bool showIndicatorIcon;

  final bool getMenuWidthFromButton;

  // final ButtonStyle buttonItemStyle;

  final EdgeInsets? menuPadding;

  final T? currentValue;

  final double itemsSpacing;

  final double iconSpace;

  final Color menuColor;

  // final String? textUnderButton;

  @override
  Widget build(BuildContext context) {
    return CustomDropDownButton<T>(
      buttonStyle: buttonStyle,
      buttonText: buttonText,
      menuItems: items,
      menuVerticalSpacing: menuTopSpace,
      menuBackgroundColor: menuColor,
      // showIndicatorIcon: showIndicatorIcon,
      position: position,
      menuBorderRadius: borderRadius,
      buttonIcon: showIcon != null && closeIcon != null
          ? ({required showedMenu}) => showedMenu ? showIcon! : closeIcon!
          : null,
      menuItemsSpacing: itemsSpacing,
      buttonIconSpace: iconSpace,
      menuPadding: menuPadding ?? const EdgeInsets.all(KPadding.kPaddingSize8),
      buttonIconFirst: iconAlignment == IconAlignment.start,
      selectedValue: currentValue,
      buttonChild: buttonChild, //itemSpacing: menuItemsPadding,
      buttonTextStyle: AppTextStyle.materialThemeTitleMedium,
    );
  }
}

// class PopupMenuButtonWidget<T> extends StatefulWidget {
//   /// Creates a button that shows a popup menu.
//   const PopupMenuButtonWidget({
//     required this.items,
//     required this.buttonStyle,
//     required this.buttonText,
//     required this.buttonItemStyle,
//     this.menuPadding,
//     this.getMenuWidthFromButton = false,
//     super.key,
//     this.onSelected,
//     // this.menuItemsPadding =
//     //     const EdgeInsets.symmetric(vertical: KPadding.kPaddingSize8),
//     this.buttonChild,
//     this.position = PopupMenuButtonPosition.bottomCenter,
//     this.routeSettings,
//     this.menuTextStyle = AppTextStyle.materialThemeBodyMedium,
//     this.menuTopSpace = KPadding.kPaddingSize8,
//     // this.itemAlignment = Alignment.center,
//     this.iconAlignment = IconAlignment.start,
//     this.closeIcon,
//     this.showIcon,
//     this.showIndicatorIcon = true,
//     this.borderRadius,
//     this.currentValue,
//     this.iconSpace = KPadding.kPaddingSize16,
//     this.menuColor = AppColors.materialThemeKeyColorsNeutral,
//     // this.textUnderButton,
//   }) : assert(
//           !(buttonChild == null && buttonText == null),
//           'If you set null for [buttonText] you should'
//           ' set value for [buttonChild]',
//         );

//   /// Called when the button is pressed to create the items to show in the menu.
//   final List<CustomDropDownButtonItem<T>> items;

//   final PopupMenuItemSelected<T>? onSelected;

//   // final EdgeInsets menuItemsPadding;

//   /// If provided, the [buttonChild] is used for this button
//   /// and the button will behave like an.
//   final Widget? buttonChild;

//   final BorderRadius? borderRadius;

//   /// Whether the popup menu is positioned over or under the popup menu button.
//   ///
//   /// If this property is `null`, then [PopupMenuThemeData.position] is used. If
//   /// [PopupMenuThemeData.position] is also `null`, then the position defaults
//   /// to [PopupMenuButtonPosition.bottomCenter] which makes the popup menu
//   /// appear directly
//   /// over the button that was used to create it.
//   final PopupMenuButtonPosition position;

//   /// Optional route settings for the menu.
//   ///
//   /// See [RouteSettings] for details.
//   final RouteSettings? routeSettings;

//   final TextStyle menuTextStyle;

//   final ButtonStyle buttonStyle;

//   final String? buttonText;

//   final double menuTopSpace;

//   // final Alignment itemAlignment;

//   final IconAlignment iconAlignment;

//   final Widget? closeIcon;

//   final Widget? showIcon;

//   // final Icon? iconButton;
//   final bool showIndicatorIcon;

//   final bool getMenuWidthFromButton;

//   final ButtonStyle buttonItemStyle;

//   final EdgeInsets? menuPadding;

//   final T? currentValue;

//   final double iconSpace;

//   final Color menuColor;

//   // final String? textUnderButton;

//   @override
//   PopupMenuButtonWidgetState<T> createState() =>
//       PopupMenuButtonWidgetState<T>();
// }

// /// The [State] for a [PopupMenuButtonWidget].
// ///
// /// See [showHideButtonMenu] for a way to programmatically open the popup menu
// /// of your button state.
// class PopupMenuButtonWidgetState<T> extends State<PopupMenuButtonWidget<T>> {
//   // late double menuWidth;
//   late bool _showMenu;
//   // late GlobalKey _buttonKey;
//   // This Controller don't have discpose method
//   late OverlayPortalController _controller;
//   late LayerLink _optionsLayerLink;
//   late double? menuHeight;
//   late GlobalKey _menuKey;
//   late GlobalKey _anchorKey;

//   @override
//   void initState() {
//     super.initState();
//     _controller = OverlayPortalController();
//     _optionsLayerLink = LayerLink();

//     _showMenu = false;
//     menuHeight = null;

//     _menuKey = GlobalKey();
//     _anchorKey = GlobalKey();
//   }

//   // List<PopupMenuEntry<T>> _getItems(double? width) => List.generate(
//   //       widget.items.length,
//   //       (index) {
//   //         final item = widget.items.elementAt(index);
//   //         return _CustomDropDownButtonItemWidget<T>(
//   //           width: width,
//   //           key: item.key,
//   //           padding: widget.menuItemsPadding,
//   //           text: item.text,
//   //           textStyle: widget.menuTextStyle,
//   //           onTap: item.event,
//   //           enabled: item.enabled, //&& widget.initialValue != item.value,
//   //           alignment: widget.itemAlignment,
//   //           value: item.value,
//   //           icon: item.icon,
//   //         );
//   //       },
//   //       growable: false,
//   //     );

//   // double get getWidth {
//   //   final context = _buttonKey.currentContext;
//   //   if (context != null) {
//   //     final box = context.findRenderObject()! as RenderBox;
//   //     return box.hasSize ? box.size.width : double.infinity;
//   //   }
//   //   return double.infinity;
//   // }

//   void showHideButtonMenu() {
//     _controller.toggle();
//     setState(() {
//       _showMenu = !_showMenu;
//     });
//   }

//   void setMenuHeight() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final context = _menuKey.currentContext;
//       if (context != null) {
//         final box = context.findRenderObject()! as RenderBox;
//         if (box.hasSize) {
//           setState(() {
//             menuHeight = box.size.height;
//           });
//         }
//       }
//     });
//   }

//   double get getHeight {
//     final context = _anchorKey.currentContext;
//     if (context != null) {
//       final box = context.findRenderObject()! as RenderBox;
//       return box.hasSize ? box.size.height : 0;
//     }
//     return 0;
//   }

//   PopupMenuButtonPosition get _positionCalculate {
//     final renderObject = context.findRenderObject();

//     bool? hasBottomPlace;

//     if (menuHeight != null && renderObject != null) {
//       final renderBox = renderObject as RenderBox;
//       final screenHeight = MediaQuery.sizeOf(context).height;
//       final availableHeight =
//           screenHeight - (renderBox.localToGlobal(Offset.zero).dy +
// getHeight);
//       // +
//       //     (widget.isDesk ? KSize.kPixel70 : -KSize.kPixel20);
//       hasBottomPlace = availableHeight > menuHeight!;
//     }

//     return widget.position.positionCalculate(hasBottomPlace: hasBottomPlace);
//     // ? OptionsViewOpenDirection.down
//     // : OptionsViewOpenDirection.up;
//   }

//   Widget _getMenuWidget(BuildContext context) {
//     final positionValue = _positionCalculate;
//     if (menuHeight == null) setMenuHeight();
//     return CompositedTransformFollower(
//       link: _optionsLayerLink,
//       showWhenUnlinked: false,
//       targetAnchor: positionValue.getMenuPosition,
//       followerAnchor: positionValue.getContentPosition,
//       child: Align(
//         alignment: positionValue.getContentPosition,
//         child: Padding(
//           padding: EdgeInsets.only(top: widget.menuTopSpace),
//           child: TapRegion(
//             onTapOutside: (event) => showHideButtonMenu(),
//             child: DecoratedBox(
//               key: _menuKey,
//               decoration: BoxDecoration(
//                 color: widget.menuColor,
//                 borderRadius: widget.borderRadius,
//               ),
//               child: Padding(
//                 padding: widget.menuPadding ?? const EdgeInsets.all(8),
//                 child: IntrinsicWidth(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     spacing: KPadding.kPaddingSize8,
//                     children: List.generate(widget.items.length, (index) {
//                       final item = widget.items.elementAt(index);
//                       final isSelected = widget.currentValue != null &&
//                           widget.currentValue == item.value;
//                       return TextButton(
//                         key: item.key,
//                         style: widget.buttonItemStyle,
//                         onPressed: item.event == null || isSelected
//                             ? null
//                             : () {
//                                 item.event!();
//                                 showHideButtonMenu();
//                               },
//                         child: item.icon != null
//                             ? Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 spacing: widget.iconSpace,
//                                 children: [
//                                   item.icon!,
//                                   Flexible(
//                                     child: Text(
//                                       item.text,
//                                       textAlign: TextAlign.start,
//                                       style: widget.menuTextStyle,
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             : Text(
//                                 item.text,
//                                 textAlign: TextAlign.start,
//                                 style: widget.menuTextStyle,
//                               ),
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   // if (widget.getMenuWidthFromButton && itemsWidthFunction != null) {
//   //   menuWidth = getWidth;
//   //   items = itemsWidthFunction!(menuWidth);
//   //   itemsWidthFunction = null;
//   // }
//   // final button = context.findRenderObject()! as RenderBox;
//   // final overlay = Navigator.of(
//   //   context,
//   //   rootNavigator: widget.useRootNavigator,
//   // ).overlay!.context.findRenderObject()! as RenderBox;
//   // final menuSizeWidth = 170;
//   // //  menuWidth +
//   // //     widget.menuPadding.horizontal +
//   // //     widget.menuItemsPadding.horizontal +
//   // //     // Standart padding for PopupMenuEntry
//   // //     KPadding.kPaddingSize20;
//   // late Offset offset;
//   // switch (widget.position) {
//   //   case PopupMenuButtonPosition.bottomRight:
//   //     offset = button.size.bottomRight(
//   //       Offset(
//   //         menuSizeWidth - button.size.width,
//   //         widget.menuTopSpace,
//   //       ),
//   //     );
//   //   case PopupMenuButtonPosition.bottomLeft:
//   //     offset = button.size.bottomLeft(
//   //       Offset(
//   //         button.size.width,
//   //         widget.menuTopSpace,
//   //       ),
//   //     );
//   //   case PopupMenuButtonPosition.bottomCenter:
//   //     offset = button.size.bottomCenter(
//   //       Offset(
//   //         -menuSizeWidth / 2,
//   //         widget.menuTopSpace,
//   //       ),
//   //     );
//   // }

//   // final buttonOffset = button.localToGlobal(offset, ancestor: overlay);

//   // final position = RelativeRect.fromRect(
//   //   Rect.fromPoints(
//   //     buttonOffset,
//   //     buttonOffset,
//   //   ),
//   //   Offset.zero & overlay.size,
//   // );
//   // Only show the menu if there is something to show
//   // if (items.isNotEmpty) {
//   //   widget.onOpened?.call();
//   //   showMenu<T?>(
//   //     context: context,
//   //     elevation: widget.elevation,
//   //     shadowColor: widget.shadowColor,
//   //     surfaceTintColor: widget.surfaceTintColor,
//   //     items: items,
//   //     initialValue: widget.initialValue,
//   //     position: position,
//   //     shape: widget.shape,
//   //     menuPadding: widget.menuPadding,
//   //     color: widget.color,
//   //     constraints: widget.constraints,
//   //     clipBehavior: widget.clipBehavior,
//   //     useRootNavigator: widget.useRootNavigator,
//   //     popUpAnimationStyle: widget.popUpAnimationStyle,
//   //     routeSettings: widget.routeSettings,
//   //   ).then<void>((T? newValue) {
//   //     setState(() {
//   //       _showMenu = false;
//   //     });
//   //     if (!mounted) {
//   //       return null;
//   //     }
//   //     if (newValue == null) {
//   //       widget.onCanceled?.call();
//   //       return null;
//   //     }
//   //     widget.onSelected?.call(newValue);
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return RepaintBoundary(
//       child: OverlayPortal.targetsRootOverlay(
//         controller: _controller,
//         overlayChildBuilder: _getMenuWidget,
//         child: CompositedTransformTarget(
//           link: _optionsLayerLink,
//           child: TextButton.icon(
//             key: _anchorKey,
//             onPressed: _showMenu ? null : showHideButtonMenu,
//             style: _showMenu
//                 ? widget.buttonStyle.copyWith(
//                     mouseCursor: const WidgetStatePropertyAll(
//                       SystemMouseCursors.click,
//                     ),
//                     iconColor: const WidgetStatePropertyAll(
//                       AppColors.materialThemeBlack,
//                     ),
//                   )
//                 : widget.buttonStyle,
//             icon: widget.showIndicatorIcon
//                 ? (_showMenu
//                     ? widget.closeIcon ?? KIcon.trailingUp
//                     : widget.showIcon ?? KIcon.keyboardArrowDown)
//                 : null,
//             iconAlignment: widget.iconAlignment,
//             label: widget.buttonChild ??
//                 Text(
//                   widget.buttonText!,
//                   style: AppTextStyle.materialThemeTitleMedium,
//                 ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// enum PopupMenuButtonPosition {
//   bottomCenter,
//   bottomRight,
//   bottomLeft,
//   topCenter,
//   topRight,
//   topLeft,
// }

// class _CustomDropDownButtonItemWidget<T> extends PopupMenuEntry<T> {
//   const _CustomDropDownButtonItemWidget({
//     required this.text,
//     required this.textStyle,
//     required this.alignment,
//     required this.value,
//     required this.padding,
//     required this.onTap,
//     required this.enabled,
//     this.height = kMinInteractiveDimension,
//     this.width,
//     this.icon,
//     super.key,
//   });

//   final T? value;
//   final VoidCallback? onTap;
//   final bool enabled;
//   final EdgeInsets padding;
//   final Widget? icon;
//   final double? width;

//   @override
//   final double height;

//   final String text;

//   final TextStyle textStyle;

//   final Alignment alignment;

//   @override
//   bool represents(T? value) => value == this.value;

//   @override
//   _CustomDropDownButtonItemState<T, _CustomDropDownButtonItemWidget<T>>
// createState()
// =>
//       _CustomDropDownButtonItemState<T, _CustomDropDownButtonItemWidget<T>>
// ();
// }

// class _CustomDropDownButtonItemState<T, W extends
// _CustomDropDownButtonItemWidget<T>>
//     extends State<W> {
//   @protected
//   void handleTap() {
//     context.pop<T>(widget.value);
//     widget.onTap?.call();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MergeSemantics(
//       child: Semantics(
//         enabled: widget.enabled,
//         button: true,
//         onTap: widget.enabled ? handleTap : null,
//         child: SizedBox(
//           width: widget.width,
//           child: TextButton(
//             style: ButtonStyle(
//               padding: WidgetStatePropertyAll(widget.padding),
//               shape: const WidgetStatePropertyAll(
//                 KWidgetTheme.outlineBorder,
//               ),
//               alignment: widget.alignment,
//             ),
//             onPressed: widget.enabled ? handleTap : null,
//             child: ListTileTheme.merge(
//               contentPadding: EdgeInsets.zero,
//               child: widget.icon != null
//                   ? Row(
//                       children: [
//                         widget.icon!,
//                         KSizedBox.kWidthSizedBox16,
//                         Text(
//                           widget.text,
//                           textAlign: TextAlign.start,
//                           style: widget.textStyle,
//                         ),
//                       ],
//                     )
//                   : Text(
//                       widget.text,
//                       textAlign: TextAlign.start,
//                       style: widget.textStyle,
//                     ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
