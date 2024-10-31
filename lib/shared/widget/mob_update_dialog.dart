import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MobUpdateDialog extends StatelessWidget {
  const MobUpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: KWidgetkeys.widget.mobUpdate.dialog,
      children: [
        Text(
          context.l10n.appUpdateAvailable,
          key: KWidgetkeys.widget.mobUpdate.title,
          style: AppTextStyle.materialThemeTitleMediumNeutral,
        ),
        KSizedBox.kHeightSizedBox8,
        Text(
          context.l10n.appUpdateAvailableDescription,
          key: KWidgetkeys.widget.mobUpdate.description,
          style: AppTextStyle.materialThemeBodyMediumNeutral,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              key: KWidgetkeys.widget.mobUpdate.lateButton,
              onPressed: () => context.pop(),
              child: Text(
                context.l10n.later,
                style: AppTextStyle.materialThemeTitleMediumNeutral,
              ),
            ),
            KSizedBox.kWidthSizedBox8,
            TextButton(
              key: KWidgetkeys.widget.mobUpdate.updateButton,
              onPressed: () {
                context.read<UrlCubit>().launchUrl(
                      url: PlatformEnum.getPlatform.isAndroid
                          ? KAppText.androidInstallUrl
                          : KAppText.iphoneInstallUrl,
                    );
                context.pop();
              },
              style: KButtonStyles.whiteButtonStyle,
              child: Text(
                context.l10n.update,
                style: AppTextStyle.materialThemeTitleMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
