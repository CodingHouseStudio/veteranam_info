import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    required this.pathName,
    required this.backPageName,
    super.key,
  });
  final String pathName;
  final String? backPageName;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        children: [
          IconButtonWidget(
            icon: KIcon.arrowBack,
            padding: KPadding.kPaddingSize8,
            background: AppColors.materialThemeKeyColorsPrimary,
            onPressed: () => context.goNamed(pathName),
          ),
          KSizedBox.kWidthSizedBox8,
          Text(
            '${context.l10n.back}${pageName(context)}',
            style: AppTextStyle.materialThemeTitleMedium,
          ),
        ],
      ),
    );
  }

  String pageName(BuildContext context) =>
      backPageName != null ? ' ${context.l10n.to} $backPageName' : '';
}
