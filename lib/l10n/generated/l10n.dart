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

  /// `Dance Studios`
  String get appTitle {
    return Intl.message(
      'Dance Studios',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Dance Studios Map`
  String get appTitleMap {
    return Intl.message(
      'Dance Studios Map',
      name: 'appTitleMap',
      desc: '',
      args: [],
    );
  }

  /// `Studio Details`
  String get appTitleDetails {
    return Intl.message(
      'Studio Details',
      name: 'appTitleDetails',
      desc: '',
      args: [],
    );
  }

  /// `Book Now`
  String get bookNow {
    return Intl.message(
      'Book Now',
      name: 'bookNow',
      desc: '',
      args: [],
    );
  }

  /// `Booking...`
  String get booking {
    return Intl.message(
      'Booking...',
      name: 'booking',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Dance Styles`
  String get danceStyles {
    return Intl.message(
      'Dance Styles',
      name: 'danceStyles',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Search by Dance Styles`
  String get searchDanceStyles {
    return Intl.message(
      'Search by Dance Styles',
      name: 'searchDanceStyles',
      desc: '',
      args: [],
    );
  }

  /// `Filter by Dance Style`
  String get filterByDanceStyle {
    return Intl.message(
      'Filter by Dance Style',
      name: 'filterByDanceStyle',
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

  /// `No studios found.`
  String get noStudiosFound {
    return Intl.message(
      'No studios found.',
      name: 'noStudiosFound',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch dance studios.`
  String get errorFetchingStudios {
    return Intl.message(
      'Failed to fetch dance studios.',
      name: 'errorFetchingStudios',
      desc: '',
      args: [],
    );
  }

  /// `Failed to book dance studio. Please try again.`
  String get errorBookingStudio {
    return Intl.message(
      'Failed to book dance studio. Please try again.',
      name: 'errorBookingStudio',
      desc: '',
      args: [],
    );
  }

  /// `Booking Confirmed`
  String get bookingConfirmed {
    return Intl.message(
      'Booking Confirmed',
      name: 'bookingConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Your booking has been successfully confirmed!`
  String get bookingConfirmationMessage {
    return Intl.message(
      'Your booking has been successfully confirmed!',
      name: 'bookingConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Studios`
  String get studios {
    return Intl.message(
      'Studios',
      name: 'studios',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
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
