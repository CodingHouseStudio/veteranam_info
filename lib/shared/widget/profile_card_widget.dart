import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared.dart';

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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(
            widget.isDesk ? KPadding.kPaddingSize4 : KPadding.kPaddingSize8,
          ),
          child: Container(
            decoration: KWidgetTheme.boxDecorationWidget,
            padding: const EdgeInsets.all(KPadding.kPaddingSize16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        borderRadius: KBorderRadius.kBorderRadiusL,
                        // color: AppColors.widgetBackground,
                      ),
                      child: Center(
                        key: KWidgetkeys.widget.profileCard.photo,
                        child: KIcon.person,
                      ),
                    ),
                    KSizedBox.kWidthSizedBox16,
                    if (isEditing)
                      Text(
                        context.l10n.editData,
                        key: KWidgetkeys.widget.profileCard.editText,
                        style: widget.isDesk
                            ? AppTextStyle.text40
                            : AppTextStyle.text24,
                      )
                    else
                      ..._displayProfileName(),
                  ],
                ),
                if (isEditing) ...[
                  KSizedBox.kHeightSizedBox8,
                  _textField(
                    fieldKey: KWidgetkeys.widget.profileCard.nameField,
                    textKey: KWidgetkeys.widget.profileCard.nameText,
                    label: context.l10n.name,
                    labelText: context
                        .read<AuthenticationBloc>()
                        .state
                        .user
                        ?.name
                        ?.split(' ')
                        .first,
                    hint: context.l10n.writeYouName,
                  ),
                  KSizedBox.kHeightSizedBox8,
                  _textField(
                    fieldKey: KWidgetkeys.widget.profileCard.lastNameField,
                    textKey: KWidgetkeys.widget.profileCard.lastNameText,
                    label: context.l10n.lastName,
                    labelText: context
                        .read<AuthenticationBloc>()
                        .state
                        .user
                        ?.name
                        ?.split(' ')
                        .last,
                    hint: context.l10n.writeYouLastName,
                  ),
                  KSizedBox.kHeightSizedBox8,
                ],
                ..._buildProfileInfo(),
                KSizedBox.kHeightSizedBox8,
                _buildProfileFooter(),
                KSizedBox.kHeightSizedBox8,
                _buildLinkedAccounts(),
              ],
            ),
          ),
        ),
        if (widget.isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
        if (widget.isDesk)
          Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  key: KWidgetkeys.widget.profileCard.logOutButton,
                  text: context.l10n.logOut,
                  textMaxLines: KMinMaxSize.textMaxLineOne,
                  textStyle: AppTextStyle.text32,
                  onPressed: () => context.dialog.showLogoutConfirmationDialog(
                    isDesk: true,
                  ),
                  isDesk: true,
                ),
              ),
              KSizedBox.kWidthSizedBox56,
              Expanded(
                child: ButtonWidget(
                  key: KWidgetkeys.widget.profileCard.deleteButton,
                  text: context.l10n.deleteAccount,
                  textMaxLines: KMinMaxSize.textMaxLineOne,
                  textStyle: AppTextStyle.text32,
                  onPressed: () => context.dialog.showDeleteConfirmationDialog(
                    isDesk: true,
                  ),
                  isDesk: true,
                  // backgroundColor: AppColors.transparent,
                ),
              ),
            ],
          )
        else ...[
          ButtonWidget(
            key: KWidgetkeys.widget.profileCard.logOutButton,
            text: context.l10n.logOut,
            onPressed: () => context.dialog.showLogoutConfirmationDialog(
              isDesk: false,
            ),
            isDesk: false,
          ),
          KSizedBox.kHeightSizedBox24,
          ButtonWidget(
            key: KWidgetkeys.widget.profileCard.deleteButton,
            text: context.l10n.deleteAccount,
            onPressed: () => context.dialog.showDeleteConfirmationDialog(
              isDesk: false,
            ),
            isDesk: false,
            // backgroundColor: AppColors.transparent,
          ),
        ],
        if (widget.isDesk) KSizedBox.kHeightSizedBox56,
      ],
    );
  }

  Widget _textField({
    required String label,
    required String hint,
    required String? labelText,
    required Key fieldKey,
    required Key textKey,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize16,
            vertical: KPadding.kPaddingSize4,
          ),
          child: Text(
            label,
            key: textKey,
            style: widget.isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
          ),
        ),
        TextFieldWidget(
          widgetKey: fieldKey,
          readOnly: readOnly,
          controller: TextEditingController(text: labelText),
          hintText: hint,
          hintStyle: widget.isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
          // fillColor: AppColors.transparent,
          contentPadding: const EdgeInsets.all(KPadding.kPaddingSize16),
          isDesk: widget.isDesk,
          onChanged: null,
        ),
      ],
    );
  }

  List<Widget> _displayProfileName() {
    return [
      Expanded(
        child: Text(
          context.read<AuthenticationBloc>().state.user?.name ??
              KMockText.userName,
          key: KWidgetkeys.widget.profileCard.name,
          style: widget.isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      IconButton(
        key: KWidgetkeys.widget.profileCard.editButton,
        onPressed: () => setState(() => isEditing = !isEditing),
        icon: KIcon.edit,
      ),
    ];
  }

  List<Widget> _buildProfileInfo() {
    return [
      _textField(
        fieldKey: KWidgetkeys.widget.profileCard.emailFied,
        textKey: KWidgetkeys.widget.profileCard.emailText,
        label: context.l10n.email,
        labelText: context.read<AuthenticationBloc>().state.user?.email,
        hint: KMockText.email,
        readOnly: true,
      ),
      KSizedBox.kHeightSizedBox8,
      _textField(
        fieldKey: KWidgetkeys.widget.profileCard.nickNameField,
        textKey: KWidgetkeys.widget.profileCard.nickNameText,
        label: KMockText.nickname,
        labelText: null,
        hint: KMockText.nickname,
        readOnly: !isEditing,
      ),
    ];
  }

  Widget _buildProfileFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SwitchWidgetWithoutBloc(
              key: KWidgetkeys.widget.profileCard.anonymousSwitch,
            ),
            KSizedBox.kHeightSizedBox8,
            Expanded(
              child: Text(
                context.l10n.beAnonymous,
              ),
            ),
          ],
        ),
        Text(
          context.l10n.beAnonymousDetails,
          key: KWidgetkeys.widget.profileCard.subtitle,
          style: widget.isDesk ? AppTextStyle.hint16 : AppTextStyle.text16,
        ),
        KSizedBox.kHeightSizedBox8,
        if (isEditing)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Center(
              child: ElevatedButton(
                key: KWidgetkeys.widget.profileCard.saveButton,
                style: KButtonStyles.widgetBackgroundButtonStyleWInf,
                onPressed: () => setState(() => isEditing = !isEditing),
                child:
                    Text(context.l10n.saveChanges, style: AppTextStyle.text24),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLinkedAccounts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.linkedAccounts,
          key: KWidgetkeys.widget.profileCard.connectAccountTitile,
          style: widget.isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
        ),
        KSizedBox.kHeightSizedBox8,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize16,
          ),
          child: Row(
            children: [
              KImage.facebook(
                key: KWidgetkeys.widget.profileCard.connectAccountIcon,
              ),
              KSizedBox.kWidthSizedBox8,
              Expanded(
                child: Text(
                  KMockText.facebook,
                  key: KWidgetkeys.widget.profileCard.connectAccountText,
                  style:
                      widget.isDesk ? AppTextStyle.text32 : AppTextStyle.text16,
                ),
              ),
            ],
          ),
        ),
        KSizedBox.kHeightSizedBox8,
        Row(
          children: [
            Expanded(
              child: TextFieldWidget(
                widgetKey:
                    KWidgetkeys.widget.profileCard.connectAccountTextField,
                enabled: false,
                hintText: KMockText.email,
                hintStyle:
                    widget.isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
                // fillColor: AppColors.transparent,
                contentPadding: const EdgeInsets.all(KPadding.kPaddingSize16),
                isDesk: widget.isDesk,
                onChanged: null,
              ),
            ),
            KSizedBox.kWidthSizedBox8,
            if (widget.isDesk)
              ElevatedButton(
                key: KWidgetkeys.widget.profileCard.connectAccountButton,
                style: KButtonStyles.widgetBackgroundSquareButtonStyleWInf,
                onPressed: null,
                child:
                    Text(context.l10n.disconnect, style: AppTextStyle.text24),
              ),
          ],
        ),
        KSizedBox.kHeightSizedBox8,
        Text(
          context.l10n.linkedAccountsDetails,
          key: KWidgetkeys.widget.profileCard.connectAccountSubtitle,
          style: AppTextStyle.hint16,
        ),
        KSizedBox.kHeightSizedBox8,
        if (!widget.isDesk)
          ElevatedButton(
            key: KWidgetkeys.widget.profileCard.connectAccountButton,
            style: KButtonStyles.widgetLightGreyButtonStyleWInf,
            onPressed: null,
            child: Text(context.l10n.disconnect, style: AppTextStyle.text24),
          ),
      ],
    );
  }
}
