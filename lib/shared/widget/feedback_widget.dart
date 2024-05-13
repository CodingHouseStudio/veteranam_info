import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

abstract class FeedbackWidget {
  static List<Widget> feedbackWidgetList({
    required BuildContext context,
    required bool isDesk,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController messageController,
    required GlobalKey feedbackKey,
    String? title,
    String? subtitle,
    String? messageHint,
  }) {
    if (context.read<FeedbackBloc>().state.formState ==
            FeedbackEnum.sendignMessageAgain &&
        feedbackKey.currentContext != null) {
      Scrollable.ensureVisible(feedbackKey.currentContext!);
      context.read<FeedbackBloc>().add(const FeedbackEvent.clear());
    }
    return [
      Text(
        title ?? context.l10n.feedback,
        key: KWidgetkeys.widget.feedback.title,
        style: isDesk ? AppTextStyle.text96 : AppTextStyle.text48,
      ),
      if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
      Text(
        subtitle ?? context.l10n.feedbackSubtitle,
        key: KWidgetkeys.widget.feedback.subtitle,
        style: AppTextStyle.text24,
      ),
      if (isDesk) KSizedBox.kHeightSizedBox56 else KSizedBox.kHeightSizedBox24,
      Padding(
        padding: EdgeInsets.only(
          left: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
        ),
        child: Text(
          context.l10n.name,
          key: KWidgetkeys.widget.feedback.name,
          style: isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
        ),
      ),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      TextFieldWidget(
        widgetKey: KWidgetkeys.widget.feedback.fieldName,
        errorText: context.read<FeedbackBloc>().state.formState ==
                FeedbackEnum.invalidData
            ? context.read<FeedbackBloc>().state.name.error.value(context)
            : null,
        controller: nameController,
        onChanged: (value) => context.read<FeedbackBloc>().add(
              FeedbackEvent.nameUpdated(value),
            ),
        hintText: context.l10n.text,
        hintStyle: isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
        isDesk: isDesk,
      ),
      if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
      Padding(
        padding: EdgeInsets.only(
          left: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
        ),
        child: Text(
          '${context.l10n.fullEmail}*',
          key: KWidgetkeys.widget.feedback.email,
          style: isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
        ),
      ),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      TextFieldWidget(
        widgetKey: KWidgetkeys.widget.feedback.fieldEmail,
        errorText: context.read<FeedbackBloc>().state.formState ==
                FeedbackEnum.invalidData
            ? context.read<FeedbackBloc>().state.email.error.value(context)
            : null,
        controller: emailController,
        onChanged: (value) => context.read<FeedbackBloc>().add(
              FeedbackEvent.emailUpdated(value),
            ),
        hintText: context.l10n.writeYourEmail,
        hintStyle: isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
        isDesk: isDesk,
      ),
      if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
      Padding(
        padding: EdgeInsets.only(
          left: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
        ),
        child: Text(
          context.l10n.message,
          key: KWidgetkeys.widget.feedback.message,
          style: isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
        ),
      ),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      MessageFieldWidget(
        key: KWidgetkeys.widget.feedback.fieldMessage,
        errorText: context.read<FeedbackBloc>().state.formState ==
                FeedbackEnum.invalidData
            ? context.read<FeedbackBloc>().state.message.error.value(context)
            : null,
        changeMessage: (value) => context.read<FeedbackBloc>().add(
              FeedbackEvent.messageUpdated(value),
            ),
        controller: messageController,
        hintText: messageHint ?? context.l10n.writeYourMessage,
        hintStyle: isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
        isDesk: isDesk,
      ),
      KSizedBox.kHeightSizedBox24,
      if (isDesk)
        Row(
          children: [
            ButtonWidget(
              key: KWidgetkeys.widget.feedback.buttonSave,
              text: context.l10n.send,
              onPressed: () => context.read<FeedbackBloc>().add(
                    const FeedbackEvent.save(),
                  ),
              isDesk: isDesk,
            ),
            if (isDesk)
              KSizedBox.kWidthSizedBox24
            else
              KSizedBox.kHeightSizedBox24,
            ButtonWidget(
              key: KWidgetkeys.widget.feedback.buttonClear,
              text: context.l10n.clear,
              onPressed: () => context.read<FeedbackBloc>().add(
                    const FeedbackEvent.clear(),
                  ),
              isDesk: isDesk,
              // backgroundColor: AppColors.transparent,
            ),
          ],
        )
      else ...[
        ButtonWidget(
          key: KWidgetkeys.widget.feedback.buttonSave,
          text: context.l10n.send,
          onPressed: () => context.read<FeedbackBloc>().add(
                const FeedbackEvent.save(),
              ),
          isDesk: isDesk,
        ),
        if (isDesk) KSizedBox.kWidthSizedBox24 else KSizedBox.kHeightSizedBox24,
        ButtonWidget(
          key: KWidgetkeys.widget.feedback.buttonClear,
          text: context.l10n.clear,
          onPressed: () => context.read<FeedbackBloc>().add(
                const FeedbackEvent.clear(),
              ),
          isDesk: isDesk,
          // backgroundColor: AppColors.transparent,
        ),
      ],
      KSizedBox.kHeightSizedBox56,
    ];
  }
}
