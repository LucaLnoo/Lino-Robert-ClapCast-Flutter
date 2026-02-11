import 'package:clapcastflutter/app/widgets/base_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/widgets/list_item_page.dart';
import '../domain/search_notifier.dart';
import '../../dashboard/presentation/dashboard_screen.dart';

class SearchScreen extends StatelessWidget{
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // read evite de redessiner l'interface
    final searchActions = context.read<SearchNotifier>();
    final searchNotifier = context.watch<SearchNotifier>();
    final movies = searchNotifier.movies ?? [];
    final people = searchNotifier.people ?? [];

    return BaseLayout(
      currentIndex: 1,
      child: MediaListLayout(
        title: "Search",
        people: people,
        movies: movies,

        onContentClick: (id, isPerson) {
          if (isPerson) {
            //Navigator.pushNamed(context, '/detailed_screen', arguments: id);
          } else {
            //Navigator.pushNamed(context, '/detailed_screen', arguments: id);
          }
        },

        onBackClick: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          }
        },

        onSearchQueryChanged: (query) {
          searchActions.fetchPeopleByQuery(query);
          searchActions.fetchMoviesByQuery(query);
        },
      )
    );
  }
}