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
      movie = await movieRepository.getMovieDetails(movieId);
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
      person = await personRepository.getPersonDetails(personId);
    }catch(e){
      debugPrint("FETCH PERSON ERROR: $e");
    }finally{
      notifyListeners();
    }
  }
}