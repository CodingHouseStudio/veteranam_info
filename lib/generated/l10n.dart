// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Veteranam`
  String get logo {
    return Intl.message(
      'Veteranam',
      name: 'logo',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search {
    return Intl.message(
      'Search...',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Hide`
  String get hide {
    return Intl.message(
      'Hide',
      name: 'hide',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get detail {
    return Intl.message(
      'Detail',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `Reset all`
  String get resetAll {
    return Intl.message(
      'Reset all',
      name: 'resetAll',
      desc: '',
      args: [],
    );
  }

  /// `About project`
  String get aboutUs {
    return Intl.message(
      'About project',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Stories`
  String get stories {
    return Intl.message(
      'Stories',
      name: 'stories',
      desc: '',
      args: [],
    );
  }

  /// `Discounts`
  String get discounts {
    return Intl.message(
      'Discounts',
      name: 'discounts',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get myProfile {
    return Intl.message(
      'Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Work`
  String get work {
    return Intl.message(
      'Work',
      name: 'work',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Consultation`
  String get consultationOnline {
    return Intl.message(
      'Consultation',
      name: 'consultationOnline',
      desc: '',
      args: [],
    );
  }

  /// `Read less`
  String get readLess {
    return Intl.message(
      'Read less',
      name: 'readLess',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message(
      'Read more',
      name: 'readMore',
      desc: '',
      args: [],
    );
  }

  /// `Respond`
  String get respond {
    return Intl.message(
      'Respond',
      name: 'respond',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Nickname`
  String get nickname {
    return Intl.message(
      'Nickname',
      name: 'nickname',
      desc: '',
      args: [],
    );
  }

  /// `Anonymous`
  String get beAnonymous {
    return Intl.message(
      'Anonymous',
      name: 'beAnonymous',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get errorTitle {
    return Intl.message(
      'Error',
      name: 'errorTitle',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while loading the page`
  String get errorMessage {
    return Intl.message(
      'An error occurred while loading the page',
      name: 'errorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `My story`
  String get myStory {
    return Intl.message(
      'My story',
      name: 'myStory',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get saved {
    return Intl.message(
      'Saved',
      name: 'saved',
      desc: '',
      args: [],
    );
  }

  /// `In this section you can add personal information, set your profile to be anonymous, and find your saved content.`
  String get profileDetails {
    return Intl.message(
      'In this section you can add personal information, set your profile to be anonymous, and find your saved content.',
      name: 'profileDetails',
      desc: '',
      args: [],
    );
  }

  /// `If you make your profile anonymous, your page will not display personal information, only your nickname.`
  String get beAnonymousDetails {
    return Intl.message(
      'If you make your profile anonymous, your page will not display personal information, only your nickname.',
      name: 'beAnonymousDetails',
      desc: '',
      args: [],
    );
  }

  /// `Write your name`
  String get writeYouName {
    return Intl.message(
      'Write your name',
      name: 'writeYouName',
      desc: '',
      args: [],
    );
  }

  /// `Write your last name`
  String get writeYouLastName {
    return Intl.message(
      'Write your last name',
      name: 'writeYouLastName',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get saveChanges {
    return Intl.message(
      'Save changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Edit data`
  String get editData {
    return Intl.message(
      'Edit data',
      name: 'editData',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastName {
    return Intl.message(
      'Last name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Key`
  String get key {
    return Intl.message(
      'Key',
      name: 'key',
      desc: '',
      args: [],
    );
  }

  /// `No data found, click to add test data once`
  String get getMockData {
    return Intl.message(
      'No data found, click to add test data once',
      name: 'getMockData',
      desc: '',
      args: [],
    );
  }

  /// `Investors`
  String get investors {
    return Intl.message(
      'Investors',
      name: 'investors',
      desc: '',
      args: [],
    );
  }

  /// `In this section, you can support veterans. If you have a business, you can provide discounts or personalized offers for veterans. Write to us and we will contact you to discuss the details.`
  String get investorsSubtitle {
    return Intl.message(
      'In this section, you can support veterans. If you have a business, you can provide discounts or personalized offers for veterans. Write to us and we will contact you to discuss the details.',
      name: 'investorsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Write your email`
  String get writeYourEmail {
    return Intl.message(
      'Write your email',
      name: 'writeYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `text`
  String get text {
    return Intl.message(
      'text',
      name: 'text',
      desc: '',
      args: [],
    );
  }

  /// `Write your suggestions`
  String get writeYourSuggenstions {
    return Intl.message(
      'Write your suggestions',
      name: 'writeYourSuggenstions',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message(
      'Feedback',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Didn't find what you were looking for, want to get in touch, or have questions or requests? We are happy to talk to you! Please fill out the form below.`
  String get feedbackSubtitle {
    return Intl.message(
      'Didn\'t find what you were looking for, want to get in touch, or have questions or requests? We are happy to talk to you! Please fill out the form below.',
      name: 'feedbackSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Write your message`
  String get writeYourMessage {
    return Intl.message(
      'Write your message',
      name: 'writeYourMessage',
      desc: '',
      args: [],
    );
  }

  /// `Hello, Veteran!`
  String get helloVeteran {
    return Intl.message(
      'Hello, Veteran!',
      name: 'helloVeteran',
      desc: '',
      args: [],
    );
  }

  /// `Here you will find useful information, benefits, discounts and you can also share your story!`
  String get homeSubtitle {
    return Intl.message(
      'Here you will find useful information, benefits, discounts and you can also share your story!',
      name: 'homeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your submission`
  String get feedbackSaveMessage {
    return Intl.message(
      'Thank you for your submission',
      name: 'feedbackSaveMessage',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Field cann't be empty`
  String get fieldCannotBeEmpty {
    return Intl.message(
      'Field cann`t be empty',
      name: 'fieldCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `too short`
  String get tooshort {
    return Intl.message(
      'too short',
      name: 'tooshort',
      desc: '',
      args: [],
    );
  }

  /// `Email too short`
  String get tooShortEmail {
    return Intl.message(
      'Email too short',
      name: 'tooShortEmail',
      desc: '',
      args: [],
    );
  }

  /// `is wrong`
  String get isWrong {
    return Intl.message(
      'is wrong',
      name: 'isWrong',
      desc: '',
      args: [],
    );
  }

  /// `is wrong`
  String get isWrongEmail {
    return Intl.message(
      'is wrong',
      name: 'isWrongEmail',
      desc: '',
      args: [],
    );
  }

  /// ` Log out`
  String get logOut {
    return Intl.message(
      ' Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get deleteAccount {
    return Intl.message(
      'Delete account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get fullEmail {
    return Intl.message(
      'Email',
      name: 'fullEmail',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Do you have an account`
  String get doYouHavenAccount {
    return Intl.message(
      'Do you have an account',
      name: 'doYouHavenAccount',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get donotYouHavenAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'donotYouHavenAccount',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with`
  String get signUpWith {
    return Intl.message(
      'Sign up with',
      name: 'signUpWith',
      desc: '',
      args: [],
    );
  }

  /// `Google`
  String get google {
    return Intl.message(
      'Google',
      name: 'google',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get facebook {
    return Intl.message(
      'Facebook',
      name: 'facebook',
      desc: '',
      args: [],
    );
  }

  /// `Apple`
  String get apple {
    return Intl.message(
      'Apple',
      name: 'apple',
      desc: '',
      args: [],
    );
  }

  /// `too short`
  String get tooShortPassword {
    return Intl.message(
      'too short',
      name: 'tooShortPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Create a secure password`
  String get createSecurePassword {
    return Intl.message(
      'Create a secure password',
      name: 'createSecurePassword',
      desc: '',
      args: [],
    );
  }

  /// `must contain one or more capital letter`
  String get capitalLetter {
    return Intl.message(
      'must contain one or more capital letter',
      name: 'capitalLetter',
      desc: '',
      args: [],
    );
  }

  /// `must contain one or more number`
  String get oneNumber {
    return Intl.message(
      'must contain one or more number',
      name: 'oneNumber',
      desc: '',
      args: [],
    );
  }

  /// `In this section you will find verified information on how to get help, etc. You can use filters for convenience.`
  String get informationSubtitle {
    return Intl.message(
      'In this section you will find verified information on how to get help, etc. You can use filters for convenience.',
      name: 'informationSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `More news`
  String get moreNews {
    return Intl.message(
      'More news',
      name: 'moreNews',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Funds`
  String get funds {
    return Intl.message(
      'Funds',
      name: 'funds',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to support veterans not with words but with deeds? Here are the largest proven foundations you can donate to. You can send any amount of money, because there are no small donations.`
  String get fundsSubtitle {
    return Intl.message(
      'Do you want to support veterans not with words but with deeds? Here are the largest proven foundations you can donate to. You can send any amount of money, because there are no small donations.',
      name: 'fundsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Thank you!`
  String get thankYou {
    return Intl.message(
      'Thank you!',
      name: 'thankYou',
      desc: '',
      args: [],
    );
  }

  /// `We have received your message and will respond to you as soon as possible.`
  String get feedbackBoxSubtitle {
    return Intl.message(
      'We have received your message and will respond to you as soon as possible.',
      name: 'feedbackBoxSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Send more`
  String get sendMore {
    return Intl.message(
      'Send more',
      name: 'sendMore',
      desc: '',
      args: [],
    );
  }

  /// `Linked accounts`
  String get linkedAccounts {
    return Intl.message(
      'Linked accounts',
      name: 'linkedAccounts',
      desc: '',
      args: [],
    );
  }

  /// `Your Veteran account is currently linked to a Facebook account.`
  String get linkedAccountsDetails {
    return Intl.message(
      'Your Veteran account is currently linked to a Facebook account.',
      name: 'linkedAccountsDetails',
      desc: '',
      args: [],
    );
  }

  /// `Disconnect`
  String get disconnect {
    return Intl.message(
      'Disconnect',
      name: 'disconnect',
      desc: '',
      args: [],
    );
  }

  /// `We have received your message and will respond to you as soon as possible.`
  String get receivedYourMessage {
    return Intl.message(
      'We have received your message and will respond to you as soon as possible.',
      name: 'receivedYourMessage',
      desc: '',
      args: [],
    );
  }

  /// `Log in with`
  String get logInWith {
    return Intl.message(
      'Log in with',
      name: 'logInWith',
      desc: '',
      args: [],
    );
  }

  /// `Rate our site`
  String get rateOurSite {
    return Intl.message(
      'Rate our site',
      name: 'rateOurSite',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Please note! To access some services, you will need to confirm your status by showing the appropriate ID.`
  String get thankYouDescription {
    return Intl.message(
      'Please note! To access some services, you will need to confirm your status by showing the appropriate ID.',
      name: 'thankYouDescription',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get mainScreen {
    return Intl.message(
      'Home',
      name: 'mainScreen',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the form`
  String get fillInForm {
    return Intl.message(
      'Fill in the form',
      name: 'fillInForm',
      desc: '',
      args: [],
    );
  }

  /// `In order for us to provide you with the most useful services, please answer the following question:`
  String get questionsFormSubtitle {
    return Intl.message(
      'In order for us to provide you with the most useful services, please answer the following question:',
      name: 'questionsFormSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Select the appropriate one:`
  String get selectAppropriateOne {
    return Intl.message(
      'Select the appropriate one:',
      name: 'selectAppropriateOne',
      desc: '',
      args: [],
    );
  }

  /// `I am a veteran;`
  String get iAmVeteran {
    return Intl.message(
      'I am a veteran;',
      name: 'iAmVeteran',
      desc: '',
      args: [],
    );
  }

  /// `I am a relative of a veteran;`
  String get iAmRelativeOfVeteran {
    return Intl.message(
      'I am a relative of a veteran;',
      name: 'iAmRelativeOfVeteran',
      desc: '',
      args: [],
    );
  }

  /// `I am a civilian;`
  String get iAmCivilian {
    return Intl.message(
      'I am a civilian;',
      name: 'iAmCivilian',
      desc: '',
      args: [],
    );
  }

  /// `I am a business owner/representative, I want to provide benefits.`
  String get iAmBusinessOwnerRepresentative {
    return Intl.message(
      'I am a business owner/representative, I want to provide benefits.',
      name: 'iAmBusinessOwnerRepresentative',
      desc: '',
      args: [],
    );
  }

  /// `In this section, you will find current vacancies, and you can also leave a request to help us with your search. For your convenience, you can use filters.`
  String get workSubtitle {
    return Intl.message(
      'In this section, you will find current vacancies, and you can also leave a request to help us with your search. For your convenience, you can use filters.',
      name: 'workSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Looking for a job`
  String get lookingForJob {
    return Intl.message(
      'Looking for a job',
      name: 'lookingForJob',
      desc: '',
      args: [],
    );
  }

  /// `Giving a job`
  String get givingJob {
    return Intl.message(
      'Giving a job',
      name: 'givingJob',
      desc: '',
      args: [],
    );
  }

  /// `example@gmail.com`
  String get emailHint {
    return Intl.message(
      'example@gmail.com',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `More discounts`
  String get moreDiscounts {
    return Intl.message(
      'More discounts',
      name: 'moreDiscounts',
      desc: '',
      args: [],
    );
  }

  /// `+38 099 000 00 00`
  String get phoneNumberHint {
    return Intl.message(
      '+38 099 000 00 00',
      name: 'phoneNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Discounts and coupons`
  String get discountsAndCoupons {
    return Intl.message(
      'Discounts and coupons',
      name: 'discountsAndCoupons',
      desc: '',
      args: [],
    );
  }

  /// `In this section you will find discounts and coupons from our partners. You can use filters for convenience.`
  String get discountsAndCouponsDescription {
    return Intl.message(
      'In this section you will find discounts and coupons from our partners. You can use filters for convenience.',
      name: 'discountsAndCouponsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Resume`
  String get resume {
    return Intl.message(
      'Resume',
      name: 'resume',
      desc: '',
      args: [],
    );
  }

  /// `I don't have a resume`
  String get noResume {
    return Intl.message(
      'I don\'t have a resume',
      name: 'noResume',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `In this section you can employ a veteran. If you have an open vacancy in your company, you can place an ad here.`
  String get employerSubtitle {
    return Intl.message(
      'In this section you can employ a veteran. If you have an open vacancy in your company, you can place an ad here.',
      name: 'employerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Main information`
  String get mainInformation {
    return Intl.message(
      'Main information',
      name: 'mainInformation',
      desc: '',
      args: [],
    );
  }

  /// `Position*`
  String get position {
    return Intl.message(
      'Position*',
      name: 'position',
      desc: '',
      args: [],
    );
  }

  /// `Write the proposed position`
  String get writeProposedPosition {
    return Intl.message(
      'Write the proposed position',
      name: 'writeProposedPosition',
      desc: '',
      args: [],
    );
  }

  /// `Salary*`
  String get wage {
    return Intl.message(
      'Salary*',
      name: 'wage',
      desc: '',
      args: [],
    );
  }

  /// `Write the salary`
  String get writeTheWage {
    return Intl.message(
      'Write the salary',
      name: 'writeTheWage',
      desc: '',
      args: [],
    );
  }

  /// `Select the city of work*`
  String get selectCityOfWork {
    return Intl.message(
      'Select the city of work*',
      name: 'selectCityOfWork',
      desc: '',
      args: [],
    );
  }

  /// `Select a city`
  String get selectCity {
    return Intl.message(
      'Select a city',
      name: 'selectCity',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get contacts {
    return Intl.message(
      'Contacts',
      name: 'contacts',
      desc: '',
      args: [],
    );
  }

  /// `Write how to contact you`
  String get howToContactYou {
    return Intl.message(
      'Write how to contact you',
      name: 'howToContactYou',
      desc: '',
      args: [],
    );
  }

  /// `Remotely`
  String get remotely {
    return Intl.message(
      'Remotely',
      name: 'remotely',
      desc: '',
      args: [],
    );
  }

  /// `My feedback`
  String get myFeedback {
    return Intl.message(
      'My feedback',
      name: 'myFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Didn't find your vacancy?`
  String get didNotFindYourVacancy {
    return Intl.message(
      'Didn\'t find your vacancy?',
      name: 'didNotFindYourVacancy',
      desc: '',
      args: [],
    );
  }

  /// `We can help. Fill in your details and job preferences in the following form and we will send your CV to relevant companies.`
  String get workRequestSubtitle {
    return Intl.message(
      'We can help. Fill in your details and job preferences in the following form and we will send your CV to relevant companies.',
      name: 'workRequestSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Leave a request`
  String get leaveRequest {
    return Intl.message(
      'Leave a request',
      name: 'leaveRequest',
      desc: '',
      args: [],
    );
  }

  /// `In this section, you can see all your saved materials`
  String get savesSubtitle {
    return Intl.message(
      'In this section, you can see all your saved materials',
      name: 'savesSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `In this section, you can share your life and service stories anonymously or openly. You can also support other participants.`
  String get storySubtitle {
    return Intl.message(
      'In this section, you can share your life and service stories anonymously or openly. You can also support other participants.',
      name: 'storySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Write your story`
  String get writeYourStory {
    return Intl.message(
      'Write your story',
      name: 'writeYourStory',
      desc: '',
      args: [],
    );
  }

  /// `More stories`
  String get moreStories {
    return Intl.message(
      'More stories',
      name: 'moreStories',
      desc: '',
      args: [],
    );
  }

  /// `Add your story`
  String get addYourStory {
    return Intl.message(
      'Add your story',
      name: 'addYourStory',
      desc: '',
      args: [],
    );
  }

  /// `Your story`
  String get yourStory {
    return Intl.message(
      'Your story',
      name: 'yourStory',
      desc: '',
      args: [],
    );
  }

  /// `Add Photo`
  String get addPhoto {
    return Intl.message(
      'Add Photo',
      name: 'addPhoto',
      desc: '',
      args: [],
    );
  }

  /// `(not necessarily)`
  String get notNecessarily {
    return Intl.message(
      '(not necessarily)',
      name: 'notNecessarily',
      desc: '',
      args: [],
    );
  }

  /// `Publish anonymously`
  String get publishAnonymously {
    return Intl.message(
      'Publish anonymously',
      name: 'publishAnonymously',
      desc: '',
      args: [],
    );
  }

  /// `Anonymous`
  String get anonymous {
    return Intl.message(
      'Anonymous',
      name: 'anonymous',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `If you post a story anonymously, readers will only be able to see your nickname in your profile.`
  String get publishAnonymouslyStorySubtitle {
    return Intl.message(
      'If you post a story anonymously, readers will only be able to see your nickname in your profile.',
      name: 'publishAnonymouslyStorySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Publish`
  String get publish {
    return Intl.message(
      'Publish',
      name: 'publish',
      desc: '',
      args: [],
    );
  }

  /// `Share your story and we will publish it on our website. All stories are moderated and will be published after review.`
  String get storyAddSubtitle {
    return Intl.message(
      'Share your story and we will publish it on our website. All stories are moderated and will be published after review.',
      name: 'storyAddSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out of your account?`
  String get logOutQuestion {
    return Intl.message(
      'Are you sure you want to log out of your account?',
      name: 'logOutQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get deleteAccountQuestion {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'deleteAccountQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `In this section you can manage your stories.`
  String get myStoryDetails {
    return Intl.message(
      'In this section you can manage your stories.',
      name: 'myStoryDetails',
      desc: '',
      args: [],
    );
  }

  /// `This page is under construction.`
  String get underConstruction {
    return Intl.message(
      'This page is under construction.',
      name: 'underConstruction',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `THIS SERVICE IS FOR VETERANS`
  String get thisServiceForVeterans {
    return Intl.message(
      'THIS SERVICE IS FOR VETERANS',
      name: 'thisServiceForVeterans',
      desc: '',
      args: [],
    );
  }

  /// `Here you can find useful information, benefits, discounts and share your story`
  String get thisServiceForVeteransSubtitle {
    return Intl.message(
      'Here you can find useful information, benefits, discounts and share your story',
      name: 'thisServiceForVeteransSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `What kind of project it is?`
  String get whatKindOfProject {
    return Intl.message(
      'What kind of project it is?',
      name: 'whatKindOfProject',
      desc: '',
      args: [],
    );
  }

  /// `An independent information platform for female and male veterans, which collects and systematizes data for easy search.`
  String get aboutProject {
    return Intl.message(
      'An independent information platform for female and male veterans, which collects and systematizes data for easy search.',
      name: 'aboutProject',
      desc: '',
      args: [],
    );
  }

  /// `To save money`
  String get saveMoney {
    return Intl.message(
      'To save money',
      name: 'saveMoney',
      desc: '',
      args: [],
    );
  }

  /// `Discounts and services`
  String get discountsServices {
    return Intl.message(
      'Discounts and services',
      name: 'discountsServices',
      desc: '',
      args: [],
    );
  }

  /// `Here you will find current offers for veterans and active military personnel that are updated in real time. Medical, service, catering, and clothing discounts are all available in this section.`
  String get discountsServicesSubtitle {
    return Intl.message(
      'Here you will find current offers for veterans and active military personnel that are updated in real time. Medical, service, catering, and clothing discounts are all available in this section.',
      name: 'discountsServicesSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `To Discount`
  String get toDiscount {
    return Intl.message(
      'To Discount',
      name: 'toDiscount',
      desc: '',
      args: [],
    );
  }

  /// `To find out`
  String get findOut {
    return Intl.message(
      'To find out',
      name: 'findOut',
      desc: '',
      args: [],
    );
  }

  /// `Information and news`
  String get informationNews {
    return Intl.message(
      'Information and news',
      name: 'informationNews',
      desc: '',
      args: [],
    );
  }

  /// `All information in one place. We have analyzed various resources and highlighted the rights and benefits for veterans in this section. It contains systematized data - the most important things a veteran needs to know. In this section, you can learn more about the guarantees provided by the state to veterans.`
  String get informationNewsSubtitle {
    return Intl.message(
      'All information in one place. We have analyzed various resources and highlighted the rights and benefits for veterans in this section. It contains systematized data - the most important things a veteran needs to know. In this section, you can learn more about the guarantees provided by the state to veterans.',
      name: 'informationNewsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `To information`
  String get toInfomation {
    return Intl.message(
      'To information',
      name: 'toInfomation',
      desc: '',
      args: [],
    );
  }

  /// `What you are most interested in`
  String get whatYouMostInterestedIn {
    return Intl.message(
      'What you are most interested in',
      name: 'whatYouMostInterestedIn',
      desc: '',
      args: [],
    );
  }

  /// `Answers to your questions`
  String get answersYourQuestions {
    return Intl.message(
      'Answers to your questions',
      name: 'answersYourQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Didn't find what you were looking for, want to get in touch, or have questions or requests? We are happy to talk to you! Please fill out the form below.`
  String get questionSubtitle {
    return Intl.message(
      'Didn\'t find what you were looking for, want to get in touch, or have questions or requests? We are happy to talk to you! Please fill out the form below.',
      name: 'questionSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Write message`
  String get writeMessage {
    return Intl.message(
      'Write message',
      name: 'writeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to support our project?`
  String get doYouWantSupportOurProject {
    return Intl.message(
      'Do you want to support our project?',
      name: 'doYouWantSupportOurProject',
      desc: '',
      args: [],
    );
  }

  /// `All rights reserved`
  String get allRightsReserved {
    return Intl.message(
      'All rights reserved',
      name: 'allRightsReserved',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Sections`
  String get sections {
    return Intl.message(
      'Sections',
      name: 'sections',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contact {
    return Intl.message(
      'Contact',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Jobs and vacancies`
  String get jobsVacancies {
    return Intl.message(
      'Jobs and vacancies',
      name: 'jobsVacancies',
      desc: '',
      args: [],
    );
  }

  /// `Information on current vacancies specifically targeted at veterans, as well as resources for job search and career development.`
  String get jobsVacanciesSubtitle {
    return Intl.message(
      'Information on current vacancies specifically targeted at veterans, as well as resources for job search and career development.',
      name: 'jobsVacanciesSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `To vacancies`
  String get toVacancy {
    return Intl.message(
      'To vacancies',
      name: 'toVacancy',
      desc: '',
      args: [],
    );
  }

  /// `To get it you need:`
  String get toGetItYouNeed {
    return Intl.message(
      'To get it you need:',
      name: 'toGetItYouNeed',
      desc: '',
      args: [],
    );
  }

  /// `Write`
  String get write {
    return Intl.message(
      'Write',
      name: 'write',
      desc: '',
      args: [],
    );
  }

  /// `a message`
  String get aMessage {
    return Intl.message(
      'a message',
      name: 'aMessage',
      desc: '',
      args: [],
    );
  }

  /// `us`
  String get us {
    return Intl.message(
      'us',
      name: 'us',
      desc: '',
      args: [],
    );
  }

  /// `Prefer e-mail?`
  String get preferEmail {
    return Intl.message(
      'Prefer e-mail?',
      name: 'preferEmail',
      desc: '',
      args: [],
    );
  }

  /// `Our social networks`
  String get ourSocialNetworks {
    return Intl.message(
      'Our social networks',
      name: 'ourSocialNetworks',
      desc: '',
      args: [],
    );
  }

  /// `By submitting this form, I accept the Privacy Policy of this site`
  String get feedbackFormSubtitle {
    return Intl.message(
      'By submitting this form, I accept the Privacy Policy of this site',
      name: 'feedbackFormSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Send message`
  String get sendMessage {
    return Intl.message(
      'Send message',
      name: 'sendMessage',
      desc: '',
      args: [],
    );
  }

  /// `Provide suggestions from businesses,`
  String get provideSuggestionsFromBusinesses {
    return Intl.message(
      'Provide suggestions from businesses,',
      name: 'provideSuggestionsFromBusinesses',
      desc: '',
      args: [],
    );
  }

  /// `or donate here`
  String get orDonateHere {
    return Intl.message(
      'or donate here',
      name: 'orDonateHere',
      desc: '',
      args: [],
    );
  }

  /// `Support our veterans`
  String get supportOurVeterans {
    return Intl.message(
      'Support our veterans',
      name: 'supportOurVeterans',
      desc: '',
      args: [],
    );
  }

  /// `Donate here`
  String get donateHere {
    return Intl.message(
      'Donate here',
      name: 'donateHere',
      desc: '',
      args: [],
    );
  }

  /// `Proven funds`
  String get provenFunds {
    return Intl.message(
      'Proven funds',
      name: 'provenFunds',
      desc: '',
      args: [],
    );
  }

  /// `Try it again`
  String get tryItAgain {
    return Intl.message(
      'Try it again',
      name: 'tryItAgain',
      desc: '',
      args: [],
    );
  }

  /// `The company is hidden`
  String get companyIsHidden {
    return Intl.message(
      'The company is hidden',
      name: 'companyIsHidden',
      desc: '',
      args: [],
    );
  }

  /// `All of Ukraine (online)`
  String get online {
    return Intl.message(
      'All of Ukraine (online)',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `More funds`
  String get moreFunds {
    return Intl.message(
      'More funds',
      name: 'moreFunds',
      desc: '',
      args: [],
    );
  }

  /// `Offer a discount`
  String get offerDiscount {
    return Intl.message(
      'Offer a discount',
      name: 'offerDiscount',
      desc: '',
      args: [],
    );
  }

  /// `In this section, you can publish a discount, as well as manage your publications. If your company provides personalized offers for veterans, you can advertise here.`
  String get myDiscountsAndCoupons {
    return Intl.message(
      'In this section, you can publish a discount, as well as manage your publications. If your company provides personalized offers for veterans, you can advertise here.',
      name: 'myDiscountsAndCoupons',
      desc: '',
      args: [],
    );
  }

  /// `My publications`
  String get myPublications {
    return Intl.message(
      'My publications',
      name: 'myPublications',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate`
  String get deactivate {
    return Intl.message(
      'Deactivate',
      name: 'deactivate',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `Special offers`
  String get specialOffers {
    return Intl.message(
      'Special offers',
      name: 'specialOffers',
      desc: '',
      args: [],
    );
  }

  /// `for veterans and their families`
  String get forVeteransAndTheirFamilies {
    return Intl.message(
      'for veterans and their families',
      name: 'forVeteransAndTheirFamilies',
      desc: '',
      args: [],
    );
  }

  /// `Advanced filter`
  String get advancedFilter {
    return Intl.message(
      'Advanced filter',
      name: 'advancedFilter',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Filter applied`
  String get filterApplied {
    return Intl.message(
      'Filter applied',
      name: 'filterApplied',
      desc: '',
      args: [],
    );
  }

  /// `From the largest to the smallest`
  String get fromLargestToSmallest {
    return Intl.message(
      'From the largest to the smallest',
      name: 'fromLargestToSmallest',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get free {
    return Intl.message(
      'Free',
      name: 'free',
      desc: '',
      args: [],
    );
  }

  /// `All establishments of the chain`
  String get allStoresOfChain {
    return Intl.message(
      'All establishments of the chain',
      name: 'allStoresOfChain',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Complaint`
  String get complaint {
    return Intl.message(
      'Complaint',
      name: 'complaint',
      desc: '',
      args: [],
    );
  }

  /// `Report a publication`
  String get reportPublication {
    return Intl.message(
      'Report a publication',
      name: 'reportPublication',
      desc: '',
      args: [],
    );
  }

  /// `Specify the reason for the complaint:`
  String get specifyReasonForComplaint {
    return Intl.message(
      'Specify the reason for the complaint:',
      name: 'specifyReasonForComplaint',
      desc: '',
      args: [],
    );
  }

  /// `Fraud or spam;`
  String get fraudOrSpam {
    return Intl.message(
      'Fraud or spam;',
      name: 'fraudOrSpam',
      desc: '',
      args: [],
    );
  }

  /// `Fake news or disinformation;`
  String get fakeNewsOrDisinformation {
    return Intl.message(
      'Fake news or disinformation;',
      name: 'fakeNewsOrDisinformation',
      desc: '',
      args: [],
    );
  }

  /// `Offensive or hateful content;`
  String get offensiveOrHatefulContent {
    return Intl.message(
      'Offensive or hateful content;',
      name: 'offensiveOrHatefulContent',
      desc: '',
      args: [],
    );
  }

  /// `Other (specify)`
  String get other {
    return Intl.message(
      'Other (specify)',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Add a comment:`
  String get addComment {
    return Intl.message(
      'Add a comment:',
      name: 'addComment',
      desc: '',
      args: [],
    );
  }

  /// `Please select one of the following answers`
  String get checkPointError {
    return Intl.message(
      'Please select one of the following answers',
      name: 'checkPointError',
      desc: '',
      args: [],
    );
  }

  /// `Verified information`
  String get verifiedInformation {
    return Intl.message(
      'Verified information',
      name: 'verifiedInformation',
      desc: '',
      args: [],
    );
  }

  /// `That's the end of the list! We hope you found what you were looking for.`
  String get thatEndOfList {
    return Intl.message(
      'That\'s the end of the list! We hope you found what you were looking for.',
      name: 'thatEndOfList',
      desc: '',
      args: [],
    );
  }

  /// `Return to the top`
  String get returnToTop {
    return Intl.message(
      'Return to the top',
      name: 'returnToTop',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, nothing was found using your filters. Try changing your search criteria`
  String get cardListEmptyText {
    return Intl.message(
      'Sorry, nothing was found using your filters. Try changing your search criteria',
      name: 'cardListEmptyText',
      desc: '',
      args: [],
    );
  }

  /// `of up to`
  String get ofUpTo {
    return Intl.message(
      'of up to',
      name: 'ofUpTo',
      desc: '',
      args: [],
    );
  }

  /// `We're sorry, there was an unforeseen error.`
  String get error {
    return Intl.message(
      'We\'re sorry, there was an unforeseen error.',
      name: 'error',
      desc: 'message of an unforeseen error that was not foreseen.',
      args: [],
    );
  }

  /// `There is no internet connection. Please check your connection.`
  String get networkFailure {
    return Intl.message(
      'There is no internet connection. Please check your connection.',
      name: 'networkFailure',
      desc: 'error message when connecting to the Internet connection',
      args: [],
    );
  }

  /// `An error occurred while loading some data.`
  String get getFailure {
    return Intl.message(
      'An error occurred while loading some data.',
      name: 'getFailure',
      desc: 'error message when trying to download data from firebase',
      args: [],
    );
  }

  /// `We're sorry, there was an unforeseen error while sending the data. Please try again later.`
  String get sendFailure {
    return Intl.message(
      'We\'re sorry, there was an unforeseen error while sending the data. Please try again later.',
      name: 'sendFailure',
      desc: 'error message when trying to send data to firebase',
      args: [],
    );
  }

  /// `The user with this password or address does not exist.`
  String get notFoundFailure {
    return Intl.message(
      'The user with this password or address does not exist.',
      name: 'notFoundFailure',
      desc:
          'error message when you try to log in to your account using incorrect data',
      args: [],
    );
  }

  /// `The user with E-mail exist.`
  String get dublicateFailure {
    return Intl.message(
      'The user with E-mail exist.',
      name: 'dublicateFailure',
      desc:
          'an error message when trying to register an account with the same email as an already registered account',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Useful`
  String get useful {
    return Intl.message(
      'Useful',
      name: 'useful',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get website {
    return Intl.message(
      'Website',
      name: 'website',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Web site`
  String get webSite {
    return Intl.message(
      'Web site',
      name: 'webSite',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `hide...`
  String get hideExpansion {
    return Intl.message(
      'hide...',
      name: 'hideExpansion',
      desc: '',
      args: [],
    );
  }

  /// `{count} more..`
  String moreCities(Object count) {
    return Intl.message(
      '$count more..',
      name: 'moreCities',
      desc: '',
      args: [count],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
