import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/home/home.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FAQSectionWidget extends StatelessWidget {
  const FAQSectionWidget({
    required this.isDesk,
    required this.isTablet,
    super.key,
  });
  final bool isDesk;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _GetFAQSection(
              isDesk: true,
            ),
          ),
          Expanded(
            flex: 3,
            child: QuestionWidgetList(
              isDesk: true,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          const _GetFAQSection(
            isDesk: false,
          ),
          if (isTablet)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
          const QuestionWidgetList(
            isDesk: false,
          ),
        ],
      );
    }
  }
}

class _GetFAQSection extends StatelessWidget {
  const _GetFAQSection({
    required this.isDesk,
  });

  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.l10n.answersYourQuestions,
          key: KWidgetkeys.screen.home.faqTitle,
          style: isDesk
              ? AppTextStyle.materialThemeDisplayLarge
              : AppTextStyle.materialThemeDisplaySmall,
        ),
        if (isDesk) KSizedBox.kHeightSizedBox16 else KSizedBox.kHeightSizedBox8,
        Text(
          context.l10n.questionSubtitle,
          key: KWidgetkeys.screen.home.faqSubtitle,
          style: isDesk
              ? AppTextStyle.materialThemeBodyLarge
              : AppTextStyle.materialThemeBodyMedium,
        ),
        KSizedBox.kHeightSizedBox16,
        DoubleButtonWidget(
          widgetKey: KWidgetkeys.screen.home.faqButton,
          text: context.l10n.writeMessage,
          onPressed: () => context.goNamed(KRoute.feedback.name),
          isDesk: isDesk,
        ),
      ],
    );
  }
}
