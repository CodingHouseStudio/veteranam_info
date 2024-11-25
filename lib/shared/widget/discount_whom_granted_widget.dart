import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class Eligibility extends StatelessWidget {
  const Eligibility({
    required this.text,
    super.key,
  });

  final List<String> text;

  @override
  Widget build(BuildContext context) {
    if (text.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(
          top: KPadding.kPaddingSize4,
          right: KPadding.kPaddingSize8,
        ),
        child: EligibilityExpanded(
          key: ValueKey(text),
          text: text,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class EligibilityExpanded extends StatefulWidget {
  const EligibilityExpanded({
    required this.text,
    super.key,
  });

  final List<String> text;

  @override
  State<EligibilityExpanded> createState() => _EligibilityExpandedState();
}

class _EligibilityExpandedState extends State<EligibilityExpanded> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final displayedText = isExpanded
        ? widget.text
        : widget.text.length > 5
            ? widget.text.take(5).toList()
            : widget.text;
    return RichText(
      key: isExpanded
          ? KWidgetkeys.widget.cityList.longText
          : KWidgetkeys.widget.cityList.markdownFulllList,
      text: TextSpan(
        style: AppTextStyle.materialThemeLabelLarge,
        children: [
          ..._buildTextSpans(displayedText),
          if (widget.text.length > 5 && !isExpanded) ...[
            TextSpan(
              text: ' ${context.l10n.moreWhomGranted(widget.text.length - 5)}',
              style: AppTextStyle.materialThemeLabelLargeRef,
              recognizer: _textSpanEvent,
            ),
          ],
          if (isExpanded)
            TextSpan(
              text: ' ${context.l10n.hideExpansion}',
              style: AppTextStyle.materialThemeLabelLargeRef,
              recognizer: _textSpanEvent,
            ),
        ],
      ),
    );
  }

  List<InlineSpan> _buildTextSpans(List<String> textList) {
    final textSpans = <InlineSpan>[];

    for (final text in textList) {
      textSpans.add(
        WidgetSpan(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getIconWidget(text),
              KSizedBox.kWidthSizedBox4,
              _getLabelWidget(text),
              KSizedBox.kWidthSizedBox8,
            ],
          ),
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

  Widget _getLabelWidget(String text) {
    switch (text) {
      case 'Ветерани':
        return const Text(
          'Ветерани',
          style: AppTextStyle.materialThemeLabelMedium,
        );
      case 'Військовослужбовці':
      case 'Військовослужбовці ЗСУ':
        return const Text(
          'Військовослужбовці',
          style: AppTextStyle.materialThemeLabelMedium,
        );
      case 'Учасники бойових дій':
        return const Text(
          'УБД',
          style: AppTextStyle.materialThemeLabelMedium,
        );
      case 'Особи з інвалідністю внаслідок війни':
        return const Text(
          'Особи з інвалідністю',
          style: AppTextStyle.materialThemeLabelMedium,
        );
      case 'Члени сімей загиблих':
        return const Text(
          'ЧСЗ',
          style: AppTextStyle.materialThemeLabelMedium,
        );
      case 'Співробітники ДСНС':
        return const Text(
          'ДСНС',
          style: AppTextStyle.materialThemeLabelMedium,
        );
      case 'Поліція':
        return const Text(
          'Поліція',
          style: AppTextStyle.materialThemeLabelMedium,
        );
      case 'Внутрішньо переміщені особи':
      case 'ВПО':
        return const Text(
          'Військовослужбовці',
          style: AppTextStyle.materialThemeLabelMedium,
        );
      default:
        return Text(
          text,
          style: AppTextStyle.materialThemeLabelMedium,
        );
    }
  }

  GestureRecognizer get _textSpanEvent =>
      TapGestureRecognizer()..onTap = _toggleExpanded;

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}
