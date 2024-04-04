import 'package:flutter/material.dart';
import 'package:kozak/l10n/l10n.dart';
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
          padding: const EdgeInsets.all(KPadding.kPaddingSize10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              KSizedBox.kHeightSizedBox30,
              _buildProfileInfo(),
              KSizedBox.kHeightSizedBox8,
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
                      KSizedBox.kWidthSizedBox8,
                      Text(context.l10n.beAnonymous),
                    ],
                  ),
                  const Text(
                    KMockText.description,
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
                  KMockText.userName,
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
                labelText: context.l10n.email,
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
                labelText: context.l10n.nickname,
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
