
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/movie.dart';
import '../model/person.dart';

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
  Future<PersonDetails> getMovieDetails(@Path("movie_id") int movieId);

  @GET("movie/{movie_id}/credits")
  Future<PersonFilmography> getMovieCredits(@Path("movie_id") int movieId);
}

@RestApi()
abstract class ActorService {
  factory ActorService(Dio dio, {String baseUrl}) = _ActorService;

  @GET("person/popular")
  Future<PeopleOverview> getPeopleOverviewPage(@Query("page") int page);

  @GET("search/person")
  Future<PeopleOverview> searchPeopleOverview(@Query("query") String query);

  @GET("person/{person_id}")
  Future<MovieDetails> getPersonDetails(@Path("movie_id") int movieId);

  @GET("person/{person_id}/movie_credits")
  Future<MovieDistribution> getPersonMovieCredits(@Path("movie_id") int movieId);
}
