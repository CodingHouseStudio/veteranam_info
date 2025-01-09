import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class CitySearchFieldWidget extends StatefulWidget {
  const CitySearchFieldWidget({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  State<CitySearchFieldWidget> createState() => _CitySearchFieldWidgetState();
}

class _CitySearchFieldWidgetState extends State<CitySearchFieldWidget> {
  late FocusNode _focusNode;
  late TextEditingController _controller;
  late Widget icon;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController();
    icon = _icon;
    _focusNode.addListener(
      iconListener,
    );
  }

  void iconListener() {
    setState(() {
      icon = _icon;
    });
  }

  Widget get _icon => _focusNode.hasFocus
      ? IconButtonWidget(
          icon: KIcon.close,
          padding: KPadding.kPaddingSize4,
          onPressed: () {
            context.read<DiscountsWatcherBloc>().add(
                  const DiscountsWatcherEvent.searchLocation(''),
                );
            _focusNode.unfocus();
            _controller.clear();
          },
          background: Colors.transparent,
        )
      : KIcon.search;
  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      widgetKey: const Key('value1'),
      onChanged: (value) => context
          .read<DiscountsWatcherBloc>()
          .add(DiscountsWatcherEvent.searchLocation(value)),
      isDesk: widget.isDesk,
      focusNode: _focusNode,
      controller: _controller,
      labelText: context.l10n.search,
      suffixIcon: _icon,
      fillColor: widget.isDesk ? AppColors.materialThemeKeyColorsNeutral : null,
      enabledBorder: KWidgetTheme.outlineInputBorder,
      focusColor: AppColors.materialThemeKeyColorsNeutralVariant,
      hoverColor: AppColors.materialThemeSysLightOnBackgroundOpacity8,
    );
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(iconListener)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }
}
