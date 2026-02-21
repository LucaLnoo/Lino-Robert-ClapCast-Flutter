// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navExplore => 'Explore';

  @override
  String get navSearch => 'Search';

  @override
  String get actors => 'Actors';

  @override
  String get movies => 'Movies';

  @override
  String get unknown => 'Unknown';

  @override
  String get clickOrScan => 'Click or Scan';

  @override
  String get movieImageFallback => 'Movie image';

  @override
  String get searchHint => 'Search...';

  @override
  String get filter => 'Filter';

  @override
  String get filterAll => 'All';

  @override
  String get filterFemale => 'F';

  @override
  String get filterMale => 'M';

  @override
  String get filterRecent => 'Recent';

  @override
  String get filterOnlyFrench => 'Only French';
}
