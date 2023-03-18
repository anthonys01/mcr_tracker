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

  /// `Game`
  String get game {
    return Intl.message(
      'Game',
      name: 'game',
      desc: '',
      args: [],
    );
  }

  /// `East player`
  String get eastPlayer {
    return Intl.message(
      'East player',
      name: 'eastPlayer',
      desc: '',
      args: [],
    );
  }

  /// `West player`
  String get westPlayer {
    return Intl.message(
      'West player',
      name: 'westPlayer',
      desc: '',
      args: [],
    );
  }

  /// `South player`
  String get southPlayer {
    return Intl.message(
      'South player',
      name: 'southPlayer',
      desc: '',
      args: [],
    );
  }

  /// `North player`
  String get northPlayer {
    return Intl.message(
      'North player',
      name: 'northPlayer',
      desc: '',
      args: [],
    );
  }

  /// `5th player`
  String get fifthPlayer {
    return Intl.message(
      '5th player',
      name: 'fifthPlayer',
      desc: '',
      args: [],
    );
  }

  /// `East 1`
  String get east1 {
    return Intl.message(
      'East 1',
      name: 'east1',
      desc: '',
      args: [],
    );
  }

  /// `East 2`
  String get east2 {
    return Intl.message(
      'East 2',
      name: 'east2',
      desc: '',
      args: [],
    );
  }

  /// `East 3`
  String get east3 {
    return Intl.message(
      'East 3',
      name: 'east3',
      desc: '',
      args: [],
    );
  }

  /// `East 4`
  String get east4 {
    return Intl.message(
      'East 4',
      name: 'east4',
      desc: '',
      args: [],
    );
  }

  /// `West 1`
  String get west1 {
    return Intl.message(
      'West 1',
      name: 'west1',
      desc: '',
      args: [],
    );
  }

  /// `West 2`
  String get west2 {
    return Intl.message(
      'West 2',
      name: 'west2',
      desc: '',
      args: [],
    );
  }

  /// `West 3`
  String get west3 {
    return Intl.message(
      'West 3',
      name: 'west3',
      desc: '',
      args: [],
    );
  }

  /// `West 4`
  String get west4 {
    return Intl.message(
      'West 4',
      name: 'west4',
      desc: '',
      args: [],
    );
  }

  /// `South 1`
  String get south1 {
    return Intl.message(
      'South 1',
      name: 'south1',
      desc: '',
      args: [],
    );
  }

  /// `South 2`
  String get south2 {
    return Intl.message(
      'South 2',
      name: 'south2',
      desc: '',
      args: [],
    );
  }

  /// `South 3`
  String get south3 {
    return Intl.message(
      'South 3',
      name: 'south3',
      desc: '',
      args: [],
    );
  }

  /// `South 4`
  String get south4 {
    return Intl.message(
      'South 4',
      name: 'south4',
      desc: '',
      args: [],
    );
  }

  /// `North 1`
  String get north1 {
    return Intl.message(
      'North 1',
      name: 'north1',
      desc: '',
      args: [],
    );
  }

  /// `North 2`
  String get north2 {
    return Intl.message(
      'North 2',
      name: 'north2',
      desc: '',
      args: [],
    );
  }

  /// `North 3`
  String get north3 {
    return Intl.message(
      'North 3',
      name: 'north3',
      desc: '',
      args: [],
    );
  }

  /// `North 4`
  String get north4 {
    return Intl.message(
      'North 4',
      name: 'north4',
      desc: '',
      args: [],
    );
  }

  /// `CONTINUE`
  String get continueButton {
    return Intl.message(
      'CONTINUE',
      name: 'continueButton',
      desc: '',
      args: [],
    );
  }

  /// `VIEW`
  String get viewButton {
    return Intl.message(
      'VIEW',
      name: 'viewButton',
      desc: '',
      args: [],
    );
  }

  /// `DELETE`
  String get deleteButton {
    return Intl.message(
      'DELETE',
      name: 'deleteButton',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get required {
    return Intl.message(
      'Required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Start game`
  String get startGame {
    return Intl.message(
      'Start game',
      name: 'startGame',
      desc: '',
      args: [],
    );
  }

  /// `Finished`
  String get finished {
    return Intl.message(
      'Finished',
      name: 'finished',
      desc: '',
      args: [],
    );
  }

  /// `Game Score Sheet`
  String get scoreSheet {
    return Intl.message(
      'Game Score Sheet',
      name: 'scoreSheet',
      desc: '',
      args: [],
    );
  }

  /// `Delete last turn`
  String get deleteLastTurn {
    return Intl.message(
      'Delete last turn',
      name: 'deleteLastTurn',
      desc: '',
      args: [],
    );
  }

  /// `Turn end`
  String get turnEnd {
    return Intl.message(
      'Turn end',
      name: 'turnEnd',
      desc: '',
      args: [],
    );
  }

  /// `Hand value`
  String get handValue {
    return Intl.message(
      'Hand value',
      name: 'handValue',
      desc: '',
      args: [],
    );
  }

  /// `Winner`
  String get winner {
    return Intl.message(
      'Winner',
      name: 'winner',
      desc: '',
      args: [],
    );
  }

  /// `Giver`
  String get giver {
    return Intl.message(
      'Giver',
      name: 'giver',
      desc: '',
      args: [],
    );
  }

  /// `Needs to be higher than 8`
  String get moreThanEight {
    return Intl.message(
      'Needs to be higher than 8',
      name: 'moreThanEight',
      desc: '',
      args: [],
    );
  }

  /// `Add turn`
  String get addTurn {
    return Intl.message(
      'Add turn',
      name: 'addTurn',
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
      Locale.fromSubtags(languageCode: 'fr'),
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
