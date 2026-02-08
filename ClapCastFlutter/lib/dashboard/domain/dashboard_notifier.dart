import 'package:clapcastflutter/app/api/api.dart';
import 'package:clapcastflutter/app/model/movie.dart';
import 'package:clapcastflutter/app/repository/movie_repository.dart';
import 'package:flutter/material.dart';

// Equivalent du ViewModel => notifier peut être uniquement dans le viewmodel

class DashboardNotifier extends ChangeNotifier{
  var count = 0;
  String get name => _name;
  var _name = "toto";
  List<MovieOverview>? movies;

  void changeName() {
    if(_name == "toto"){
      _name = "tintin";
    }else{
      _name = "toto";
    }
    notifyListeners();
  }

  void getMovies() async {
      final movies = await movieRepository.getMoviesOverview();
      this.movies = movies;
      notifyListeners();
  }
}