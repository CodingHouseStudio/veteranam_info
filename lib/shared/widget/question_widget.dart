import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    required this.isDesk,
    required this.questionModel,
    super.key,
  });
  final QuestionModel questionModel;
  final bool isDesk;

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
      key: KWidgetkeys.widget.question.widget,
      decoration: KWidgetTheme.boxDecorationWidget,
      clipBehavior: Clip.hardEdge,
      child: Material(
        type: MaterialType.transparency,
        child: ExpansionTile(
          shape: const Border.fromBorderSide(
            BorderSide(
              color: AppColors.materialThemeKeyColorsNeutral,
              width: 0,
            ),
          ),
          title: Text(
            widget.questionModel.title.getTrnslation(
              en: widget.questionModel.titleEN,
              context: context,
            ),
            key: KWidgetkeys.widget.question.title,
            style: widget.isDesk
                ? AppTextStyle.materialThemeHeadlineSmall
                : AppTextStyle.materialThemeTitleLarge,
          ),
          onExpansionChanged: (value) => setState(() {
            openQuestion = value;
          }),
          trailing: IconWidget(
            icon: openQuestion
                ? KIcon.minus.copyWith(
                    key: KWidgetkeys.widget.question.iconMinus,
                  )
                : KIcon.plus.copyWith(
                    key: KWidgetkeys.widget.question.iconPlus,
                  ),
            padding: KPadding.kPaddingSize12,
            background: AppColors.materialThemeWhite,
          ),
          tilePadding: EdgeInsets.symmetric(
            horizontal: widget.isDesk
                ? KPadding.kPaddingSize32
                : KPadding.kPaddingSize16,
            vertical: KPadding.kPaddingSize16,
          ).copyWith(
            bottom: KPadding.kPaddingSize16,
            right: widget.isDesk
                ? KPadding.kPaddingSize16
                : KPadding.kPaddingSize8,
          ),
          childrenPadding: EdgeInsets.only(
            right: widget.isDesk
                ? KPadding.kPaddingSize16
                : KPadding.kPaddingSize4,
            left: widget.isDesk
                ? KPadding.kPaddingSize32
                : KPadding.kPaddingSize16,
            bottom: KPadding.kPaddingSize16,
          ),
          children: [
            MarkdownLinkWidget(
              key: KWidgetkeys.widget.question.subtitle,
              text: widget.questionModel.subtitle.getTrnslation(
                en: widget.questionModel.subtitleEN,
                context: context,
              ),
              textStyle: widget.isDesk
                  ? AppTextStyle.materialThemeBodyLarge
                  : AppTextStyle.materialThemeBodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
