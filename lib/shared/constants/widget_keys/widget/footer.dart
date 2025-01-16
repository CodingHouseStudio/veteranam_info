part of '../widget_keys.dart';

abstract class FooterKeys {
  static const widget = Key('footer');
  static const title = Key('footer_title');
  static const button = Key('footer_button');
  static const sections = Key('footer_sections');
  static const information = Key('footer_informatin');
  static const contact = Key('footer_contact');
  static const emailButton = Key('footer_email');
  //static const emailIcon = Key('footer_email_icon');
  static const aboutUsButton = Key('footer_about_us_button');
  static const informationButton = Key('footer_information_button');
  static const consultationOnlineButton =
      Key('footer_consultation_online_button');
  static const discountsButton = Key('footer_discounts_button');
  static const storyButton = Key('footer_story_button');
  static const workButton = Key('footer_work_button');
  static const profileButton = Key('footer_profile_button');
  static const investorsButton = Key('footer_investors_button');
  static const likedInIcon = Key('footer_linked_in_icon');
  static const instagramIcon = Key('footer_instagram_icon');
  static const facebookIcon = Key('footer_facebook_icon');
  static const logo = Key('footer_logo');
  static const madeBy = Key('footer_made_by');
  static const rightReserved = Key('footer_right_reserved');
  static const privacyPolicy = Key('footer_privacy_policy');

  static const buttonsKey = [
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

  static const buttonsProdKey = [
    investorsButton,
    discountsButton,
    button,
  ];
}
