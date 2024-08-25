part of '../widget_keys.dart';

class _FooterKeys {
  final widget = const Key('footer');
  final title = const Key('footer_title');
  final button = const Key('footer_button');
  final sections = const Key('footer_sections');
  final information = const Key('footer_informatin');
  final contact = const Key('footer_contact');
  final emailButton = const Key('footer_email');
  //final emailIcon = const Key('footer_email_icon');
  final aboutUsButton = const Key('footer_about_us_button');
  final informationButton = const Key('footer_information_button');
  final consultationOnlineButton =
      const Key('footer_consultation_online_button');
  final discountsButton = const Key('footer_discounts_button');
  final storyButton = const Key('footer_story_button');
  final workButton = const Key('footer_work_button');
  final profileButton = const Key('footer_profile_button');
  final investorsButton = const Key('footer_investors_button');
  final likedInIcon = const Key('footer_linked_in_icon');
  final instagramIcon = const Key('footer_instagram_icon');
  final facebookIcon = const Key('footer_facebook_icon');
  final logo = const Key('footer_logo');
  final madeBy = const Key('footer_made_by');
  final rightReserved = const Key('footer_right_reserved');
  final privacyPolicy = const Key('footer_privacy_policy');

  List<Key> get buttonsKey => [
        aboutUsButton,
        investorsButton,
        // emailText,
        storyButton,
        discountsButton,
        profileButton,
        workButton,
        informationButton,
        consultationOnlineButton,
      ];

  List<Key> get buttonsProdKey => [
        investorsButton,
        discountsButton,
        button,
      ];
}
