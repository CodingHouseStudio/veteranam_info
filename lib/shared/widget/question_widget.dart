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
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: KBorderRadius.kBorderRadiusM,
            border: Border.all(color: KColorTheme.widgetBackground),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSizeML,
              vertical: KPadding.kPaddingSizeSM,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Як мені знайти роботу за допомогою цього сайту?',
                        key: KWidgetkeys.questionKeys.title,
                        style: KAppTextStyle.lableLarge,
                      ),
                      if (openQuestion)
                        Column(
                          children: [
                            KSizedBox.kHeightSizedBoxM,
                            Text(
                              // ignore: lines_longer_than_80_chars
                              'Використовуйте веб-сайти спеціалізованих сервісів для пошуку роботи, таких як Indeed, LinkedIn, Glassdoor, Monster, або регіональні ресурси. Виберіть свою область інтересів та регіон, і шукайте вакансії, які відповідають вашим критеріям.',
                              key: KWidgetkeys.questionKeys.subtitle,
                              style: KAppTextStyle.lableMedium,
                              softWrap: true,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => setState(() {
                    openQuestion = !openQuestion;
                  }),
                  child: IconWidget(
                    key: KWidgetkeys.questionKeys.icon,
                    icon: openQuestion ? KIcon.minus : KIcon.plus,
                    background: KColorTheme.widgetBackground,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
