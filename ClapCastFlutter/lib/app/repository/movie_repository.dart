
import 'package:clapcastflutter/app/api/api.dart';
import 'package:clapcastflutter/app/model/movie.dart';

final movieRepository = _MovieRepository();

class _MovieRepository {

  Future<List<MovieOverview>> getMoviesOverview({String? title}) async {
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

  Future<MovieDetails> getMovieDetails(int movieId) async {
    try{
      var movie = await apiCinema.movieService.getMovieDetails(movieId);
      var distribution = await apiCinema.movieService.getMovieCredits(movieId);
      movie = _mergeDetailsAndCredits(movie,distribution);
      return movie;
    }catch(error){
      throw Exception( error);
    }
  }


    MovieDetails _mergeDetailsAndCredits(MovieDetails original, MovieDistribution distribution) {
    return MovieDetails(
      id: original.id,
      title: original.title,
      overview: original.overview,
      posterPathImage: original.posterPathImage,
      releaseDate: original.releaseDate,
      score: original.score,
      popularityRate: original.popularityRate,
      language: original.language,

      distribution: distribution,
    );
  }

}