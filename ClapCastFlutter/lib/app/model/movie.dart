
import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

// --- MOVIE LIST -- //
@JsonSerializable(explicitToJson: true)
class Movies {
  @JsonKey(name: "results")
  final List<MovieOverview> movieList;

  Movies(this.movieList);

  factory Movies.fromJson(Map<String, dynamic> json) => _$MoviesFromJson(json);
  Map<String, dynamic> toJson() => _$MoviesToJson(this);
}


// --- MOVIE OVERVIEW -- //
@JsonSerializable(explicitToJson: true)
class MovieOverview{
  @JsonKey(name:"id")
  final int id;

  @JsonKey(name: "original_title") // Utile si nom diff
  final String? title;

  @JsonKey(name: "original_language")
  final String? language;

  @JsonKey(name: "popularity")
  final double? popularityRate;

  @JsonKey(name: "vote_average")
  final double? score;

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

  int? get releaseYear {
    if (releaseDate == null || releaseDate!.isEmpty) {
      return null;
    }
    try {
      final parts = releaseDate!.split("-");
      final yearString = parts.first.trim();
      return int.tryParse(yearString);
    } catch (e) {
      return null;
    }
  }
  
  factory MovieOverview.fromJson(Map<String, dynamic> json) => _$MovieOverviewFromJson(json);
  Map<String, dynamic> toJson() => _$MovieOverviewToJson(this);
}


// --- MOVIE DETAILS -- //
@JsonSerializable(explicitToJson: true)
class MovieDetails{
  @JsonKey(name:"id")
  final int id;

  @JsonKey(name: "original_title")
  final String? title;

  @JsonKey(name: "original_language")
  final String? language;

  @JsonKey(name: "overview")
  final String? overview;

  @JsonKey(name: "release_date")
  final String? releaseDate;

  @JsonKey(name: "vote_average")
  final double? score;

  @JsonKey(name: "popularity")
  final double? popularityRate;

  @JsonKey(name: "poster_path")
  final String? posterPathImage;

  @JsonKey(name: "distribution_details")
  final MovieDistribution? distribution;

  MovieDetails({
    required this.id,
    this.title,
    this.language,
    this.overview,
    this.releaseDate,
    this.score,
    this.popularityRate,
    this.posterPathImage,
    this.distribution,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => _$MovieDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MovieDistribution{
  @JsonKey(name:"id")
  final int id;

  @JsonKey(name:"crew",defaultValue: [])
  final List<CrewMember> crew;

  @JsonKey(name:"cast",defaultValue: [])
  final List<CastMember> cast;

  MovieDistribution({
    required this.id,
    this.crew = const [],
    this.cast = const [],
  });

  factory MovieDistribution.fromJson(Map<String, dynamic> json) => _$MovieDistributionFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDistributionToJson(this);
}

@JsonSerializable()
class CastMember {
  @JsonKey(name: "id")
  final int personId;

  @JsonKey(name: "cast_id")
  final int castId;

  @JsonKey(name: "character")
  final String? characterName;

  @JsonKey(name: "name")
  final String actorName;

  @JsonKey(name: "profile_path")
  final String? profilePathImage;

  @JsonKey(name: "popularity")
  final double? popularityRate;

  const CastMember({
    required this.personId,
    required this.castId,
    required this.actorName,
    this.characterName,
    this.profilePathImage,
    this.popularityRate,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) => _$CastMemberFromJson(json);
  Map<String, dynamic> toJson() => _$CastMemberToJson(this);
}


@JsonSerializable()
class CrewMember {
  @JsonKey(name: "id")
  final int personId;

  @JsonKey(name: "credit_id")
  final String creditId;

  @JsonKey(name: "job")
  final String job;

  @JsonKey(name: "name")
  final String crewName;

  @JsonKey(name: "profile_path")
  final String? profilePathImage;

  @JsonKey(name: "popularity")
  final double? popularityRate;

  const CrewMember({
    required this.personId,
    required this.creditId,
    required this.job,
    required this.crewName,
    this.profilePathImage,
    this.popularityRate,
  });

  factory CrewMember.fromJson(Map<String, dynamic> json) => _$CrewMemberFromJson(json);
  Map<String, dynamic> toJson() => _$CrewMemberToJson(this);
}