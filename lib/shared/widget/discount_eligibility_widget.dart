import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountEligibilityWidget extends StatelessWidget {
  const DiscountEligibilityWidget({
    required this.text,
    super.key,
  });

  final List<TranslateModel> text;

  @override
  Widget build(BuildContext context) {
    if (text.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(
          top: KPadding.kPaddingSize4,
          right: KPadding.kPaddingSize8,
        ),
        child: DiscountEligibilityExpandedWidget(
          key: ValueKey(text),
          text: text.getTrsnslation(context),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class DiscountEligibilityExpandedWidget extends StatelessWidget {
  const DiscountEligibilityExpandedWidget({
    required this.text,
    super.key,
  });

  final List<String> text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      key: KWidgetkeys.widget.cityList.markdownFulllList,
      text: TextSpan(
        style: AppTextStyle.materialThemeLabelLarge,
        children: [
          ..._buildTextSpans(
            text.length > 5 ? text.take(5).toList() : text,
            context,
          ),
        ],
      ),
    );
  }

  List<InlineSpan> _buildTextSpans(
    List<String> textList,
    BuildContext context,
  ) {
    final textSpans = <InlineSpan>[];

    for (final text in textList) {
      textSpans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getIconWidget(text),
              KSizedBox.kWidthSizedBox4,
              Text(
                _getLabelWidget(text),
                style: AppTextStyle.materialThemeLabelMedium,
              ),
              KSizedBox.kWidthSizedBox8,
            ],
          ),
        ),
      );
    }

    if (text.length > 5) {
      textSpans.add(
        TextSpan(
          text: ' ${context.l10n.moreWhomGranted(text.length - 5)}',
          style: AppTextStyle.materialThemeLabelLargeRef,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              //context.goNamed();
            },
        ),
      );
    }

    return textSpans;
  }

  Widget _getIconWidget(String text) {
    switch (text) {
      case 'Ветерани':
        return KIcon.veteransIcon;
      case 'Військовослужбовці':
      case 'Військовослужбовці ЗСУ':
        return KIcon.military;
      case 'Учасники бойових дій':
        return KIcon.ubd;
      case 'Особи з інвалідністю внаслідок війни':
        return KIcon.personsWithDisabilities;
      case 'Члени сімей загиблих':
        return KIcon.familyMembers;
      case 'Співробітники ДСНС':
        return KIcon.dsns;
      case 'Поліція':
        return KIcon.police;
      case 'Внутрішньо переміщені особи':
      case 'ВПО':
        return KIcon.military;
      default:
        return const SizedBox.shrink();
    }
  }

  String _getLabelWidget(String text) {
    switch (text) {
      case 'Ветерани':
        return 'Ветерани';
      case 'Військовослужбовці':
      case 'Військовослужбовці ЗСУ':
        return 'Військовослужбовці';
      case 'Учасники бойових дій':
        return 'УБД';
      case 'Особи з інвалідністю внаслідок війни':
        return 'Особи з інвалідністю';
      case 'Члени сімей загиблих':
        return 'ЧСЗ';
      case 'Співробітники ДСНС':
        return 'ДСНС';
      case 'Поліція':
        return 'Поліція';
      case 'Внутрішньо переміщені особи':
      case 'ВПО':
        return 'Військовослужбовці';
      default:
        return text;
    }
  }
}
