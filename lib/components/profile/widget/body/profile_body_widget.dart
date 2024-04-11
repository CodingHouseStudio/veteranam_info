import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.myProfile,
                  style: AppTextStyle.text40,
                ),
                Text(
                  context.l10n.profileDetails,
                  style: AppTextStyle.text16,
                ),
                KSizedBox.kHeightSizedBox30,
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize16,
                  ),
                  child: ProfileCardWidget(
                    key: KWidgetkeys.widget.profileCard.profileCard,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize16,
                  ),
                  child: Column(
                    children: [
                      BoxWidget(
                        text: context.l10n.saved,
                        isDesk: true,
                        onIconTap: () {},
                      ),
                      KSizedBox.kHeightSizedBox30,
                      BoxWidget(
                        text: context.l10n.myStory,
                        isDesk: true,
                        onIconTap: () {},
                      ),
                      KSizedBox.kHeightSizedBox90,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
