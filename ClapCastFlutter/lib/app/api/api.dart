
import 'package:clapcastflutter/app/model/movie.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

final apiCinema = Api();

@RestApi()
abstract class Api{
  factory Api(){
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://api.themoviedb.org/3/",
        contentType: "application/json",
        headers: <String, dynamic> {
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlOGE5YWVhNTViZDQ2Y2M0OTYwY2MzMTA3ZWEyNDhiYyIsIm5iZiI6MTc1NzU4MDc1OS4yMjgsInN1YiI6IjY4YzI4ZGQ3NGFjZmUxNGU4ZTFiZGNkZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.dz9Vls_URy6UgBiveLGL-URdZmS4iL_0VSIw7Uo-Wzs"
        }
      )
    );

    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestHeader: true,
        responseHeader: true
    ));
  return _Api(dio);
  }

  @GET("movie/popular")
  Future<Movies> getMovies();
}