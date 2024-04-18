import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ProfileCardWidget extends StatefulWidget {
  const ProfileCardWidget({
    required this.isDesk,
    super.key,
  });

  @override
  ProfileCardWidgetState createState() => ProfileCardWidgetState();
  final bool isDesk;
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: KBorderRadius.kBorderRadiusL,
                        color: AppColors.widgetBackground,
                      ),
                      child: const Center(
                        child: KIcon.person,
                      ),
                    ),
                    KSizedBox.kWidthSizedBox16,
                    Expanded(
                      child: isEditing
                          ? Text(
                              context.l10n.editData,
                              style: AppTextStyle.text40,
                            )
                          : _displayProfileName(),
                    ),
                  ],
                ),
                if (isEditing) ...[
                  KSizedBox.kHeightSizedBox8,
                  _textField(context.l10n.name, context.l10n.writeYouName),
                  KSizedBox.kHeightSizedBox8,
                  _textField(
                    context.l10n.lastName,
                    context.l10n.writeYouLastName,
                  ),
                ],
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

  Widget _textField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.text24),
        TextFieldWidget(
          onChanged: (value) {},
          widgetKey: KWidgetkeys.widget.profileCardWidget.textFiled,
          hintText: hint,
          hintStyle: widget.isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
          fillColor: AppColors.transparent,
          contentPadding: const EdgeInsets.all(KPadding.kPaddingSize16),
          isDesk: widget.isDesk,
        ),
      ],
    );
  }

  Widget _displayProfileName() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KSizedBox.kWidthSizedBox24,
        const Flexible(
          flex: 2,
          child: Text(
            KMockText.userName,
            style: AppTextStyle.text40,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => setState(() => isEditing = !isEditing),
          child: KIcon.edit,
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
        KSizedBox.kHeightSizedBox24,
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
