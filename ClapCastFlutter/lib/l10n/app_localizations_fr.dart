// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get navExplore => 'Explorer';

  @override
  String get navSearch => 'Rechercher';

  @override
  String get actors => 'Acteurs';

  @override
  String get movies => 'Films';

  @override
  String get unknown => 'Inconnu';

  @override
  String get clickOrScan => 'Cliquez ou Scannez';

  @override
  String get movieImageFallback => 'Image du film';

  @override
  String get searchHint => 'Rechercher...';

  @override
  String get filter => 'Filtre';

  @override
  String get filterAll => 'Tous';

  @override
  String get filterFemale => 'F';

  @override
  String get filterMale => 'H';

  @override
  String get filterRecent => 'Récents';

  @override
  String get filterOnlyFrench => 'Français';
}
