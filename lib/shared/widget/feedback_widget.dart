import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({
    required this.isDesk,
    super.key,
    this.title,
    this.subtitle,
    this.messageHint,
    this.saveMessage,
  });

  final String? title;
  final String? subtitle;
  final String? messageHint;
  final String? saveMessage;
  final bool isDesk;

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController messageController;
  late Widget? completeWidget;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    messageController = TextEditingController();
    completeWidget = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedbackBloc, FeedbackState>(
      listenWhen: (previous, current) =>
          current.fieldsState != previous.fieldsState,
      listener: (context, state) {
        if (state.fieldsState == FieldEnum.success ||
            state.fieldsState == FieldEnum.initial) {
          nameController.clear();
          emailController.clear();
          messageController.clear();
        }
      },
      buildWhen: (previous, current) =>
          current.fieldsState != previous.fieldsState,
      builder: (context, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_.fieldsState == FieldEnum.success)
            Text(
              widget.saveMessage ?? context.l10n.feedbackSaveMessage,
              key: KWidgetkeys.widget.feedback.saveMessage,
              style: AppTextStyle.text40,
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title ?? context.l10n.feedback,
                  key: KWidgetkeys.widget.feedback.title,
                  style:
                      widget.isDesk ? AppTextStyle.text96 : AppTextStyle.text48,
                ),
                if (widget.isDesk)
                  KSizedBox.kHeightSizedBox32
                else
                  KSizedBox.kHeightSizedBox16,
                Text(
                  widget.subtitle ?? context.l10n.feedbackSubtitle,
                  key: KWidgetkeys.widget.feedback.subtitle,
                  style: AppTextStyle.text24,
                ),
              ],
            ),
          if (widget.isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
          Text(
            context.l10n.name,
            key: KWidgetkeys.widget.feedback.name,
            style: widget.isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
          ),
          if (widget.isDesk)
            KSizedBox.kHeightSizedBox24
          else
            KSizedBox.kHeightSizedBox8,
          TextFieldWidget(
            widgetKey: KWidgetkeys.widget.feedback.fieldName,
            errorText: _.fieldsState == FieldEnum.invalidData
                ? _.name.error.value(context)
                : null,
            controller: nameController,
            onChanged: (value) => context.read<FeedbackBloc>().add(
                  FeedbackEvent.nameUpdated(value),
                ),
            hintText: context.l10n.text,
            hintStyle:
                widget.isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
            isDesk: widget.isDesk,
          ),
          if (widget.isDesk)
            KSizedBox.kHeightSizedBox32
          else
            KSizedBox.kHeightSizedBox16,
          Text(
            '${context.l10n.fullEmail}*',
            key: KWidgetkeys.widget.feedback.email,
            style: widget.isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
          ),
          if (widget.isDesk)
            KSizedBox.kHeightSizedBox24
          else
            KSizedBox.kHeightSizedBox8,
          TextFieldWidget(
            widgetKey: KWidgetkeys.widget.feedback.fieldEmail,
            errorText: _.fieldsState == FieldEnum.invalidData
                ? _.email.error.value(context)
                : null,
            controller: emailController,
            onChanged: (value) => context.read<FeedbackBloc>().add(
                  FeedbackEvent.emailUpdated(value),
                ),
            hintText: context.l10n.writeYourEmail,
            hintStyle:
                widget.isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
            isDesk: widget.isDesk,
          ),
          if (widget.isDesk)
            KSizedBox.kHeightSizedBox32
          else
            KSizedBox.kHeightSizedBox16,
          Text(
            context.l10n.message,
            key: KWidgetkeys.widget.feedback.message,
            style: widget.isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
          ),
          if (widget.isDesk)
            KSizedBox.kHeightSizedBox24
          else
            KSizedBox.kHeightSizedBox8,
          MessageFieldWidget(
            key: KWidgetkeys.widget.feedback.fieldMessage,
            errorText: _.fieldsState == FieldEnum.invalidData
                ? _.message.error.value(context)
                : null,
            controller: messageController,
            changeMessage: (value) => context.read<FeedbackBloc>().add(
                  FeedbackEvent.messageUpdated(value),
                ),
            hintText: widget.messageHint ?? context.l10n.writeYourMessage,
            hintStyle:
                widget.isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
            isDesk: widget.isDesk,
          ),
          KSizedBox.kHeightSizedBox24,
          if (widget.isDesk)
            Row(
              children: buildButtons(isDesk: true),
            )
          else
            Column(
              children: buildButtons(isDesk: false),
            ),
          KSizedBox.kHeightSizedBox56,
        ],
      ),
    );
  }

  List<Widget> buildButtons({required bool isDesk}) {
    return [
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
        backgroundColor: AppColors.transparent,
      ),
    ];
  }
}
