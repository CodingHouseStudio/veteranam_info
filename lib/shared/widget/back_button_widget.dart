import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    required this.pathName,
    required this.backPageName,
    this.buttonKey,
    this.textKey,
    super.key,
  });
  final String pathName;
  final String? backPageName;
  final Key? buttonKey;
  final Key? textKey;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        children: [
          IconButtonWidget(
            key: buttonKey,
            icon: KIcon.arrowBack,
            padding: KPadding.kPaddingSize8,
            background: AppColors.materialThemeKeyColorsPrimary,
            onPressed: () => context.goNamed(pathName),
          ),
          KSizedBox.kWidthSizedBox8,
          Text(
            '${context.l10n.back}${pageName(context)}',
            key: textKey,
            style: AppTextStyle.materialThemeTitleMedium,
          ),
        ],
      ),
    );
  }

  String pageName(BuildContext context) =>
      backPageName != null ? ' ${context.l10n.to} $backPageName' : '';
}
