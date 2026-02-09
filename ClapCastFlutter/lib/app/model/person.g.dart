// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeopleOverview _$PeopleOverviewFromJson(Map<String, dynamic> json) =>
    PeopleOverview(
      (json['results'] as List<dynamic>)
          .map((e) => PersonOverview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PeopleOverviewToJson(PeopleOverview instance) =>
    <String, dynamic>{
      'results': instance.personList.map((e) => e.toJson()).toList(),
    };

PersonOverview _$PersonOverviewFromJson(Map<String, dynamic> json) =>
    PersonOverview(
      id: (json['id'] as num).toInt(),
      gender: (json['gender'] as num?)?.toInt(),
      adult: json['adult'] as bool? ?? true,
      name: json['name'] as String?,
      department: json['known_for_department'] as String?,
      profilePathImage: json['profile_path'] as String?,
      popularityRate: (json['popularity'] as num?)?.toDouble(),
      knownForMovies: (json['known_for'] as List<dynamic>?)
              ?.map((e) => MovieDetails.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PersonOverviewToJson(PersonOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gender': instance.gender,
      'name': instance.name,
      'adult': instance.adult,
      'known_for_department': instance.department,
      'profile_path': instance.profilePathImage,
      'popularity': instance.popularityRate,
      'known_for': instance.knownForMovies.map((e) => e.toJson()).toList(),
    };

PersonFilmography _$PersonFilmographyFromJson(Map<String, dynamic> json) =>
    PersonFilmography(
      cast: (json['cast'] as List<dynamic>?)
              ?.map((e) => MovieOverview.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      crew: (json['crew'] as List<dynamic>?)
              ?.map((e) => MovieOverview.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PersonFilmographyToJson(PersonFilmography instance) =>
    <String, dynamic>{
      'cast': instance.cast,
      'crew': instance.crew,
    };

PersonDetails _$PersonDetailsFromJson(Map<String, dynamic> json) =>
    PersonDetails(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      department: json['known_for_department'] as String?,
      biography: json['biography'] as String?,
      birthday: json['birthday'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
      popularityRate: (json['popularity'] as num?)?.toDouble(),
      profilePathImage: json['profile_path'] as String?,
    );

Map<String, dynamic> _$PersonDetailsToJson(PersonDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'known_for_department': instance.department,
      'biography': instance.biography,
      'birthday': instance.birthday,
      'place_of_birth': instance.placeOfBirth,
      'popularity': instance.popularityRate,
      'profile_path': instance.profilePathImage,
      'knownForMovies': instance.knownForMovies?.toJson(),
    };
