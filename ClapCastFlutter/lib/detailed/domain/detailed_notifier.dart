import 'package:clapcastflutter/app/model/movie.dart';
import 'package:clapcastflutter/app/model/person.dart';
import 'package:flutter/cupertino.dart';

import '../../app/repository/movie_repository.dart';
import '../../app/repository/person_repository.dart';

class DetailedNotifier extends ChangeNotifier {
  MovieDetails? movie;
  PersonDetails? person;

  void fetchMovieDetails(int movieId) async {
    movie = await movieRepository.getMovieDetails(movieId);
    notifyListeners();
  }

  void fetchPersonDetails(int personId) async{
    person = await personRepository.getMovieDetails(personId);
    notifyListeners();
  }
}