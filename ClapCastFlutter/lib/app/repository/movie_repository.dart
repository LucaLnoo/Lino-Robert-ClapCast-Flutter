
import 'package:clapcastflutter/app/api/api.dart';
import 'package:clapcastflutter/app/model/movie.dart';

final movieRepository = _MovieRepository();

class _MovieRepository {

  Future<List<MovieOverview>> getMoviesOverview(String? title) async {
    try{
      List<MovieOverview> movies = [];
      const int pageRange = 20;

      if(title == null){
        for(int page=1; page<pageRange; page++){
          final fetchMovies = await apiCinema.movieService.getMoviesOverviewPage(page);
          movies.addAll(fetchMovies.movieList);
        }
      }else{
        final fetchMovies = await apiCinema.movieService.searchMovies(title);
        movies.addAll(fetchMovies.movieList);
      }

      var filterMovies = movies.where((movie) => movie.posterPathImage?.isNotEmpty ?? false).toList();
      return filterMovies;
    }catch(error){
      throw Exception( error);
    }
  }


}