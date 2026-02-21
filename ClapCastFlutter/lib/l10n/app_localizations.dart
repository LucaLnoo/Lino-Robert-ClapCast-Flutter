import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @navExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get navExplore;

  /// No description provided for @navSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// No description provided for @actors.
  ///
  /// In en, this message translates to:
  /// **'Actors'**
  String get actors;

  /// No description provided for @movies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get movies;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @clickOrScan.
  ///
  /// In en, this message translates to:
  /// **'Click or Scan'**
  String get clickOrScan;

  /// No description provided for @movieImageFallback.
  ///
  /// In en, this message translates to:
  /// **'Movie image'**
  String get movieImageFallback;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterFemale.
  ///
  /// In en, this message translates to:
  /// **'F'**
  String get filterFemale;

  /// No description provided for @filterMale.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get filterMale;

  /// No description provided for @filterRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get filterRecent;

  /// No description provided for @filterOnlyFrench.
  ///
  /// In en, this message translates to:
  /// **'Only French'**
  String get filterOnlyFrench;

  /// No description provided for @actorSelection.
  ///
  /// In en, this message translates to:
  /// **'Actors Selection'**
  String get actorSelection;

  /// No description provided for @mostSearchedMaleActor.
  ///
  /// In en, this message translates to:
  /// **'Most searched male actor'**
  String get mostSearchedMaleActor;

  /// No description provided for @mostSearchedFemaleActor.
  ///
  /// In en, this message translates to:
  /// **'Most searched female actor'**
  String get mostSearchedFemaleActor;

  /// No description provided for @playedInFrench.
  ///
  /// In en, this message translates to:
  /// **'Played in French'**
  String get playedInFrench;

  /// No description provided for @playedInEnglish.
  ///
  /// In en, this message translates to:
  /// **'Played in English'**
  String get playedInEnglish;

  /// No description provided for @maleActor.
  ///
  /// In en, this message translates to:
  /// **'Male Actor'**
  String get maleActor;

  /// No description provided for @femaleActor.
  ///
  /// In en, this message translates to:
  /// **'Female Actor'**
  String get femaleActor;

  /// No description provided for @movieSelection.
  ///
  /// In en, this message translates to:
  /// **'Movies Selection'**
  String get movieSelection;

  /// No description provided for @popularMovies.
  ///
  /// In en, this message translates to:
  /// **'Popular Movies'**
  String get popularMovies;

  /// No description provided for @movies2020s.
  ///
  /// In en, this message translates to:
  /// **'2020\'s Movies'**
  String get movies2020s;

  /// No description provided for @movies2000s.
  ///
  /// In en, this message translates to:
  /// **'2000\'s Movies'**
  String get movies2000s;

  /// No description provided for @movies1990s.
  ///
  /// In en, this message translates to:
  /// **'1990\'s Movies'**
  String get movies1990s;

  /// No description provided for @frenchMovies.
  ///
  /// In en, this message translates to:
  /// **'French Movies'**
  String get frenchMovies;

  /// No description provided for @englishMovies.
  ///
  /// In en, this message translates to:
  /// **'English Movies'**
  String get englishMovies;

  /// No description provided for @noBiography.
  ///
  /// In en, this message translates to:
  /// **'No biography'**
  String get noBiography;

  /// No description provided for @knownFor.
  ///
  /// In en, this message translates to:
  /// **'Known for:'**
  String get knownFor;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get noDescription;

  /// No description provided for @distribution.
  ///
  /// In en, this message translates to:
  /// **'Distribution'**
  String get distribution;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
