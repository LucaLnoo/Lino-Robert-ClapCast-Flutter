import 'package:clapcastflutter/app/widgets/base_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../app/widgets/background.dart';
import '../../app/widgets/header.dart';
import '../domain/search_notifier.dart';

class SearchScreen extends StatelessWidget{
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // read evite de redessiner l'interface
    final searchActions = context.read<SearchNotifier>();
    final searchNotifier = context.watch<SearchNotifier>();
    final movies = searchNotifier.movies;
    final people = searchNotifier.people;

    return BaseLayout(
      currentIndex: 1,
      child: AppMenuBackground(
        child: SafeArea(
          child: Column(
            children: [
              HeaderLogo(),
              SearchBarWidget(
                query: searchNotifier.currentQuery,

                onQueryChange: (String value) {
                  searchActions.updateQuery(value);
                },

                onSearchClick: () {
                  searchActions.fetchMoviesByQuery(searchNotifier.currentQuery);
                  searchActions.fetchPeopleByQuery(searchNotifier.currentQuery);

                  FocusScope.of(context).unfocus();
                },
              ),
              if (movies != null && movies.isNotEmpty)
                Text(movies.first.title ?? "null"),
              if (people != null && people.isNotEmpty)
                Text(people.first.name ?? "null"),
            ]
          )
        )
      )
    );
  }
}