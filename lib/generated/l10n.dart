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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello`
  String get tittle {
    return Intl.message(
      'Hello',
      name: 'tittle',
      desc: '',
      args: [],
    );
  }

  /// `Welcom to your app`
  String get subtittle {
    return Intl.message(
      'Welcom to your app',
      name: 'subtittle',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get hintsearch {
    return Intl.message(
      'Search...',
      name: 'hintsearch',
      desc: '',
      args: [],
    );
  }

  /// `Medicine`
  String get medsearch {
    return Intl.message(
      'Medicine',
      name: 'medsearch',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get catsearch {
    return Intl.message(
      'Category',
      name: 'catsearch',
      desc: '',
      args: [],
    );
  }

  /// `All Companies`
  String get AllCompanies {
    return Intl.message(
      'All Companies',
      name: 'AllCompanies',
      desc: '',
      args: [],
    );
  }

  /// `My Favorite`
  String get MyFavorite {
    return Intl.message(
      'My Favorite',
      name: 'MyFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Info Profile`
  String get InfoProfile {
    return Intl.message(
      'Info Profile',
      name: 'InfoProfile',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get Notifications {
    return Intl.message(
      'Notifications',
      name: 'Notifications',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get Privacy {
    return Intl.message(
      'Privacy',
      name: 'Privacy',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get LogOut {
    return Intl.message(
      'Log Out',
      name: 'LogOut',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get Cart {
    return Intl.message(
      'Cart',
      name: 'Cart',
      desc: '',
      args: [],
    );
  }

  /// `TotalPrice`
  String get TotalPrice {
    return Intl.message(
      'TotalPrice',
      name: 'TotalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Check Out`
  String get CheckOut {
    return Intl.message(
      'Check Out',
      name: 'CheckOut',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get MyOrders {
    return Intl.message(
      'My Orders',
      name: 'MyOrders',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get Paid {
    return Intl.message(
      'Paid',
      name: 'Paid',
      desc: '',
      args: [],
    );
  }

  /// `NotPaid`
  String get NotPaid {
    return Intl.message(
      'NotPaid',
      name: 'NotPaid',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get Total {
    return Intl.message(
      'Total',
      name: 'Total',
      desc: '',
      args: [],
    );
  }

  /// `OrderState`
  String get OrderState {
    return Intl.message(
      'OrderState',
      name: 'OrderState',
      desc: '',
      args: [],
    );
  }

  /// `PaymentState`
  String get PaymentState {
    return Intl.message(
      'PaymentState',
      name: 'PaymentState',
      desc: '',
      args: [],
    );
  }

  /// `Deaitils of Order`
  String get DeaitilsofOrder {
    return Intl.message(
      'Deaitils of Order',
      name: 'DeaitilsofOrder',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get Quantity {
    return Intl.message(
      'Quantity',
      name: 'Quantity',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get Price {
    return Intl.message(
      'Price',
      name: 'Price',
      desc: '',
      args: [],
    );
  }

  /// `Deatils`
  String get Deatils {
    return Intl.message(
      'Deatils',
      name: 'Deatils',
      desc: '',
      args: [],
    );
  }

  /// `All Categories`
  String get AllCategories {
    return Intl.message(
      'All Categories',
      name: 'AllCategories',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get Categories {
    return Intl.message(
      'Categories',
      name: 'Categories',
      desc: '',
      args: [],
    );
  }

  /// `All Medicines`
  String get AllMedicines {
    return Intl.message(
      'All Medicines',
      name: 'AllMedicines',
      desc: '',
      args: [],
    );
  }

  /// `Medicines`
  String get Medicines {
    return Intl.message(
      'Medicines',
      name: 'Medicines',
      desc: '',
      args: [],
    );
  }

  /// `DeatilsMedicin`
  String get DeatilsMedicin {
    return Intl.message(
      'DeatilsMedicin',
      name: 'DeatilsMedicin',
      desc: '',
      args: [],
    );
  }

  /// `ADD TO CART`
  String get ADDTOCART {
    return Intl.message(
      'ADD TO CART',
      name: 'ADDTOCART',
      desc: '',
      args: [],
    );
  }

  /// `Expires`
  String get Expires {
    return Intl.message(
      'Expires',
      name: 'Expires',
      desc: '',
      args: [],
    );
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
