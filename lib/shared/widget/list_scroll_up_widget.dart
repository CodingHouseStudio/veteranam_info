import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ListScrollUpWidget extends StatelessWidget {
  const ListScrollUpWidget({required this.scrollController, super.key});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            context.l10n.thatEndOfList,
            key: KWidgetkeys.widget.scaffold.endListText,
            style: AppTextStyle.materialThemeTitleMediumNeutralVariant70,
          ),
        ),
        KSizedBox.kHeightSizedBox24,
        Center(
          child: TextButton(
            key: KWidgetkeys.widget.scaffold.endListButton,
            style: KButtonStyles.endListButtonStyle,
            onPressed: () => scrollController.animateTo(
              0,
              duration: Duration(
                milliseconds: (scrollController.offset / 10).toInt(),
              ),
              curve: Curves.linear,
            ),
            child: Text(
              context.l10n.returnToTop,
              style: AppTextStyle.materialThemeTitleMedium,
            ),
          ),
        ),
      ],
    );
  }
}