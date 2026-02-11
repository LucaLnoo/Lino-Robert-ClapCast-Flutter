import 'package:flutter/cupertino.dart';

import '../../app/model/movie.dart';
import '../../app/model/person.dart';
import '../../app/repository/movie_repository.dart';
import '../../app/repository/person_repository.dart';

class SearchNotifier extends ChangeNotifier {
  List<MovieOverview>? movies;
  List<PersonOverview>? people;

  String currentQuery = "";

  void updateQuery(String newQuery){
    currentQuery = newQuery;
  }

  void fetchMoviesByQuery(String query) async {
    if (currentQuery.isEmpty) return;

    final movies = await movieRepository.getMoviesOverview(title: query);
    this.movies = movies;
    notifyListeners();
  }

  void fetchPeopleByQuery(String query) async{
    if (currentQuery.isEmpty) return;

    final people = await personRepository.getPeopleOverview(title: query);
    this.people = people;
    notifyListeners();
  }
}