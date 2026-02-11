import 'package:clapcastflutter/app/widgets/header.dart';
import 'package:clapcastflutter/starting/domain/starting_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/widgets/ContentScrollRow.dart';
import '../../app/widgets/base_layout.dart';
import '../../app/widgets/background.dart';

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
    final people = notifier.people ?? [];

    if (people.isEmpty) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        ContentScrollRowPeople(
          rowTitle: "Actors Selection",
          // .. allow to return the object and not the result of the shuffle function (which is void)
          people: people
              .take(50)
              .toList()
              ..shuffle(),
          onPersonClick: (person) => _navigateToDetail(person.id, true),
          onMoreClick: (list) {},
        ),

        ContentScrollRowPeople(
          rowTitle: "Most searched male actor",
          people: people
              .where((person) => person.gender == 2)
              .take(50)
              .toList()
              ..sort((a, b) => (b.popularityRate ?? 0).compareTo(a.popularityRate ?? 0)),
          onPersonClick: (person) => _navigateToDetail(person.id, true),
          onMoreClick: (list) {},
        ),

        ContentScrollRowPeople(
          rowTitle: "Most searched female actor",
          people: people
              .where((person) => person.gender == 1)
              .take(50)
              .toList()
              ..sort((a, b) => (b.popularityRate ?? 0).compareTo(a.popularityRate ?? 0)),
          onPersonClick: (person) => _navigateToDetail(person.id, true),
          onMoreClick: (list) {},
        ),

        ContentScrollRowPeople(
          rowTitle: "Played in French",
          people: people
              .where((person) => person.knownForMovies.any((moviePlayedIn) => moviePlayedIn.language == "fr"))
              .take(50)
              .toList()
              ..shuffle(),
          onPersonClick: (person) => _navigateToDetail(person.id, true),
          onMoreClick: (list) {},
        ),

        ContentScrollRowPeople(
          rowTitle: "Played in English",
          people: people
              .where((person) => person.knownForMovies.any((moviePlayedIn) => moviePlayedIn.language == "en"))
              .take(50)
              .toList()
              ..shuffle(),
          onPersonClick: (person) => _navigateToDetail(person.id, true),
          onMoreClick: (list) {},
        ),

        ContentScrollRowPeople(
          rowTitle: "Male Actor",
          people: people
              .where((person) => person.gender == 2)
              .take(50)
              .toList()
              ..shuffle(),
          onPersonClick: (person) => _navigateToDetail(person.id, true),
          onMoreClick: (list) {},
        ),

        ContentScrollRowPeople(
          rowTitle: "Female Actor",
          people: people
              .where((person) => person.gender == 1)
              .take(50)
              .toList()
            ..shuffle(),
          onPersonClick: (person) => _navigateToDetail(person.id, true),
          onMoreClick: (list) {},
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMovieContent(StartingNotifier notifier) {
    final movies = notifier.movies ?? [];

    if (movies.isEmpty) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        ContentScrollRowMovie(
          rowTitle: "Movies Selection",
          movies: movies
              .take(50)
              .toList()
              ..shuffle(),
          onMovieClick: (movie) => _navigateToDetail(movie.id, false),
          onMoreClick: (list) {},
        ),

        ContentScrollRowMovie(
          rowTitle: "Popular Movies",
          movies: movies
                .take(50)
                .toList()
                ..sort((a, b) => (b.popularityRate ?? 0).compareTo(a.popularityRate ?? 0)),
          onMovieClick: (movie) => _navigateToDetail(movie.id, false),
          onMoreClick: (list) {},
        ),

        ContentScrollRowMovie(
          rowTitle: "2020's Movies",
          movies: movies
              .where((m) => (m.releaseYear ?? 0) >= 2020 && (m.releaseYear ?? 0) < 2030)
              .take(50)
              .toList()
              ..shuffle(),
          onMovieClick: (movie) => _navigateToDetail(movie.id, false),
          onMoreClick: (list) {},
        ),

        ContentScrollRowMovie(
          rowTitle: "2000's Movies",
          movies: movies
              .where((m) => (m.releaseYear ?? 0) >= 2000 && (m.releaseYear ?? 0) < 2010)
              .take(50)
              .toList()
              ..shuffle(),
          onMovieClick: (movie) => _navigateToDetail(movie.id, false),
          onMoreClick: (list) {},
        ),

        ContentScrollRowMovie(
          rowTitle: "1990's Movies",
          movies: movies
              .where((m) => (m.releaseYear ?? 0) >= 1990 && (m.releaseYear ?? 0) < 2000)
              .take(50)
              .toList()
              ..shuffle(),
          onMovieClick: (movie) => _navigateToDetail(movie.id, false),
          onMoreClick: (list) {},
        ),

        ContentScrollRowMovie(
          rowTitle: "French Movies",
          movies: movies
              .where((m) => m.language == "fr")
              .take(50)
              .toList()
              ..shuffle(),
          onMovieClick: (movie) => _navigateToDetail(movie.id, false),
          onMoreClick: (list) {},
        ),

        ContentScrollRowMovie(
          rowTitle: "English Movies",
          movies: movies
              .where((m) => m.language == "en")
              .take(50)
              .toList()
              ..shuffle(),
          onMovieClick: (movie) => _navigateToDetail(movie.id, false),
          onMoreClick: (list) {},
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  void _navigateToDetail(int id, bool isPerson) {
    // Navigator.pushNamed(context, '/detail', arguments: {'id': id, 'isPerson': isPerson});
  }
}