import 'package:flutter/material.dart';
import '../../app/widgets/background.dart';
import '../../app/widgets/header.dart';
import '../../ressources/app_color.dart';
import '../model/movie.dart';
import '../model/person.dart';

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
  String _searchText = "";
  bool _showFilters = false;
  bool _isActorFilter = true;
  bool _isMovieFilter = true;

  @override
  Widget build(BuildContext context) {
    final bool isApiSearch = widget.onSearchQueryChanged != null;

    final filteredPeople = isApiSearch ? widget.people : _filterPeopleLocally();
    final filteredMovies = isApiSearch ? widget.movies : _filterMoviesLocally();

    return AppMenuBackground(
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

            if (_showFilters)
              _buildFilterToggles(),

            Expanded(
              child: CustomScrollView(
                slivers: [
                  if (_isActorFilter && filteredPeople.isNotEmpty) ...[
                    _buildSectionHeader("Acteurs"),
                    _buildGrid(
                      itemCount: filteredPeople.length,
                      itemBuilder: (context, index) {
                        final person = filteredPeople[index];

                        return MediaCardButton(
                          text: person.name ?? "Inconnu",
                          imagePath: person.profilePathImage ?? "",
                          onClick: () => widget.onContentClick(person.id, true),
                        );
                      },
                    ),
                  ],

                  if (_isMovieFilter && filteredMovies.isNotEmpty) ...[
                    _buildSectionHeader("Films"),
                    _buildGrid(
                      itemCount: filteredMovies.length,
                      itemBuilder: (context, index) {
                        final movie = filteredMovies[index];

                        return MediaCardButton(
                          text: movie.title ?? "Inconnu",
                          imagePath: movie.posterPathImage ?? "",
                          onClick: () => widget.onContentClick(movie.id, false),
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
    );
  }

  Widget _buildFilterToggles() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        type: MaterialType.transparency,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            FilterChip(
              label: const Text("Acteurs"),
              selected: _isActorFilter,
              onSelected: (val) => setState(() => _isActorFilter = val),
              selectedColor: AppColor.btnPrimary,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: _isActorFilter ? Colors.white : Colors.black,
              ),
            ),
            FilterChip(
              label: const Text("Films"),
              selected: _isMovieFilter,
              onSelected: (val) => setState(() => _isMovieFilter = val),
              selectedColor: AppColor.btnPrimary,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: _isMovieFilter ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
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

  SliverGrid _buildGrid({required int itemCount, required IndexedWidgetBuilder itemBuilder}) {
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

  List<PersonOverview> _filterPeopleLocally() {
    final queryCleaned = _searchText.replaceAll(" ", "").toLowerCase();
    return widget.people.where((person) {
      final nameCleaned = (person.name?.replaceAll(" ", "") ?? "").toLowerCase();
      return queryCleaned.isEmpty || nameCleaned.contains(queryCleaned);
    }).toList();
  }

  List<MovieOverview> _filterMoviesLocally() {
    final queryCleaned = _searchText.replaceAll(" ", "").toLowerCase();
    return widget.movies.where((movie) {
      final titleCleaned = (movie.title?.replaceAll(" ", "") ?? "").toLowerCase();
      return queryCleaned.isEmpty || titleCleaned.contains(queryCleaned);
    }).toList();
  }
}