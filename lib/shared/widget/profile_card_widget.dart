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
        key: KWidgetkeys.widget.profileCard.profileCard,
        child: Container(
          decoration: KWidetTheme.boxDecorPrimary,
          child: Padding(
            padding: const EdgeInsets.all(KPadding.kPaddingSize20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(),
                if (isEditing)
                  _editProfileNameAndLastName()
                else
                  _displayProfileName(),
                KSizedBox.kHeightSizedBox8,
                _buildProfileInfo(),
                KSizedBox.kHeightSizedBox8,
                _buildProfileFooter(),
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
      ],
    );
  }

  Widget _editProfileNameAndLastName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.editData, style: AppTextStyle.text40),
        KSizedBox.kHeightSizedBox8,
        _textField(context.l10n.name, context.l10n.writeYouName),
        KSizedBox.kHeightSizedBox8,
        _textField(context.l10n.lastName, context.l10n.writeYouLastName),
      ],
    );
  }

  Widget _displayProfileName() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            KMockText.userName,
            style: AppTextStyle.text40,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => isEditing = !isEditing),
          child: KIcon.edit,
        ),
      ],
    );
  }

  Widget _textField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.text24),
        TextField(
          decoration: InputDecoration(
            border: KBorder.buttonStyleOutlineInputBorder,
            labelText: hint,
            labelStyle: AppTextStyle.hint24,
          ),
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textField(context.l10n.email, KMockText.email),
        KSizedBox.kHeightSizedBox8,
        _textField(context.l10n.nickname, KMockText.nickname),
      ],
    );
  }

  Widget _buildProfileFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SwitchWidget(),
            KSizedBox.kHeightSizedBox8,
            Expanded(child: Text(context.l10n.beAnonymous)),
          ],
        ),
        Text(context.l10n.beAnonymousDetails, style: AppTextStyle.hint14),
        if (isEditing)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Center(
              child: ElevatedButton(
                style: KButtonStyles.lightGrayButtonStyle,
                onPressed: () => setState(() => isEditing = !isEditing),
                child:
                    Text(context.l10n.saveChanges, style: AppTextStyle.text24),
              ),
            ),
          ),
      ],
    );
  }
}
