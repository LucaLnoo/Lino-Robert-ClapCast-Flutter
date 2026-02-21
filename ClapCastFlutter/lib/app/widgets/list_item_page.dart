import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../app/widgets/background.dart';
import '../../app/widgets/header.dart';
import '../../ressources/app_color.dart';
import '../model/movie.dart';
import '../model/person.dart';
import 'filterBox.dart';
import 'button.dart';

class MediaListLayout extends StatefulWidget {
  final String title;
  final List<PersonOverview> people;
  final List<MovieOverview> movies;
  final Function(int id, bool isPerson) onContentClick;
  final VoidCallback onBackClick;
  final Function(String query)? onSearchQueryChanged;

  const MediaListLayout({
    super.key,
    required this.title,
    required this.people,
    required this.movies,
    required this.onContentClick,
    required this.onBackClick,
    this.onSearchQueryChanged,
  });

  @override
  State<MediaListLayout> createState() => _MediaListLayoutState();
}

class _MediaListLayoutState extends State<MediaListLayout> {
  // états
  String _searchText = "";
  bool _showFilters = false;

  // Filtres
  bool _isActorFilter = true;
  bool _isMovieFilter = true;
  int _genderFilter = 0; // 0: Tous, 1: Femme, 2: Homme
  bool _isRecentFilter = false;
  bool _onlyFrenchFilter = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bool isApiSearch = widget.onSearchQueryChanged != null;

    final filteredPeople = _filterPeopleLocally(applyTextFilter: !isApiSearch);
    final filteredMovies = _filterMoviesLocally(applyTextFilter: !isApiSearch);

    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: Stack(
        children: [
          AppMenuBackground(
            child: SafeArea(
              child: Column(
                children: [
                  SectionBar(
                    sectionName: widget.title,
                    onBackClick: widget.onBackClick,
                  ),

                  Material(
                    type: MaterialType.transparency,
                    child: SearchBarWidget(
                      query: _searchText,
                      onQueryChange: (val) {
                        setState(() => _searchText = val);
                        widget.onSearchQueryChanged?.call(val);
                      },
                      onSearchClick: () {
                        FocusScope.of(context).unfocus();
                      },
                      isFilterOpen: _showFilters,
                      onFilterToggle: (isOpen) {
                        setState(() {
                          _showFilters = isOpen;
                        });
                      },
                    ),
                  ),

                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        if (_isActorFilter && filteredPeople.isNotEmpty) ...[
                          _buildSectionHeader(l10n.actors),
                          _buildGrid(
                            itemCount: filteredPeople.length,
                            itemBuilder: (context, index) {
                              final person = filteredPeople[index];
                              return MediaCardButton(
                                text: person.name ?? l10n.unknown,
                                imagePath: person.profilePathImage ?? "",
                                onClick: () =>
                                    widget.onContentClick(person.id, true),
                              );
                            },
                          ),
                        ],

                        if (_isMovieFilter && filteredMovies.isNotEmpty) ...[
                          _buildSectionHeader(l10n.movies),
                          _buildGrid(
                            itemCount: filteredMovies.length,
                            itemBuilder: (context, index) {
                              final movie = filteredMovies[index];
                              return MediaCardButton(
                                text: movie.title ?? l10n.unknown,
                                imagePath: movie.posterPathImage ?? "",
                                onClick: () =>
                                    widget.onContentClick(movie.id, false),
                              );
                            },
                          ),
                        ],

                        const SliverToBoxAdapter(child: SizedBox(height: 20)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (_showFilters)
            Positioned(
              top: 135,
              right: 16,
              child: Center(
                child: FilterWidget(
                  isActorFilter: _isActorFilter,
                  onActorFilterChange: (v) =>
                      setState(() => _isActorFilter = v),
                  isMovieFilter: _isMovieFilter,
                  onMovieFilterChange: (v) =>
                      setState(() => _isMovieFilter = v),
                  genderFilter: _genderFilter,
                  onGenderChange: (v) => setState(() => _genderFilter = v),
                  isRecentFilter: _isRecentFilter,
                  onRecentChange: (v) => setState(() => _isRecentFilter = v),
                  onlyFrenchFilter: _onlyFrenchFilter,
                  onOnlyFrenchFilter: (v) =>
                      setState(() => _onlyFrenchFilter = v),
                  onDismiss: () => setState(() => _showFilters = false),
                ),
              ),
            ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildSectionHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.appContrast,
                fontSize: 24,
              ),
            ),
            const Divider(color: AppColor.appContrast, thickness: 1),
          ],
        ),
      ),
    );
  }

  SliverGrid _buildGrid(
      {required int itemCount, required IndexedWidgetBuilder itemBuilder}) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.62,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 16.0,
      ),
    );
  }

  List<PersonOverview> _filterPeopleLocally({required bool applyTextFilter}) {
    final queryCleaned = applyTextFilter ? _searchText
        .replaceAll(" ", "")
        .toLowerCase() : "";

    return widget.people.where((person) {
      // 1. Texte
      final nameCleaned = (person.name?.replaceAll(" ", "") ?? "")
          .toLowerCase();
      final matchesText = queryCleaned.isEmpty ||
          nameCleaned.contains(queryCleaned);

      // 2. Genre (0: All, 1: F, 2: M)
      bool matchesGender = true;
      if (_genderFilter != 0) {
        matchesGender = person.gender == _genderFilter;
      }

      // 3. Français Only
      bool matchesFrench = true;
      if (_onlyFrenchFilter) {
        if (person.knownForMovies.isNotEmpty) {
          try {
            matchesFrench = person.knownForMovies.any((m) =>
                (m.language ?? "").toLowerCase().startsWith("fr"));
          } catch (e) {
            matchesFrench = false;
          }
        } else {
          matchesFrench = false;
        }
      }

      // 4. Image requise
      final hasImage = person.profilePathImage != null &&
          person.profilePathImage!.isNotEmpty;

      return matchesText && matchesGender && matchesFrench && hasImage;
    }).toList();
  }

  List<MovieOverview> _filterMoviesLocally({required bool applyTextFilter}) {
    final queryCleaned = applyTextFilter ? _searchText
        .replaceAll(" ", "")
        .toLowerCase() : "";

    return widget.movies.where((movie) {
      // 1. Texte
      final titleCleaned = (movie.title?.replaceAll(" ", "") ?? "")
          .toLowerCase();
      final matchesText = queryCleaned.isEmpty ||
          titleCleaned.contains(queryCleaned);

      // 2. Récent (2020+)
      bool matchesRecent = true;
      if (_isRecentFilter) {
        int year = 0;
        if (movie.releaseDate != null && movie.releaseDate!.length >= 4) {
          year = int.tryParse(movie.releaseDate!.substring(0, 4)) ?? 0;
        }
        matchesRecent = year >= 2020 && year <= 2029;
      }

      // 3. Français Only
      bool matchesFrench = true;
      if (_onlyFrenchFilter) {
        matchesFrench = (movie.language ?? "").toLowerCase().startsWith("fr");
      }

      // 4. Image requise
      final hasImage = movie.posterPathImage != null &&
          movie.posterPathImage!.isNotEmpty;

      return matchesText && matchesRecent && matchesFrench && hasImage;
    }).toList();
  }
}