import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class WorkCardWidget extends StatefulWidget {
  const WorkCardWidget({
    required this.workModel,
    required this.isDesk,
    this.firstItemIsFirst = false,
    super.key,
  });
  final WorkModel workModel;
  final bool isDesk;
  final bool firstItemIsFirst;

  @override
  State<WorkCardWidget> createState() => _WorkCardWidgetState();
}

class _WorkCardWidgetState extends State<WorkCardWidget> {
  late GlobalKey scrollKey;
  @override
  void initState() {
    scrollKey = GlobalKey();
    if (widget.firstItemIsFirst) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(scrollKey.currentContext!);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: scrollKey,
      decoration: KWidgetTheme.boxDecorationWidget,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              widget.isDesk ? KPadding.kPaddingSize48 : KPadding.kPaddingSize16,
          vertical: KPadding.kPaddingSize16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.workModel.title,
              key: KWidgetkeys.widget.workCard.title,
              style: AppTextStyle.text40,
            ),
            Text(
              widget.workModel.price,
              key: KWidgetkeys.widget.workCard.price,
              style: AppTextStyle.text40,
            ),
            Text(
              widget.workModel.city ?? '',
              key: KWidgetkeys.widget.workCard.city,
              style: AppTextStyle.text20.copyWith(
                color: AppColors.lightGray,
              ),
            ),
            Text(
              widget.workModel.companyName,
              key: KWidgetkeys.widget.workCard.employer,
              style: AppTextStyle.text20.copyWith(
                color: AppColors.lightGray,
              ),
            ),
            KSizedBox.kHeightSizedBox16,
            CardTextDetailWidget(
              text: widget.workModel.description,
              maxLines: 3,
              icon: Row(
                children: [
                  KIcon.share.setIconKey(KWidgetkeys.widget.workCard.iconShare),
                  KSizedBox.kWidthSizedBox16,
                  KIcon.safe.setIconKey(KWidgetkeys.widget.workCard.iconSafe),
                ],
              ),
            ),
            KSizedBox.kHeightSizedBox16,
            ButtonWidget(
              key: KWidgetkeys.widget.workCard.button,
              onPressed: () {},
              text: context.l10n.respond,
              isDesk: widget.isDesk,
            ),
          ],
        ),
      ),
    );
  }
}
