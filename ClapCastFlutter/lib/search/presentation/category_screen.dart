import 'package:clapcastflutter/app/model/movie.dart';
import 'package:clapcastflutter/app/model/person.dart';
import 'package:clapcastflutter/app/widgets/base_layout.dart';
import 'package:flutter/cupertino.dart';

import '../../app/widgets/list_item_page.dart';

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
        onContentClick: (id, isPerson) {},
        onBackClick: () => Navigator.pop(context),
        onSearchQueryChanged: null,
      ),
    );
  }
}