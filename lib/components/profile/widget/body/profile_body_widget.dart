import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesk =
            KPlatformConstants.changeToDescWidget(constraints.maxWidth);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize16,
                ),
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
              if (isDesk)
                _buildDesktopLayout(context, isDesk)
              else
                _buildMobileLayout(context, isDesk),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isDesk) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize16),
            child: ProfileCardWidget(
              key: KWidgetkeys.widget.profileCard.profileCard,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize16),
            child: _buildBoxWidgets(context, isDesk),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isDesk) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBoxWidgets(context, isDesk),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize16),
          child: ProfileCardWidget(
            key: KWidgetkeys.widget.profileCard.profileCard,
          ),
        ),
        KSizedBox.kHeightSizedBox24,
        ButtonWidget(
          text: context.l10n.logOut,
          onPressed: () {},
          isDesk: isDesk,
        ),
        if (isDesk) KSizedBox.kWidthSizedBox24 else KSizedBox.kHeightSizedBox24,
        ButtonWidget(
          text: context.l10n.deleteAccount,
          onPressed: () {},
          isDesk: isDesk,
          backgroundColor: AppColors.transparent,
        ),
        KSizedBox.kHeightSizedBox24,
      ],
    );
  }

  Widget _buildBoxWidgets(BuildContext context, bool isDesk) {
    return Column(
      children: [
        BoxWidget(
          text: context.l10n.saved,
          isDesk: isDesk,
          onTap: () {},
        ),
        KSizedBox.kHeightSizedBox30,
        BoxWidget(
          text: context.l10n.myStory,
          isDesk: isDesk,
          onTap: () {},
        ),
        KSizedBox.kHeightSizedBox30,
      ],
    );
  }
}
