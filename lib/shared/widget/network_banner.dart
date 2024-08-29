import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class NetworkStatusBanner extends StatelessWidget {
  const NetworkStatusBanner({
    required this.offline,
    required this.slow,
    super.key,
  });

  final bool offline;
  final bool slow;

  @override
  Widget build(BuildContext context) {
    if (!offline && !slow) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(KPadding.kPaddingSize10),
      color: offline ? Colors.redAccent : Colors.orange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KIcon.noInternet,
          KSizedBox.kWidthSizedBox10,
          Flexible(
            child: Text(
              offline ? context.l10n.noInternet : context.l10n.slowInternet,
              style: AppTextStyle.materialThemeTitleSmallNeutral,
            ),
          ),
        ],
      ),
    );
  }
}
