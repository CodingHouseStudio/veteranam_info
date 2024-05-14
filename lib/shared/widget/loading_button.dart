import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    required this.isDesk,
    required this.onPressed,
    required this.iconKey,
    super.key,
  });
  final bool isDesk;
  final void Function()? onPressed;
  final Key iconKey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonWidget(
        text: context.l10n.moreStories,
        onPressed: onPressed,
        icon: isDesk
            ? KIcon.refresh.setIconKey(
                iconKey,
              )
            : null,
        isDesk: isDesk,
        iconRightMerge: KSizedBox.kWidthSizedBox8,
      ),
    );
  }
}
