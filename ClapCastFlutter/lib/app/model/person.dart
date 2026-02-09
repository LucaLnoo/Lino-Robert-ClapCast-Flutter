import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'person.g.dart';

// --- Person LIST -- //
@JsonSerializable(explicitToJson: true)
class PeopleOverview {
  @JsonKey(name: "results")
  final List<PersonOverview> personList;

  PeopleOverview(this.personList);

  factory PeopleOverview.fromJson(Map<String, dynamic> json) => _$PeopleFromJson(json);
  Map<String, dynamic> toJson() => _$PeopleToJson(this);
}

// --- PERSON OVERVIEW -- //
@JsonSerializable(explicitToJson: true)
class PersonOverview{
  @JsonKey(name:"id")
  final int id;

  //0	Not specified
  //1	Female
  //2	Male
  //3	Non-binary
  @JsonKey(name: "gender") // Utile si nom diff
  final int? gender;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "adult", defaultValue: true)
  final bool adult;

  @JsonKey(name: "known_for_department")
  final String? department;

  @JsonKey(name: "profile_path")
  final String? profilePathImage;

  @JsonKey(name: "popularity")
  final double? popularityRate;

  @JsonKey(name: "known_for")
  final List<MovieDetails> knownForMovies;

  PersonOverview({
    required this.id,
    this.gender,
    this.adult = true,
    this.name,
    this.department,
    this.profilePathImage,
    this.popularityRate,
    this.knownForMovies = const [],
  });

  factory PersonOverview.fromJson(Map<String, dynamic> json) => _$PersonOverviewFromJson(json);
  Map<String, dynamic> toJson() => _$PersonOverviewToJson(this);
}

@JsonSerializable()
class PersonFilmography{
  @JsonKey(name:"cast", defaultValue: [])
  final List<MovieOverview> cast;

  @JsonKey(name:"crew", defaultValue: [])
  final List<MovieOverview> crew;

  PersonFilmography({
    this.cast = const [],
    this.crew = const [],
  });

  factory PersonFilmography.fromJson(Map<String, dynamic> json) => _$PersonFilmographyFromJson(json);
  Map<String, dynamic> toJson() => _$PersonFilmographyToJson(this);
}


// --- PERSON DETAILS -- //
@JsonSerializable(explicitToJson: true)
class PersonDetails{
  @JsonKey(name:"id")
  final int id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "known_for_department")
  final String? department;

  @JsonKey(name: "biography")
  final String? biography;

  @JsonKey(name: "birthday")
  final String? birthday;

  @JsonKey(name: "place_of_birth")
  final String? placeOfBirth;

  @JsonKey(name: "popularity")
  final double? popularityRate;

  @JsonKey(name: "profile_path")
  final String? profilePathImage;

  @JsonKey(includeFromJson: false, includeToJson: true)
  final PersonFilmography? knownForMovies;

  PersonDetails({
    required this.id,
    this.name,
    this.department,
    this.biography,
    this.birthday,
    this.placeOfBirth,
    this.popularityRate,
    this.profilePathImage,
    this.knownForMovies,
  });

  String? get country {
    if (placeOfBirth == null) return null;
    final parts = placeOfBirth!.split(",");
    return parts.last.trim();
  }

  factory PersonDetails.fromJson(Map<String, dynamic> json) => _$PersonDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PersonDetailsToJson(this);
}