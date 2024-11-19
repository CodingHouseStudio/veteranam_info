import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    required this.isDesk,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    super.key,
  });
  final bool isDesk;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return isDesk
        ? _DeskField(
            nameController: nameController,
            emailController: emailController,
            messageController: messageController,
          )
        : _MobField(
            nameController: nameController,
            emailController: emailController,
            messageController: messageController,
          );
  }
}

class _DeskField extends StatelessWidget {
  const _DeskField({
    required this.nameController,
    required this.emailController,
    required this.messageController,
  });
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFieldWidget(
                widgetKey: KWidgetkeys.screen.feedback.nameField,
                errorText: context
                    .read<FeedbackBloc>()
                    .state
                    .name
                    .error
                    .value(context),
                isRequired: true,
                showErrorText: context.read<FeedbackBloc>().state.formState ==
                    FeedbackEnum.invalidData,
                controller: nameController,
                onChanged: (value) => context.read<FeedbackBloc>().add(
                      FeedbackEvent.nameUpdated(value),
                    ),
                labelText: context.l10n.name,
                isDesk: true,
              ),
            ),
            KSizedBox.kWidthSizedBox24,
            Expanded(
              child: TextFieldWidget(
                widgetKey: KWidgetkeys.screen.feedback.emailField,
                showErrorText: context.read<FeedbackBloc>().state.formState ==
                    FeedbackEnum.invalidData,
                isRequired: true,
                errorText: context
                    .read<FeedbackBloc>()
                    .state
                    .email
                    .error
                    .value(context),
                controller: emailController,
                onChanged: (value) => context.read<FeedbackBloc>().add(
                      FeedbackEvent.emailUpdated(value),
                    ),
                labelText: context.l10n.email,
                isDesk: true,
              ),
            ),
          ],
        ),
        _MessagePart(isDesk: true, messageController: messageController),
      ],
    );
  }
}

class _MobField extends StatelessWidget {
  const _MobField({
    required this.nameController,
    required this.emailController,
    required this.messageController,
  });
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWidget(
          widgetKey: KWidgetkeys.screen.feedback.nameField,
          showErrorText: context.read<FeedbackBloc>().state.formState ==
              FeedbackEnum.invalidData,
          errorText:
              context.read<FeedbackBloc>().state.name.error.value(context),
          isRequired: true,
          controller: nameController,
          onChanged: (value) => context.read<FeedbackBloc>().add(
                FeedbackEvent.nameUpdated(value),
              ),
          labelText: context.l10n.name,
          isDesk: false,
        ),
        KSizedBox.kHeightSizedBox16,
        TextFieldWidget(
          widgetKey: KWidgetkeys.screen.feedback.emailField,
          showErrorText: context.read<FeedbackBloc>().state.formState ==
              FeedbackEnum.invalidData,
          errorText:
              context.read<FeedbackBloc>().state.email.error.value(context),
          isRequired: true,
          controller: emailController,
          onChanged: (value) => context.read<FeedbackBloc>().add(
                FeedbackEvent.emailUpdated(value),
              ),
          labelText: context.l10n.email,
          isDesk: false,
        ),
        _MessagePart(isDesk: false, messageController: messageController),
      ],
    );
  }
}

class _MessagePart extends StatelessWidget {
  const _MessagePart({
    required this.isDesk,
    required this.messageController,
  });
  final bool isDesk;

