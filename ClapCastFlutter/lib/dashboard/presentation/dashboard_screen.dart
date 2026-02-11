import 'package:clapcastflutter/app/widgets/header.dart';
import 'package:clapcastflutter/starting/domain/starting_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/model/movie.dart';
import '../../app/model/person.dart';
import '../../app/widgets/ContentScrollRow.dart';
import '../../app/widgets/base_layout.dart';
import '../../app/widgets/background.dart';
import '../../detailed/presentation/detailed_screen.dart';
import '../../search/presentation/category_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<StartingNotifier>();

    return BaseLayout(
      currentIndex: 0,
      child: AppMenuBackground(
        child: SafeArea(
          child: Column(
            children: [
              const HeaderLogo(),
              NavigationBarHeader(
                selectedIndex: _selectedIndex,
                onTabSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildDynamicContent(notifier),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicContent(StartingNotifier notifier) {
    if (_selectedIndex == 0) {
      return _buildActorContent(notifier);
    } else {
      return _buildMovieContent(notifier);
    }
  }

  Widget _buildActorContent(StartingNotifier notifier) {
    final allPeople = notifier.people ?? [];
    if (allPeople.isEmpty) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        _buildActorRow("Actors Selection", allPeople.take(50).toList()..shuffle()),
        _buildActorRow("Most searched male actor", allPeople.where((person) => person.gender == 2).toList()..sort((a, b) => (b.popularityRate ?? 0).compareTo(a.popularityRate ?? 0))),
        _buildActorRow("Most searched female actor", allPeople.where((person) => person.gender == 1).toList()..sort((a, b) => (b.popularityRate ?? 0).compareTo(a.popularityRate ?? 0))),
        _buildActorRow("Played in French", allPeople.where((person) => person.knownForMovies.any((m) => m.language == "fr")).toList()..shuffle()),
        _buildActorRow("Played in English", allPeople.where((person) => person.knownForMovies.any((m) => m.language == "en")).toList()..shuffle()),
        _buildActorRow("Male Actor", allPeople.where((person) => person.gender == 2).toList()..shuffle()),
        _buildActorRow("Female Actor", allPeople.where((p) => p.gender == 1).toList()..shuffle()),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMovieContent(StartingNotifier notifier) {
    final allMovies = notifier.movies ?? [];
    if (allMovies.isEmpty) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        _buildMovieRow("Movies Selection", allMovies.take(50).toList()..shuffle()),
        _buildMovieRow("Popular Movies", allMovies.toList()..sort((a, b) => (b.popularityRate ?? 0).compareTo(a.popularityRate ?? 0))),
        _buildMovieRow("2020's Movies", allMovies.where((movie) => (movie.releaseYear ?? 0) >= 2020 && (movie.releaseYear ?? 0) < 2030).toList()..shuffle()),
        _buildMovieRow("2000's Movies", allMovies.where((movie) => (movie.releaseYear ?? 0) >= 2000 && (movie.releaseYear ?? 0) < 2010).toList()..shuffle()),
        _buildMovieRow("1990's Movies", allMovies.where((movie) => (movie.releaseYear ?? 0) >= 1990 && (movie.releaseYear ?? 0) < 2000).toList()..shuffle()),
        _buildMovieRow("French Movies", allMovies.where((movie) => movie.language == "fr").toList()..shuffle()),
        _buildMovieRow("English Movies", allMovies.where((movie) => movie.language == "en").toList()..shuffle()),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildActorRow(String title, List<PersonOverview> list) {
    return ContentScrollRowPeople(
      rowTitle: title,
      people: list.take(50).toList(),
      onPersonClick: (person) => _navigateToDetail(person.id, true),
      // "_" is set to ignore lambda parameter
      onMoreClick: (_) => _navigateToCategory(title, people: list, movies: []),
    );
  }

  Widget _buildMovieRow(String title, List<MovieOverview> list) {
    return ContentScrollRowMovie(
      rowTitle: title,
      movies: list.take(50).toList(),
      onMovieClick: (movie) => _navigateToDetail(movie.id, false),
      onMoreClick: (_) => _navigateToCategory(title, people: [], movies: list),
    );
  }

  void _navigateToDetail(int id, bool isPerson) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailedScreen(
          contentId: id,
          isAPerson: isPerson,
        ),
      ),
    );
  }

  void _navigateToCategory(String title, {required List<PersonOverview> people, required List<MovieOverview> movies}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(
          categoryTitle: title,
          people: people,
          movies: movies,
        ),
      ),
    );
  }
}