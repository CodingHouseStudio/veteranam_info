import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class FeedbackWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final feedbackBoxKey = GlobalKey();
    final feedbackKey = GlobalKey();
    return BlocBuilder<FeedbackBloc, FeedbackState>(
      buildWhen: (previous, current) =>
          current.fieldsState != previous.fieldsState,
      builder: (context, _) => _.fieldsState == FeedbackEnum.success
          ? FeedbackBoxWidget(
              key: feedbackBoxKey,
              isDesk: isDesk,
              sendAgain: () =>
                  context.read<FeedbackBloc>().add(const FeedbackEvent.clear()),
              feedbackBoxKey: feedbackBoxKey,
            )
          : _FeedbackWidgetImplementation(
              key: feedbackKey,
              isDesk: isDesk,
              messageHint: messageHint,
              saveMessage: saveMessage,
              subtitle: subtitle,
              title: title,
              feedbackKey: feedbackKey,
              emailFailure: _.fieldsState == FeedbackEnum.invalidData
                  ? _.email.error.value(context)
                  : null,
              messageFailure: _.fieldsState == FeedbackEnum.invalidData
                  ? _.message.error.value(context)
                  : null,
              nameFailure: _.fieldsState == FeedbackEnum.invalidData
                  ? _.name.error.value(context)
                  : null,
            ),
    );
  }
}

class _FeedbackWidgetImplementation extends StatefulWidget {
  const _FeedbackWidgetImplementation({
    required this.isDesk,
    required this.feedbackKey,
    super.key,
    this.title,
    this.subtitle,
    this.messageHint,
    this.saveMessage,
    this.emailFailure,
    this.nameFailure,
    this.messageFailure,
  });

  final String? title;
  final String? subtitle;
  final String? messageHint;
  final String? saveMessage;
  final bool isDesk;
  final GlobalKey feedbackKey;
  final String? emailFailure;
  final String? nameFailure;
  final String? messageFailure;

  @override
  State<_FeedbackWidgetImplementation> createState() =>
      _FeedbackWidgetImplementationState();
}

class _FeedbackWidgetImplementationState
    extends State<_FeedbackWidgetImplementation> {
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
    if (context.read<FeedbackBloc>().state.fieldsState == FeedbackEnum.clear) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(widget.feedbackKey.currentContext!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedbackBloc, FeedbackState>(
      listenWhen: (previous, current) =>
          current.fieldsState == FeedbackEnum.clear,
      listener: (context, state) {
        nameController.clear();
        emailController.clear();
        messageController.clear();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            errorText: widget.nameFailure,
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
            errorText: widget.emailFailure,
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
            errorText: widget.messageFailure,
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
