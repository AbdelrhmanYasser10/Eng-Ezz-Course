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

  /// `Choose Products`
  String get chooseProducts {
    return Intl.message(
      'Choose Products',
      name: 'chooseProducts',
      desc: '',
      args: [],
    );
  }

  /// `Make Payment`
  String get makePayment {
    return Intl.message(
      'Make Payment',
      name: 'makePayment',
      desc: '',
      args: [],
    );
  }

  /// `Get Your Order`
  String get getYourOrder {
    return Intl.message(
      'Get Your Order',
      name: 'getYourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.`
  String get onboardingDesc {
    return Intl.message(
      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      name: 'onboardingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Prev`
  String get prev {
    return Intl.message('Prev', name: 'prev', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Welcome\nBack!`
  String get welcomeBack {
    return Intl.message(
      'Welcome\nBack!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Login successfully`
  String get loginSuccessfully {
    return Intl.message(
      'Login successfully',
      name: 'loginSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Congrats !! :)`
  String get congrats {
    return Intl.message('Congrats !! :)', name: 'congrats', desc: '', args: []);
  }

  /// `Credential Error`
  String get credentialError {
    return Intl.message(
      'Credential Error',
      name: 'credentialError',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `- OR Continue with -`
  String get orContinueWith {
    return Intl.message(
      '- OR Continue with -',
      name: 'orContinueWith',
      desc: '',
      args: [],
    );
  }

  /// `Don't have account? `
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have account? ',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Create\nAccount`
  String get createAccount {
    return Intl.message(
      'Create\nAccount',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation doesn't match the password`
  String get confirmPasswordError {
    return Intl.message(
      'Confirmation doesn\'t match the password',
      name: 'confirmPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Error while register`
  String get errorWhileRegister {
    return Intl.message(
      'Error while register',
      name: 'errorWhileRegister',
      desc: '',
      args: [],
    );
  }

  /// `Register Successfully`
  String get registerSuccessfully {
    return Intl.message(
      'Register Successfully',
      name: 'registerSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Already Have account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already Have account? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Search for product .....`
  String get searchForProduct {
    return Intl.message(
      'Search for product .....',
      name: 'searchForProduct',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Offers`
  String get offers {
    return Intl.message('Offers', name: 'offers', desc: '', args: []);
  }

  /// `Products`
  String get products {
    return Intl.message('Products', name: 'products', desc: '', args: []);
  }

  /// `Search...`
  String get search {
    return Intl.message('Search...', name: 'search', desc: '', args: []);
  }

  /// `No matched products`
  String get noMatchedProducts {
    return Intl.message(
      'No matched products',
      name: 'noMatchedProducts',
      desc: '',
      args: [],
    );
  }

  /// `Enter your message ....`
  String get enterYourMessage {
    return Intl.message(
      'Enter your message ....',
      name: 'enterYourMessage',
      desc: '',
      args: [],
    );
  }

  /// `Message cannot be empty`
  String get messageCannotBeEmpty {
    return Intl.message(
      'Message cannot be empty',
      name: 'messageCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `أضغط للتغيير للغة العربية`
  String get lang_hint {
    return Intl.message(
      'أضغط للتغيير للغة العربية',
      name: 'lang_hint',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get dark_mode_hint {
    return Intl.message(
      'Dark mode',
      name: 'dark_mode_hint',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Product Details`
  String get productDetails {
    return Intl.message(
      'Product Details',
      name: 'productDetails',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message('Read more', name: 'readMore', desc: '', args: []);
  }

  /// `Show less`
  String get showLess {
    return Intl.message('Show less', name: 'showLess', desc: '', args: []);
  }

  /// `Similar Products`
  String get similarProducts {
    return Intl.message(
      'Similar Products',
      name: 'similarProducts',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `EGP`
  String get egp {
    return Intl.message('EGP', name: 'egp', desc: '', args: []);
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
