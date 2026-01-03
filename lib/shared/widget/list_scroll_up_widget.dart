import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ListScrollUpWidget extends StatelessWidget {
  const ListScrollUpWidget({required this.scrollController, super.key});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: KPadding.kPaddingSize24,
      children: [
        Center(
          child: Text(
            context.l10n.thatEndOfList,
            key: ScaffoldKeys.endListText,
            style: AppTextStyle.materialThemeTitleMediumNeutralVariant70,
          ),
        ),
        Center(
          child: TextButton(
            key: ScaffoldKeys.endListButton,
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
