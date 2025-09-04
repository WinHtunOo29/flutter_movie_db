import 'package:json_annotation/json_annotation.dart';

part 'movie_list_response_entity.g.dart';

@JsonSerializable()
class MovieEntity {
  final bool adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;
  final int id;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  final String overview;
  final double popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  final String title;
  final bool video;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;

  const MovieEntity({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieEntity.fromJson(Map<String, dynamic> json) =>
      _$MovieEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MovieEntityToJson(this);
}

@JsonSerializable()
class DatesEntity {
  final String maximum;
  final String minimum;

  const DatesEntity({
    required this.maximum,
    required this.minimum,
  });

  factory DatesEntity.fromJson(Map<String, dynamic> json) =>
      _$DatesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DatesEntityToJson(this);
}

@JsonSerializable()
class MovieListResponseEntity {
  final DatesEntity? dates;
  final int page;
  final List<MovieEntity> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  const MovieListResponseEntity({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListResponseEntityToJson(this);
}

