part of '../widget_keys.dart';

abstract class QuestionsFormKeys {
  static const screen = Key('questions_form_screen');
  static const title = Key('questions_form_screen_title');
  static const subtitle = Key('questions_form_screen_subtitle');
  static const roleTitle = Key('questions_form_screen_role_');
  static const roleVeteran = Key('questions_form_screen_role_veteran');
  // static const roleVeteranText = Key('questions_form_screen_role
  // _veteran_text');
  static const roleRelativeOfVeteran =
      Key('questions_form_screen_role__relative_of_veteran');
  // static const roleRelativeOfVeteranText =
  //     Key('questions_form_screen_role__relative_of_veteran_text');
  static const roleCivilian = Key('questions_form_screen_role_civilian');
  // static const roleCivilianText =
  //     Key('questions_form_screen_role_civilian_text');
  static const roleBusinessmen = Key('questions_form_screen_role_businessman');
  // static const roleBusinessmenText =
  //     Key('questions_form_screen_role_businessman_text');
  static const button = Key('questions_form_screen_button');

  static const roleKeyes = [
    roleVeteran,
    roleRelativeOfVeteran,
    roleCivilian,
    roleBusinessmen,
  ];
}
