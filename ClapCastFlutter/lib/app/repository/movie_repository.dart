
import 'package:clapcastflutter/app/api/api.dart';
import 'package:clapcastflutter/app/model/movie.dart';

final movieRepository = _MovieRepository();

class _MovieRepository {

  Future<Movies> getMovies() {
    return apiCinema.getMovies();
  }
}