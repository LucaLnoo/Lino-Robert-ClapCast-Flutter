import 'package:flutter/cupertino.dart';

import '../../app/model/movie.dart';
import '../../app/model/person.dart';
import '../../app/repository/movie_repository.dart';
import '../../app/repository/person_repository.dart';

class StartingNotifier extends ChangeNotifier {
  List<MovieOverview>? movies;
  List<PersonOverview>? people;

  void fetchAllMovies() async {
    final movies = await movieRepository.getMoviesOverview();
    this.movies = movies;
    notifyListeners();
  }

  void fetchAllPeople() async{
    final people = await personRepository.getPeopleOverview();
    this.people = people;
    notifyListeners();
  }
}