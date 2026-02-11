import 'package:clapcastflutter/app/model/movie.dart';
import 'package:clapcastflutter/app/model/person.dart';
import 'package:flutter/cupertino.dart';

import '../../app/repository/movie_repository.dart';
import '../../app/repository/person_repository.dart';

class DetailedNotifier extends ChangeNotifier {
  MovieDetails? movie;
  PersonDetails? person;

  void fetchMovieDetails(int movieId) async {
    movie = null;
    notifyListeners();
    try{
      var fetchedMovie = await movieRepository.getMovieDetails(movieId);

      if (fetchedMovie.distribution != null) {
        fetchedMovie.distribution!.cast.removeWhere((actor) =>
        actor.profilePathImage == null || actor.profilePathImage!.isEmpty
        );
      }

      movie = fetchedMovie;
    }catch(e){
      debugPrint("FETCH MOVIE ERROR: $e");
    }finally{
      notifyListeners();
    }
  }

  void fetchPersonDetails(int personId) async{
    person = null;
    notifyListeners();
    try{
      var fetchedPerson = await personRepository.getPersonDetails(personId);

      if (fetchedPerson.knownForMovies != null) {
        fetchedPerson.knownForMovies!.cast.removeWhere((film) =>
        film.posterPathImage == null || film.posterPathImage!.isEmpty
        );
      }

      person = fetchedPerson;
    }catch(e){
      debugPrint("FETCH PERSON ERROR: $e");
    }finally{
      notifyListeners();
    }
  }
}