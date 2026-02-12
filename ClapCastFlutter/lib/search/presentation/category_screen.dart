import 'package:clapcastflutter/app/model/movie.dart';
import 'package:clapcastflutter/app/model/person.dart';
import 'package:clapcastflutter/app/widgets/base_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/widgets/list_item_page.dart';
import '../../detailed/presentation/detailed_screen.dart';

class CategoryScreen extends StatelessWidget {
  final List<PersonOverview> people;
  final List<MovieOverview> movies;
  final String categoryTitle;

  const CategoryScreen({
    super.key,
    required this.people,
    required this.movies,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      currentIndex: 1,
      child: MediaListLayout(
        title: categoryTitle,
        people: people,
        movies: movies,
        onContentClick: (id, isPerson) => _navigateToDetail(context, id, isPerson),
        onBackClick: () => Navigator.pop(context),
        onSearchQueryChanged: null,
      ),
    );
  }

  void _navigateToDetail(BuildContext context, int id, bool isPerson) {
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
}