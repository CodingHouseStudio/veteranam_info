import 'package:flutter/material.dart';
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
              KSizedBox.kHeightSizedBoxM,
              _buildProfileInfo(),
              KSizedBox.kHeightSizedBoxS,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Switch(
                        activeColor: AppColors.error,
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
                    style: AppTextStyle.lableSmallGrey,
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
        KSizedBox.kWidthSizedBoxM,
        const Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  KAppText.userName,
                  style: AppTextStyle.lableL,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              KSizedBox.kWidthSizedBoxXS,
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
              style: AppTextStyle.lableM,
            ),
            TextField(
              decoration: InputDecoration(
                border: KBorder.buttonStyleOutlineInputBorder,
                labelText: KAppText.email,
                labelStyle: AppTextStyle.lableMediumSmallGrey,
              ),
              onChanged: (value) {},
            ),
          ],
        ),
        KSizedBox.kHeightSizedBoxS,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nickname:',
              style: AppTextStyle.lableM,
            ),
            TextField(
              decoration: InputDecoration(
                border: KBorder.buttonStyleOutlineInputBorder,
                labelText: KAppText.nickname,
                labelStyle: AppTextStyle.lableMediumSmallGrey,
              ),
              onChanged: (value) {},
            ),
          ],
        ),
      ],
    );
  }
}
