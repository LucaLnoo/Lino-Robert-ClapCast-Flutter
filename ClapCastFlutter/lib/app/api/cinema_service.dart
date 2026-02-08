
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/movie.dart';

part 'cinema_service.g.dart';

// --- MOVIE SERVICE ---
@RestApi()
abstract class MovieService {
  factory MovieService(Dio dio, {String baseUrl}) = _MovieService;

  @GET("movie/popular")
  Future<Movies> getMoviesOverviewPage(@Query("page") int page);

  @GET("search/movie")
  Future<Movies> searchMovies(@Query("query") String query);
  
  @GET("movie/{movie_id}")
  Future<MovieDetails> getMovieDetails(@Path("movie_id") int movieId);

  @GET("movie/{movie_id}/credits")
  Future<MovieDistribution> getMovieCredits(@Path("movie_id") int movieId);
}
