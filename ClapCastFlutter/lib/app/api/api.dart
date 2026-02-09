
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'cinema_service.dart';

final apiCinema = Api();

class Api{
  late final Dio _dio;

  late final MovieService movieService;
  late final ActorService actorService;

  // Singleton
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://api.themoviedb.org/3/",
        contentType: "application/json",
        headers: <String, dynamic>{
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlOGE5YWVhNTViZDQ2Y2M0OTYwY2MzMTA3ZWEyNDhiYyIsIm5iZiI6MTc1NzU4MDc1OS4yMjgsInN1YiI6IjY4YzI4ZGQ3NGFjZmUxNGU4ZTFiZGNkZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.dz9Vls_URy6UgBiveLGL-URdZmS4iL_0VSIw7Uo-Wzs"
        },
      ),
    );

    _dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
    ));

    movieService = MovieService(_dio);
    actorService = ActorService(_dio);
  }
}