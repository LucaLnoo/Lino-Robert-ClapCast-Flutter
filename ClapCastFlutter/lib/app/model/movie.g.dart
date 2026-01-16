// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieOverview _$MovieOverviewFromJson(Map<String, dynamic> json) =>
    MovieOverview(
      title: json['title'] as String?,
    );

Map<String, dynamic> _$MovieOverviewToJson(MovieOverview instance) =>
    <String, dynamic>{
      'title': instance.title,
    };

Movies _$MoviesFromJson(Map<String, dynamic> json) => Movies(
      (json['results'] as List<dynamic>)
          .map((e) => MovieOverview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MoviesToJson(Movies instance) => <String, dynamic>{
      'results': instance.movieList.map((e) => e.toJson()).toList(),
    };
