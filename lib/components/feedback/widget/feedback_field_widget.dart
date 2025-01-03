import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    required this.isDesk,
    super.key,
  });

  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackBloc, FeedbackState>(
      buildWhen: (previous, current) =>
          (current.formState == FeedbackEnum.invalidData ||
              current.formState == FeedbackEnum.inProgress) &&
          current.formState != previous.formState,
      builder: (context, state) {
        if (isDesk) {
          return _DeskField(
            state: state,
          );
        } else {
          return _MobField(
            state: state,
          );
        }
      },
    );
  }
}

class _DeskField extends StatelessWidget {
  const _DeskField({required this.state});

  final FeedbackState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: KPadding.kPaddingSize24,
          children: [
            Expanded(
              child: TextFieldWidget(
                widgetKey: KWidgetkeys.screen.feedback.nameField,
                errorText: state.name.error.value(context),
                isRequired: true,
                showErrorText: state.formState == FeedbackEnum.invalidData,
                onChanged: (value) => context.read<FeedbackBloc>().add(
                      FeedbackEvent.nameUpdated(value),
                    ),
                labelText: context.l10n.name,
                isDesk: true,
              ),
            ),
            Expanded(
              child: TextFieldWidget(
                widgetKey: KWidgetkeys.screen.feedback.emailField,
                showErrorText: state.formState == FeedbackEnum.invalidData,
                isRequired: true,
                errorText: state.email.error.value(context),
                onChanged: (value) => context.read<FeedbackBloc>().add(
                      FeedbackEvent.emailUpdated(value),
                    ),
                labelText: context.l10n.email,
                isDesk: true,
              ),
            ),
          ],
        ),
        _MessagePart(
          isDesk: true,
          state: state,
        ),
      ],
    );
  }
}

class _MobField extends StatelessWidget {
  const _MobField({required this.state});
  final FeedbackState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWidget(
          widgetKey: KWidgetkeys.screen.feedback.nameField,
          showErrorText: state.formState == FeedbackEnum.invalidData,
          errorText: state.name.error.value(context),
          isRequired: true,
          onChanged: (value) => context.read<FeedbackBloc>().add(
                FeedbackEvent.nameUpdated(value),
              ),
          labelText: context.l10n.name,
          isDesk: false,
        ),
        KSizedBox.kHeightSizedBox16,
        TextFieldWidget(
          widgetKey: KWidgetkeys.screen.feedback.emailField,
          showErrorText: state.formState == FeedbackEnum.invalidData,
          errorText: state.email.error.value(context),
          isRequired: true,
          onChanged: (value) => context.read<FeedbackBloc>().add(
                FeedbackEvent.emailUpdated(value),
              ),
          labelText: context.l10n.email,
          isDesk: false,
        ),
        _MessagePart(
          isDesk: false,
          state: state,
        ),
      ],
    );
  }
}

class _MessagePart extends StatelessWidget {
  const _MessagePart({
    required this.isDesk,
    required this.state,
  });
  final bool isDesk;
  final FeedbackState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KSizedBox.kHeightSizedBox16,
        MessageFieldWidget(
          key: KWidgetkeys.screen.feedback.messageField,
          showErrorText: state.formState == FeedbackEnum.invalidData,
          errorText: state.message.error.value(context),
          changeMessage: (value) => context.read<FeedbackBloc>().add(
                FeedbackEvent.messageUpdated(value),
              ),
          labelText: context.l10n.writeYourMessage,
          isDesk: isDesk,
        ),
        Text(
          context.l10n.feedbackFormSubtitle,
          key: KWidgetkeys.screen.feedback.buttonText,
          style: AppTextStyle.materialThemeBodySmall,
        ),
        KSizedBox.kHeightSizedBox16,
        DoubleButtonWidget(
          widgetKey: KWidgetkeys.screen.feedback.button,
          text: context.l10n.sendMessage,
          isDesk: isDesk,
          onPressed: () =>
              context.read<FeedbackBloc>().add(const FeedbackEvent.save()),
          mobVerticalTextPadding: KPadding.kPaddingSize16,
          mobIconPadding: KPadding.kPaddingSize16,
          darkMode: true,
        ),
      ],
    );
  }
}
