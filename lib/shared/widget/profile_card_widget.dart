import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: KWidetTheme.boxDecorPrimary,
        child: Padding(
          padding: const EdgeInsets.all(KPadding.kPaddingSize10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              KSizedBox.kHeightSizedBox30,
              _buildProfileInfo(),
              KSizedBox.kHeightSizedBox8,
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SwitchWidget(),
                      KSizedBox.kWidthSizedBox8,
                      Text(KAppText.anonymous),
                    ],
                  ),
                  Text(
                    KAppText.description,
                    style: AppTextStyle.hint14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: KBorderRadius.kBorderRadiusL,
            color: AppColors.widgetBackground,
          ),
          child: const Center(
            child: KIcon.person,
          ),
        ),
        KSizedBox.kWidthSizedBox30,
        const Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  KAppText.userName,
                  style: AppTextStyle.text40,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              KSizedBox.kWidthSizedBox3,
              KIcon.edit,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'E-mail:',
              style: AppTextStyle.text24,
            ),
            TextField(
              decoration: InputDecoration(
                border: KBorder.buttonStyleOutlineInputBorder,
                labelText: KAppText.email,
                labelStyle: AppTextStyle.hint24,
              ),
              onChanged: (value) {},
            ),
          ],
        ),
        KSizedBox.kHeightSizedBox8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nickname:',
              style: AppTextStyle.text24,
            ),
            TextField(
              decoration: InputDecoration(
                border: KBorder.buttonStyleOutlineInputBorder,
                labelText: KAppText.nickname,
                labelStyle: AppTextStyle.hint24,
              ),
              onChanged: (value) {},
            ),
          ],
        ),
      ],
    );
  }
}
