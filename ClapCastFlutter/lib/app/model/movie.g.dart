// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movies _$MoviesFromJson(Map<String, dynamic> json) => Movies(
      (json['results'] as List<dynamic>)
          .map((e) => MovieOverview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MoviesToJson(Movies instance) => <String, dynamic>{
      'results': instance.movieList.map((e) => e.toJson()).toList(),
    };

MovieOverview _$MovieOverviewFromJson(Map<String, dynamic> json) =>
    MovieOverview(
      id: (json['id'] as num).toInt(),
      title: json['original_title'] as String?,
      language: json['original_language'] as String?,
      popularityRate: (json['popularity'] as num?)?.toDouble(),
      score: (json['vote_average'] as num?)?.toDouble(),
      releaseDate: json['release_date'] as String?,
      posterPathImage: json['poster_path'] as String?,
    );

Map<String, dynamic> _$MovieOverviewToJson(MovieOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'original_title': instance.title,
      'original_language': instance.language,
      'popularity': instance.popularityRate,
      'vote_average': instance.score,
      'release_date': instance.releaseDate,
      'poster_path': instance.posterPathImage,
    };

MovieDetails _$MovieDetailsFromJson(Map<String, dynamic> json) => MovieDetails(
      id: (json['id'] as num).toInt(),
      title: json['original_title'] as String?,
      language: json['original_language'] as String?,
      overview: json['overview'] as String?,
      releaseDate: json['release_date'] as String?,
      score: (json['vote_average'] as num?)?.toDouble(),
      popularityRate: (json['popularity'] as num?)?.toDouble(),
      posterPathImage: json['poster_path'] as String?,
      distribution: json['distribution_details'] == null
          ? null
          : MovieDistribution.fromJson(
              json['distribution_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieDetailsToJson(MovieDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'original_title': instance.title,
      'original_language': instance.language,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
      'vote_average': instance.score,
      'popularity': instance.popularityRate,
      'poster_path': instance.posterPathImage,
      'distribution_details': instance.distribution?.toJson(),
    };

MovieDistribution _$MovieDistributionFromJson(Map<String, dynamic> json) =>
    MovieDistribution(
      id: (json['id'] as num).toInt(),
      crew: (json['crew'] as List<dynamic>?)
              ?.map((e) => CrewMember.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      cast: (json['cast'] as List<dynamic>?)
              ?.map((e) => CastMember.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MovieDistributionToJson(MovieDistribution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'crew': instance.crew.map((e) => e.toJson()).toList(),
      'cast': instance.cast.map((e) => e.toJson()).toList(),
    };

CastMember _$CastMemberFromJson(Map<String, dynamic> json) => CastMember(
      personId: (json['id'] as num).toInt(),
      castId: (json['cast_id'] as num).toInt(),
      actorName: json['name'] as String,
      characterName: json['character'] as String?,
      profilePathImage: json['profile_path'] as String?,
      popularityRate: (json['popularity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CastMemberToJson(CastMember instance) =>
    <String, dynamic>{
      'id': instance.personId,
      'cast_id': instance.castId,
      'character': instance.characterName,
      'name': instance.actorName,
      'profile_path': instance.profilePathImage,
      'popularity': instance.popularityRate,
    };

CrewMember _$CrewMemberFromJson(Map<String, dynamic> json) => CrewMember(
      personId: (json['id'] as num).toInt(),
      creditId: json['credit_id'] as String,
      job: json['job'] as String,
      crewName: json['name'] as String,
      profilePathImage: json['profile_path'] as String?,
      popularityRate: (json['popularity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CrewMemberToJson(CrewMember instance) =>
    <String, dynamic>{
      'id': instance.personId,
      'credit_id': instance.creditId,
      'job': instance.job,
      'name': instance.crewName,
      'profile_path': instance.profilePathImage,
      'popularity': instance.popularityRate,
    };
