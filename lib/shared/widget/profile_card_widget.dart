//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';
import 'package:kozak/shared/widget/dialogs_widget.dart';

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
        padding: EdgeInsets.all(
          widget.isDesk ? KPadding.kPaddingSize4 : KPadding.kPaddingSize8,
        ),
        key: KWidgetkeys.widget.profileCard.profileCard,
        child: Container(
          decoration: KWidgetTheme.boxDecorationWidget(context),
          child: Padding(
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
                      decoration: BoxDecoration(
                        borderRadius: KBorderRadius.kBorderRadiusL,
                        // color: AppColors.widgetBackground,
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
                KSizedBox.kHeightSizedBox8,
                _buildLinkedAccounts(),
                KSizedBox.kHeightSizedBox56,
                if (widget.isDesk)
                  Row(
                    children: [
                      Expanded(
                        child: ButtonWidget(
                          key:
                              KWidgetkeys.widget.profileCardWidget.logOutButton,
                          text: context.l10n.logOut,
                          textMaxLines: KMinMaxSize.textMaxLineOne,
                          textStyle: AppTextStyle.text32,
                          onPressed: () =>
                              DialogsWidget.showLogoutConfirmationDialog(
                            context: context,
                            isDesk: widget.isDesk,
                          ),
                          isDesk: true,
                        ),
                      ),
                      KSizedBox.kWidthSizedBox24,
                      Expanded(
                        child: ButtonWidget(
                          key:
                              KWidgetkeys.widget.profileCardWidget.deleteButton,
                          text: context.l10n.deleteAccount,
                          textMaxLines: KMinMaxSize.textMaxLineOne,
                          textStyle: AppTextStyle.text32,
                          onPressed: () =>
                              DialogsWidget.showDeleteConfirmationDialog(
                            context: context,
                            isDesk: widget.isDesk,
                          ),
                          isDesk: true,
                          // backgroundColor: AppColors.transparent,
                        ),
                      ),
                    ],
                  )
                else ...[
                  ButtonWidget(
                    key: KWidgetkeys.widget.profileCardWidget.logOutButton,
                    text: context.l10n.logOut,
                    textStyle: AppTextStyle.text32,
                    onPressed: () => DialogsWidget.showLogoutConfirmationDialog(
                      context: context,
                      isDesk: widget.isDesk,
                    ),
                    isDesk: false,
                  ),
                  KSizedBox.kHeightSizedBox24,
                  ButtonWidget(
                    key: KWidgetkeys.widget.profileCardWidget.deleteButton,
                    text: context.l10n.deleteAccount,
                    textStyle: AppTextStyle.text32,
                    onPressed: () => DialogsWidget.showDeleteConfirmationDialog(
                      context: context,
                      isDesk: widget.isDesk,
                    ),
                    isDesk: false,
                    // backgroundColor: AppColors.transparent,
                  ),
                ],
                KSizedBox.kHeightSizedBox56,
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
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize16,
            vertical: KPadding.kPaddingSize4,
          ),
          child: Text(
            label,
            style: widget.isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
          ),
        ),
        TextFieldWidget(
          widgetKey: KWidgetkeys.widget.profileCardWidget.textFiled,
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
        Text(
          context.l10n.beAnonymousDetails,
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
          style: widget.isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
        ),
        KSizedBox.kHeightSizedBox8,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize16,
          ),
          child: Row(
            children: [
              KIcon.facebook,
              KSizedBox.kWidthSizedBox8,
              Expanded(
                child: Text(
                  KMockText.facebook,
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
                widgetKey: KWidgetkeys.widget.profileCardWidget.textFiled,
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
          style: AppTextStyle.hint16,
        ),
        KSizedBox.kHeightSizedBox8,
        if (widget.isDesk == false)
          ElevatedButton(
            style: KButtonStyles.widgetLightGreyButtonStyleWInf,
            onPressed: null,
            child: Text(context.l10n.disconnect, style: AppTextStyle.text24),
          ),
      ],
    );
  }
}
