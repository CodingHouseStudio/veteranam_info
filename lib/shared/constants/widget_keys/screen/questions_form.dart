part of '../widget_keys.dart';

class _QuestionsFormKeys {
  final screen = const Key('questions_form_screen');
  final title = const Key('questions_form_screen_title');
  final subtitle = const Key('questions_form_screen_subtitle');
  final roleTitle = const Key('questions_form_screen_role_');
  final roleVeteran = const Key('questions_form_screen_role_veteran');
  // final roleVeteranText = const Key('questions_form_screen_role
  // _veteran_text');
  final roleRelativeOfVeteran =
      const Key('questions_form_screen_role__relative_of_veteran');
  // final roleRelativeOfVeteranText =
  //     const Key('questions_form_screen_role__relative_of_veteran_text');
  final roleCivilian = const Key('questions_form_screen_role_civilian');
  // final roleCivilianText =
  //     const Key('questions_form_screen_role_civilian_text');
  final roleBusinessmen = const Key('questions_form_screen_role_businessman');
  // final roleBusinessmenText =
  //     const Key('questions_form_screen_role_businessman_text');
  final button = const Key('questions_form_screen_button');

  List<Key> get roleKeyes => [
        roleVeteran,
        roleRelativeOfVeteran,
        roleCivilian,
        roleBusinessmen,
      ];
}
