import 'package:flutter/widgets.dart';
import 'package:veteranam/components/home/home.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class HomeSectionsWidget extends StatelessWidget {
  const HomeSectionsWidget({
    required this.isDesk,
    required this.isTablet,
    super.key,
  });
  final bool isDesk;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final main = [
      KSizedBox.kHeightSizedBox24,
      BoxWidgetList(
        isDesk: isDesk,
        isTablet: isTablet,
      ),
      Text(
        context.l10n.aboutProject,
        key: HomeKeys.aboutProjecSubtitle,
        style: isDesk
            ? AppTextStyle.materialThemeDisplayMedium
            : isTablet
                ? AppTextStyle.materialThemeDisplaySmall
                : AppTextStyle.materialThemeHeadlineSmall,
      ),
      if (isDesk)
        KSizedBox.kHeightSizedBox100
      else if (isTablet)
        KSizedBox.kHeightSizedBox80
      else
        KSizedBox.kHeightSizedBox64,
      DiscountSection(
        isDesk: isDesk,
        isTablet: isTablet,
      ),
      if (Config.isDevelopment) ...[
        if (isTablet)
          KSizedBox.kHeightSizedBox160
        else
          KSizedBox.kHeightSizedBox40,
        InformationSection(
          isDesk: isDesk,
          isTablet: isTablet,
        ),
      ],
      if (isDesk || isTablet)
        KSizedBox.kHeightSizedBox132
      else
        KSizedBox.kHeightSizedBox40,
    ];
    return SliverList.builder(
      itemBuilder: (context, index) => main.elementAt(index),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: main.length,
    );
  }
}