  final TextEditingController messageController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KSizedBox.kHeightSizedBox16,
        MessageFieldWidget(
          key: KWidgetkeys.screen.feedback.messageField,
          showErrorText: context.read<FeedbackBloc>().state.formState ==
              FeedbackEnum.invalidData,
          errorText:
              context.read<FeedbackBloc>().state.message.error.value(context),
          changeMessage: (value) => context.read<FeedbackBloc>().add(
                FeedbackEvent.messageUpdated(value),
              ),
          controller: messageController,
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

// part of 'body/feedback_body_widget.dart';

// List<Widget> _fieldWidgetList({
//   required bool isDesk,
//   required BuildContext context,
//   required TextEditingController nameController,
//   required TextEditingController emailController,
//   required TextEditingController messageController,
// }) =>
//     [
//       if (isDesk)
//         Row(
//           children: [
//             Expanded(
//               child: TextFieldWidget(
//                 widgetKey: KWidgetkeys.screen.feedback.nameField,
//                 errorText: context
//                     .read<FeedbackBloc>()
//                     .state
//                     .name
//                     .error
//                     .value(context),
//                 isRequired: true,
//                 showErrorText: context.read<FeedbackBloc>().state.formState ==
//                     FeedbackEnum.invalidData,
//                 controller: nameController,
//                 onChanged: (value) => context.read<FeedbackBloc>().add(
//                       FeedbackEvent.nameUpdated(value),
//                     ),
//                 labelText: context.l10n.name,
//                 isDesk: isDesk,
//               ),
//             ),
//             KSizedBox.kWidthSizedBox24,
//             Expanded(
//               child: TextFieldWidget(
//                 widgetKey: KWidgetkeys.screen.feedback.emailField,
//                 showErrorText: context.read<FeedbackBloc>().state.formState ==
//                     FeedbackEnum.invalidData,
//                 isRequired: true,
//                 errorText: context
//                     .read<FeedbackBloc>()
//                     .state
//                     .email
//                     .error
//                     .value(context),
//                 controller: emailController,
//                 onChanged: (value) => context.read<FeedbackBloc>().add(
//                       FeedbackEvent.emailUpdated(value),
//                     ),
//                 labelText: context.l10n.email,
//                 isDesk: isDesk,
//               ),
//             ),
//           ],
//         )
//       else ...[
//         TextFieldWidget(
//           widgetKey: KWidgetkeys.screen.feedback.nameField,
//           showErrorText: context.read<FeedbackBloc>().state.formState ==
//               FeedbackEnum.invalidData,
//           errorText:
//               context.read<FeedbackBloc>().state.name.error.value(context),
//           isRequired: true,
//           controller: nameController,
//           onChanged: (value) => context.read<FeedbackBloc>().add(
//                 FeedbackEvent.nameUpdated(value),
//               ),
//           labelText: context.l10n.name,
//           isDesk: isDesk,
//         ),
//         KSizedBox.kHeightSizedBox16,
//         TextFieldWidget(
//           widgetKey: KWidgetkeys.screen.feedback.emailField,
//           showErrorText: context.read<FeedbackBloc>().state.formState ==
//               FeedbackEnum.invalidData,
//           errorText:
//               context.read<FeedbackBloc>().state.email.error.value(context),
//           isRequired: true,
//           controller: emailController,
//           onChanged: (value) => context.read<FeedbackBloc>().add(
//                 FeedbackEvent.emailUpdated(value),
//               ),
//           labelText: context.l10n.email,
//           isDesk: isDesk,
//         ),
//       ],
//       KSizedBox.kHeightSizedBox16,
//       MessageFieldWidget(
//         key: KWidgetkeys.screen.feedback.messageField,
//         showErrorText: context.read<FeedbackBloc>().state.formState ==
//             FeedbackEnum.invalidData,
//         errorText:
//             context.read<FeedbackBloc>().state.message.error.value(context),
//         changeMessage: (value) => context.read<FeedbackBloc>().add(
//               FeedbackEvent.messageUpdated(value),
//             ),
//         controller: messageController,
//         labelText: context.l10n.writeYourMessage,
//         isDesk: isDesk,
//       ),
//       Text(
//         context.l10n.feedbackFormSubtitle,
//         key: KWidgetkeys.screen.feedback.buttonText,
//         style: AppTextStyle.materialThemeBodySmall,
//       ),
//       KSizedBox.kHeightSizedBox16,
//       DoubleButtonWidget(
//         widgetKey: KWidgetkeys.screen.feedback.button,
//         text: context.l10n.sendMessage,
//         isDesk: isDesk,
//         onPressed: () =>
//             context.read<FeedbackBloc>().add(const FeedbackEvent.save()),
//         mobVerticalTextPadding: KPadding.kPaddingSize16,
//         mobIconPadding: KPadding.kPaddingSize16,
//         darkMode: true,
//       ),
//     ];
