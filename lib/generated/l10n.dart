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

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Recharge Snap`
  String get appTitle {
    return Intl.message('Recharge Snap', name: 'appTitle', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Canceled`
  String get canceled {
    return Intl.message('Canceled', name: 'canceled', desc: '', args: []);
  }

  /// `Can't Pick Image`
  String get cantPickImage {
    return Intl.message(
      'Can\'t Pick Image',
      name: 'cantPickImage',
      desc: '',
      args: [],
    );
  }

  /// `Can't Recognize Text`
  String get cantRecognizeText {
    return Intl.message(
      'Can\'t Recognize Text',
      name: 'cantRecognizeText',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Copied to clipboard`
  String get copiedToClipboard {
    return Intl.message(
      'Copied to clipboard',
      name: 'copiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message('Copy', name: 'copy', desc: '', args: []);
  }

  /// `Is this the correct number?`
  String get correctNumberQuestion {
    return Intl.message(
      'Is this the correct number?',
      name: 'correctNumberQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch phone app`
  String get couldNotLaunchPhone {
    return Intl.message(
      'Could not launch phone app',
      name: 'couldNotLaunchPhone',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Enter card number`
  String get enterCardNumber {
    return Intl.message(
      'Enter card number',
      name: 'enterCardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Etisalat`
  String get etisalat {
    return Intl.message('Etisalat', name: 'etisalat', desc: '', args: []);
  }

  /// `Is this the correct number?`
  String get isThisCorrectNumber {
    return Intl.message(
      'Is this the correct number?',
      name: 'isThisCorrectNumber',
      desc: '',
      args: [],
    );
  }

  /// `en`
  String get languageCode {
    return Intl.message('en', name: 'languageCode', desc: '', args: []);
  }

  /// `No numbers detected`
  String get noNumbersDetected {
    return Intl.message(
      'No numbers detected',
      name: 'noNumbersDetected',
      desc: '',
      args: [],
    );
  }

  /// `Number Detected`
  String get numberDetected {
    return Intl.message(
      'Number Detected',
      name: 'numberDetected',
      desc: '',
      args: [],
    );
  }

  /// `OR ENTER MANUALLY`
  String get orEnterManually {
    return Intl.message(
      'OR ENTER MANUALLY',
      name: 'orEnterManually',
      desc: '',
      args: [],
    );
  }

  /// `Orange`
  String get orange {
    return Intl.message('Orange', name: 'orange', desc: '', args: []);
  }

  /// `Pick Image`
  String get pickImage {
    return Intl.message('Pick Image', name: 'pickImage', desc: '', args: []);
  }

  /// `Please enter a valid number`
  String get pleaseEnterValidNumber {
    return Intl.message(
      'Please enter a valid number',
      name: 'pleaseEnterValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Recharge Now`
  String get rechargeNow {
    return Intl.message(
      'Recharge Now',
      name: 'rechargeNow',
      desc: '',
      args: [],
    );
  }

  /// `Your {provider} card has been recharged successfully`
  String rechargeSuccessMessage(Object provider) {
    return Intl.message(
      'Your $provider card has been recharged successfully',
      name: 'rechargeSuccessMessage',
      desc: '',
      args: [provider],
    );
  }

  /// `Recharge Successful!`
  String get rechargeSuccessful {
    return Intl.message(
      'Recharge Successful!',
      name: 'rechargeSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Scan Code`
  String get scanCode {
    return Intl.message('Scan Code', name: 'scanCode', desc: '', args: []);
  }

  /// `Scan Code Using Camera`
  String get scanCodeUsingCamera {
    return Intl.message(
      'Scan Code Using Camera',
      name: 'scanCodeUsingCamera',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Image`
  String get selectImage {
    return Intl.message(
      'Please Select Image',
      name: 'selectImage',
      desc: '',
      args: [],
    );
  }

  /// `Select Provider`
  String get selectProvider {
    return Intl.message(
      'Select Provider',
      name: 'selectProvider',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Vodafone`
  String get vodafone {
    return Intl.message('Vodafone', name: 'vodafone', desc: '', args: []);
  }

  /// `We`
  String get we {
    return Intl.message('We', name: 'we', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Default Provider`
  String get defaultProvider {
    return Intl.message(
      'Default Provider',
      name: 'defaultProvider',
      desc: '',
      args: [],
    );
  }

  /// `{provider} Is Default`
  String providerSetSuccess(Object provider) {
    return Intl.message(
      '$provider Is Default',
      name: 'providerSetSuccess',
      desc: '',
      args: [provider],
    );
  }

  /// `Turn Flash On`
  String get flashOn {
    return Intl.message('Turn Flash On', name: 'flashOn', desc: '', args: []);
  }

  /// `Turn Flash Off`
  String get flashOff {
    return Intl.message('Turn Flash Off', name: 'flashOff', desc: '', args: []);
  }

  /// `Scan Again`
  String get scanAgain {
    return Intl.message('Scan Again', name: 'scanAgain', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Align text within frame`
  String get alignTextWithinFrame {
    return Intl.message(
      'Align text within frame',
      name: 'alignTextWithinFrame',
      desc: '',
      args: [],
    );
  }

  /// `Processing...`
  String get processing {
    return Intl.message(
      'Processing...',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `El ZoOoZ`
  String get elzoz {
    return Intl.message('El ZoOoZ', name: 'elzoz', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
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
