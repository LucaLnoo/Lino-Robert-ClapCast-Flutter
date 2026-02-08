
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieOverview{
  @JsonKey(name: "title") // Utile si nom diff
  final String? title;

  MovieOverview({this.title});
  
  factory MovieOverview.fromJson(Map<String, dynamic> json) => _$MovieOverviewFromJson(json);
  Map<String, dynamic> toJson() => _$MovieOverviewToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Movies {
  @JsonKey(name: "results")
  final List<MovieOverview> movieList;

  Movies(this.movieList);

  factory Movies.fromJson(Map<String, dynamic> json) => _$MoviesFromJson(json);
  Map<String, dynamic> toJson() => _$MoviesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MovieDetails{
  @JsonKey(name:"id")
  final int id;

  MovieDetails({required this.id});

  factory MovieDetails.fromJson(Map<String, dynamic> json) => _$MovieDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MovieDistribution{
  @JsonKey(name:"id")
  final int id;

  MovieDistribution({required this.id});

  factory MovieDistribution.fromJson(Map<String, dynamic> json) => _$MovieDistributionFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDistributionToJson(this);
}