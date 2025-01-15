import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MobUpdateDialog extends StatelessWidget {
  const MobUpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: MobUpdateKeys.dialog,
      children: [
        Text(
          context.l10n.appUpdateAvailable,
          key: MobUpdateKeys.title,
          style: AppTextStyle.materialThemeTitleMediumNeutral,
        ),
        KSizedBox.kHeightSizedBox8,
        Text(
          context.l10n.appUpdateAvailableDescription,
          key: MobUpdateKeys.description,
          style: AppTextStyle.materialThemeBodyMediumNeutral,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: KPadding.kPaddingSize8,
          children: [
            TextButton(
              key: MobUpdateKeys.lateButton,
              onPressed: () => context.pop(),
              child: Text(
                context.l10n.later,
                style: AppTextStyle.materialThemeTitleMediumNeutral,
              ),
            ),
            TextButton(
              key: MobUpdateKeys.updateButton,
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
