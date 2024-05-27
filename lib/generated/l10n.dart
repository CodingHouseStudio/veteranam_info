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
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
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
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Veteran`
  String get logo {
    return Intl.message(
      'Veteran',
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

  /// `Reset all filter`
  String get resetAllFilter {
    return Intl.message(
      'Reset all filter',
      name: 'resetAllFilter',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get aboutUs {
    return Intl.message(
      'About us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `For investors`
  String get forInvestors {
    return Intl.message(
      'For investors',
      name: 'forInvestors',
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

  /// `Stories`
  String get stories {
    return Intl.message(
      'Stories',
      name: 'stories',
      desc: '',
      args: [],
    );
  }

  /// `Discounts & coupons`
  String get discountsCoupons {
    return Intl.message(
      'Discounts & coupons',
      name: 'discountsCoupons',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
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

  /// `Consultation online`
  String get consultationOnline {
    return Intl.message(
      'Consultation online',
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

  /// `Be anonymous`
  String get beAnonymous {
    return Intl.message(
      'Be anonymous',
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

  /// `Frequency ask question`
  String get faq {
    return Intl.message(
      'Frequency ask question',
      name: 'faq',
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

  /// `Write your suggenstions`
  String get writeYourSuggenstions {
    return Intl.message(
      'Write your suggenstions',
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

  /// `If you want to contact us, or have any questions or requests. We are happy to talk to you! Please fill out the form.`
  String get feedbackSubtitle {
    return Intl.message(
      'If you want to contact us, or have any questions or requests. We are happy to talk to you! Please fill out the form.',
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

  /// `E-mail`
  String get fullEmail {
    return Intl.message(
      'E-mail',
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

  /// `The user with this password or address does not exist`
  String get notFound {
    return Intl.message(
      'The user with this password or address does not exist',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `The user with this password or address exist`
  String get dublicate {
    return Intl.message(
      'The user with this password or address exist',
      name: 'dublicate',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while transferring data to the server`
  String get serverError {
    return Intl.message(
      'An error occurred while transferring data to the server',
      name: 'serverError',
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

  /// `Головна`
  String get mainScreen {
    return Intl.message(
      'Головна',
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

  /// `Знижки і купони`
  String get discountsAndCoupons {
    return Intl.message(
      'Знижки і купони',
      name: 'discountsAndCoupons',
      desc: '',
      args: [],
    );
  }

  /// `У цьому розділі ти знайдеш знижки і купони від наших партнерів. Для зручності можеш користуватися фільтрами.`
  String get discountsAndCouponsDescription {
    return Intl.message(
      'У цьому розділі ти знайдеш знижки і купони від наших партнерів. Для зручності можеш користуватися фільтрами.',
      name: 'discountsAndCouponsDescription',
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

  /// `Contacts*`
  String get contacts {
    return Intl.message(
      'Contacts*',
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
