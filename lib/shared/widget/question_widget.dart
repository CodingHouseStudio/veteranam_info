import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({super.key});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late bool openQuestion;
  @override
  void initState() {
    openQuestion = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadiusM,
        border: Border.all(color: KColorTheme.widgetBackground),
      ),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          key: KWidgetkeys.questionKeys.widget,
          title: Text(
            'Як мені знайти роботу за допомогою цього сайту?',
            key: KWidgetkeys.questionKeys.title,
            style: KAppTextStyle.lableLarge,
            maxLines: 1,
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              openQuestion = expanded;
            });
          },
          trailing: IconWidget(
            icon: openQuestion ? KIcon.minus : KIcon.plus,
            background: KColorTheme.widgetBackground,
            padding: KPadding.kPaddingSizeM,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSizeML,
                vertical: KPadding.kPaddingSizeSM,
              ),
              child: Text(
                // ignore: lines_longer_than_80_chars
                'Використовуйте веб-сайти спеціалізованих сервісів для пошуку роботи, таких як Indeed, LinkedIn, Glassdoor, Monster, або регіональні ресурси. Виберіть свою область інтересів та регіон, і шукайте вакансії, які відповідають вашим критеріям.',
                key: KWidgetkeys.questionKeys.subtitle,
                style: KAppTextStyle.lableMedium,
                softWrap: true,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
