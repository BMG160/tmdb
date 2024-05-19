
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/data/vos/date_vo/date_vo.dart';

import '../../../data/vos/movie_vo/movie_vo.dart';

part 'get_now_playing_response.g.dart';

@JsonSerializable()
class GetNowPlayingResponse{

  @JsonKey(name: 'dates')
  DateVO? dates;

  @JsonKey(name: 'page')
  int? page;

  @JsonKey(name: 'results')
  List<MovieVO>? results;

  @JsonKey(name: 'total_pages')
  int? totalPages;

  @JsonKey(name: 'total_results')
  int? totalResults;

  GetNowPlayingResponse(
      this.dates, this.page, this.results, this.totalPages, this.totalResults);

  factory GetNowPlayingResponse.fromJson(Map<String, dynamic> json) => _$GetNowPlayingResponseFromJson(json);
}