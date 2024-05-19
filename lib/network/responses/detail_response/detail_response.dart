
import 'package:json_annotation/json_annotation.dart';

import '../../../data/vos/collection_vo/collection_vo.dart';
import '../../../data/vos/company_vo/company_vo.dart';
import '../../../data/vos/country_vo/country_vo.dart';
import '../../../data/vos/genres_vo/genres_vo.dart';
import '../../../data/vos/language_vo/language_vo.dart';

part 'detail_response.g.dart';

@JsonSerializable()
class DetailResponse{
  @JsonKey(name: 'adult')
  bool? adult;

  @JsonKey(name: 'backdrop_path')
  String? backdropPath;

  @JsonKey(name: 'belongs_to_collection')
  CollectionVO? belongsToCollection;

  @JsonKey(name: 'budget')
  num? budget;

  @JsonKey(name: 'genres')
  List<GenresVO>? genres;

  @JsonKey(name: 'homepage')
  String? homePage;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'imdb_id')
  String? imdbID;

  @JsonKey(name: 'origin_country')
  List<String>? originCountry;

  @JsonKey(name: 'original_languages')
  String? originalLanguage;

  @JsonKey(name: 'original_title')
  String? originalTitle;

  @JsonKey(name: 'overview')
  String? overview;

  @JsonKey(name: 'popularity')
  num? popularity;

  @JsonKey(name: 'poster_path')
  String? posterPath;

  @JsonKey(name: 'production_companies')
  List<CompanyVO>? productionCompanies;

  @JsonKey(name: 'production_countries')
  List<CountryVO>? productionCountries;

  @JsonKey(name: 'release_date')
  String? releaseDate;

  @JsonKey(name: 'revenue')
  int? revenue;

  @JsonKey(name: 'runtime')
  num? runtime;

  @JsonKey(name: 'spoken_languages')
  List<LanguageVO>? spokenLanguages;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'tagline')
  String? tagline;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'video')
  bool? video;

  @JsonKey(name: 'vote_average')
  num? voteAverage;

  @JsonKey(name: 'vote_count')
  int? voteCount;

  DetailResponse(
      this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homePage,
      this.id,
      this.imdbID,
      this.originCountry,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount);

  factory DetailResponse.fromJson(Map<String, dynamic> json) => _$DetailResponseFromJson(json);
}