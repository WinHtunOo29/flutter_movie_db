// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieEntity _$MovieEntityFromJson(Map<String, dynamic> json) => MovieEntity(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      id: (json['id'] as num).toInt(),
      originalLanguage: json['original_language'] as String,
      originalTitle: json['original_title'] as String,
      overview: json['overview'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      title: json['title'] as String,
      video: json['video'] as bool,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
    );

Map<String, dynamic> _$MovieEntityToJson(MovieEntity instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };

DatesEntity _$DatesEntityFromJson(Map<String, dynamic> json) => DatesEntity(
      maximum: json['maximum'] as String,
      minimum: json['minimum'] as String,
    );

Map<String, dynamic> _$DatesEntityToJson(DatesEntity instance) =>
    <String, dynamic>{
      'maximum': instance.maximum,
      'minimum': instance.minimum,
    };

MovieListResponseEntity _$MovieListResponseEntityFromJson(
        Map<String, dynamic> json) =>
    MovieListResponseEntity(
      dates: json['dates'] == null
          ? null
          : DatesEntity.fromJson(json['dates'] as Map<String, dynamic>),
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$MovieListResponseEntityToJson(
        MovieListResponseEntity instance) =>
    <String, dynamic>{
      'dates': instance.dates,
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
