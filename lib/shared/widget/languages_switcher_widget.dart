import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class LanguagesSwitcherWidget extends StatelessWidget {
  const LanguagesSwitcherWidget({
    this.decoration,
    super.key,
    this.unactiveIconColor,
  });

  final Decoration? decoration;
  final Color? unactiveIconColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Language>(
      buildWhen: (previous, current) => previous.value != current.value,
      builder: (context, language) => IconButton(
        key: KWidgetkeys.widget.languageSwitcher.widget,
        style: KButtonStyles.withoutStyle,
        onPressed: () => context.read<LanguageCubit>().languageChanged(),
        icon: DecoratedBox(
          decoration: decoration ?? KWidgetTheme.boxDecorationWhiteMain,
          child: Row(
            // key: KWidgetkeys.widget.languageSwitcher.item,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              Language.values.length,
              (index) => _buildLanguageOption(
                languageName: Language.values.elementAt(index).text,
                isSelected: Language.values.elementAt(index) == language,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required String languageName,
    required bool isSelected,
  }) =>
      Container(
        constraints: const BoxConstraints(
          minWidth: KSize.kPixel40,
          minHeight: KSize.kPixel40,
        ),
        decoration: isSelected
            ? KWidgetTheme.boxDecorationBlackCircular
            : unactiveIconColor == null
                ? KWidgetTheme.boxDecorationGrayCircular
                : KWidgetTheme.boxDecorationGrayCircular
                    .copyWith(color: unactiveIconColor),
        margin: const EdgeInsets.all(KPadding.kPaddingSize4),
        padding: const EdgeInsets.all(
          KPadding.kPaddingSize8,
        ),
        child: Text(
          languageName,
          key: KWidgetkeys.widget.languageSwitcher.text,
          style: isSelected
              ? AppTextStyle.materialThemeTitleMediumNeutral
              : AppTextStyle.materialThemeTitleMedium,
          textAlign: TextAlign.center,
        ),
      );
}
