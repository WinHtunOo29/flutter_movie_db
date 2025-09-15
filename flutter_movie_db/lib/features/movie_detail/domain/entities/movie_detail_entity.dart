import 'package:json_annotation/json_annotation.dart';

part 'movie_detail_entity.g.dart';

@JsonSerializable()
class MovieDetailEntity {
  final bool adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'belongs_to_collection')
  final BelongsToCollectionEntity? belongsToCollection;
  final int budget;
  final List<GenreEntity> genres;
  final String? homepage;
  final int id;
  @JsonKey(name: 'imdb_id')
  final String? imdbId;
  @JsonKey(name: 'origin_country')
  final List<String> originCountry;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  final String overview;
  final double popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'production_companies')
  final List<ProductionCompanyEntity> productionCompanies;
  @JsonKey(name: 'production_countries')
  final List<ProductionCountryEntity> productionCountries;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  final int revenue;
  final int? runtime;
  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguageEntity> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;

  const MovieDetailEntity({
    required this.adult,
    this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    this.homepage,
    required this.id,
    this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    this.releaseDate,
    required this.revenue,
    this.runtime,
    required this.spokenLanguages,
    required this.status,
    this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailEntityToJson(this);
}

@JsonSerializable()
class BelongsToCollectionEntity {
  final int id;
  final String name;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  const BelongsToCollectionEntity({
    required this.id,
    required this.name,
    this.posterPath,
    this.backdropPath,
  });

  factory BelongsToCollectionEntity.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BelongsToCollectionEntityToJson(this);
}

@JsonSerializable()
class GenreEntity {
  final int id;
  final String name;

  const GenreEntity({
    required this.id,
    required this.name,
  });

  factory GenreEntity.fromJson(Map<String, dynamic> json) =>
      _$GenreEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GenreEntityToJson(this);
}

@JsonSerializable()
class ProductionCompanyEntity {
  final int id;
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  final String name;
  @JsonKey(name: 'origin_country')
  final String originCountry;

  const ProductionCompanyEntity({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompanyEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyEntityToJson(this);
}

@JsonSerializable()
class ProductionCountryEntity {
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  final String name;

  const ProductionCountryEntity({
    required this.iso31661,
    required this.name,
  });

  factory ProductionCountryEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryEntityToJson(this);
}

@JsonSerializable()
class SpokenLanguageEntity {
  @JsonKey(name: 'english_name')
  final String englishName;
  @JsonKey(name: 'iso_639_1')
  final String iso6391;
  final String name;

  const SpokenLanguageEntity({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguageEntity.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageEntityToJson(this);
}

