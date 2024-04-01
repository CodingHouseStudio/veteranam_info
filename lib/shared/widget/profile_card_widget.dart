import 'package:flutter/material.dart';
import 'package:kozak/shared/constants/constants.dart';
import 'package:kozak/shared/shared.dart';

class ProfileCardWidget extends StatefulWidget {
  const ProfileCardWidget({super.key});

  @override
  State<ProfileCardWidget> createState() => _ProfileCardWidgetState();
}

class _ProfileCardWidgetState extends State<ProfileCardWidget> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: KBoxDecoration.boxDecorPrimary,
        child: Padding(
          padding: const EdgeInsets.all(KPadding.kPaddingSizeS),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              KSizedBox.kHeightSizedBoxS,
              _buildProfileInfo(),
              KSizedBox.kHeightSizedBoxS,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Switch(
                        activeColor: KColorTheme.error,
                        value: _value,
                        onChanged: (newValue) {
                          setState(() {
                            _value = newValue;
                          });
                        },
                      ),
                      KSizedBox.kWidthSizedBoxS,
                      const Text(KAppText.anonymous),
                    ],
                  ),
                  const Text(
                    KAppText.description,
                    style: KAppTextStyle.lableSmallGrey,
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
            color: KColorTheme.widgetBackground,
          ),
          child: const Center(
            child: KIcon.person,
          ),
        ),
        KSizedBox.kWidthSizedBoxS,
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              KAppText.userName,
              style: KAppTextStyle.lableMediumSmall,
            ),
            KSizedBox.kWidthSizedBoxXS,
            KIcon.edit,
          ],
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
              style: KAppTextStyle.lableMedium,
            ),
            TextButton(
              key: KWidgetkeys.searchKeys.button,
              style: KButtonStyles.backgroundButtonStyleUI,
              onPressed: null,
              child: const Text(
                KAppText.email,
                style: KAppTextStyle.lableMediumSmallGrey,
              ),
            ),
          ],
        ),
        KSizedBox.kHeightSizedBoxS,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nickname:',
              style: KAppTextStyle.lableMedium,
            ),
            TextButton(
              key: KWidgetkeys.searchKeys.button,
              style: KButtonStyles.backgroundButtonStyleUI,
              onPressed: null,
              child: const Text(
                KAppText.nickname,
                style: KAppTextStyle.lableMediumSmallGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
