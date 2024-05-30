import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    required this.isDesk,
    required this.onPressed,
    required this.iconKey,
    required this.text,
    super.key,
  });
  final bool isDesk;
  final void Function()? onPressed;
  final Key iconKey;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonWidget(
        text: text,
        onPressed: onPressed,
        icon: isDesk
            ? KIcon.refresh.copyWith(
                key: iconKey,
              )
            : null,
        isDesk: isDesk,
        iconRightMerge: KSizedBox.kWidthSizedBox8,
      ),
    );
  }
}
