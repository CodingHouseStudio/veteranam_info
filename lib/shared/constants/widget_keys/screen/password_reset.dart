// ignore_for_file: avoid_field_initializers_in_const_classes

part of '../widget_keys.dart';

class _PasswordResetKeys {
  const _PasswordResetKeys();
  final screen = const Key('pw_reset_email_screen');
  final title = const Key('pw_reset_email_title');
  final subtitle = const Key('pw_reset_email_subtitle');
  final passwordField = const Key('pw_reset_email_password_field');
  final confirmPasswordField =
      const Key('pw_reset_email_confirm_password_field');
  final confirmButton = const Key('pw_reset_email_confirm_button');
  final wrongLinkSubtitle = const Key('pw_reset_email_wrong_linkSubtitle');
  final loadingIndicator = const Key('pw_reset_email_loading_indicator');
  final submitingText = const Key('pw_reset_email_submiting_text');
}
