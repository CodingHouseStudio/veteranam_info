import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ProfileCardWidget extends StatefulWidget {
  const ProfileCardWidget({super.key});

  @override
  ProfileCardWidgetState createState() => ProfileCardWidgetState();
}

class ProfileCardWidgetState extends State<ProfileCardWidget> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize16),
        child: Container(
          decoration: KWidetTheme.boxDecorPrimary,
          child: Padding(
            padding: const EdgeInsets.all(KPadding.kPaddingSize20),
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
                        const SwitchWidget(),
                        KSizedBox.kWidthSizedBox8,
                        Text(context.l10n.beAnonymous),
                      ],
                    ),
                    const Text(
                      KMockText.description,
                      style: AppTextStyle.hint14,
                    ),
                    if (isEditing) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: ElevatedButton(
                            style: KButtonStyles.lightGrayButtonStyle,
                            onPressed: () {
                              setState(() {
                                isEditing = !isEditing;
                              });
                            },
                            child: Text(
                              context.l10n.saveChanges,
                              style: AppTextStyle.text24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
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
        Flexible(
          child: isEditing
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.editData,
                      style: AppTextStyle.text40,
                      overflow: TextOverflow.ellipsis,
                    ),
                    KSizedBox.kHeightSizedBox8,
                    Text(
                      context.l10n.name,
                      style: AppTextStyle.text24,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: KBorder.buttonStyleOutlineInputBorder,
                        labelText: context.l10n.writeYouName,
                        labelStyle: AppTextStyle.hint24,
                      ),
                      onChanged: (value) {},
                    ),
                    KSizedBox.kHeightSizedBox8,
                    Text(
                      context.l10n.lastName,
                      style: AppTextStyle.text24,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: KBorder.buttonStyleOutlineInputBorder,
                        labelText: context.l10n.writeYouLastName,
                        labelStyle: AppTextStyle.hint24,
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        KMockText.userName,
                        style: AppTextStyle.text40,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    KSizedBox.kWidthSizedBox3,
                    GestureDetector(
                      child: KIcon.edit,
                      onTap: () {
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                    ),
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
                labelText: KMockText.email,
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
                labelText: KMockText.nickname,
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
