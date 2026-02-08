
import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieOverview{
  @JsonKey(name:"id")
  final int id;

  @JsonKey(name: "original_title") // Utile si nom diff
  final String? title;

  @JsonKey(name: "original_language")
  final String? language;

  @JsonKey(name: "popularity")
  final Float? popularityRate;

  @JsonKey(name: "vote_average")
  final Float? score;

  @JsonKey(name: "release_date")
  final String? releaseDate;

  @JsonKey(name: "poster_path")
  final String? posterPathImage;

  MovieOverview({
    required this.id,
    this.title,
    this.language,
    this.popularityRate,
    this.score,
    this.releaseDate,
    this.posterPathImage,
  });
  
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