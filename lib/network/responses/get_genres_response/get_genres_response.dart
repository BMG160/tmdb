
import 'package:json_annotation/json_annotation.dart';

import '../../../data/vos/genres_vo/genres_vo.dart';

part 'get_genres_response.g.dart';

@JsonSerializable()
class GetGenresResponse {

  @JsonKey(name: 'genres')
  List<GenresVO>? genres;

  GetGenresResponse(this.genres);

  factory GetGenresResponse.fromJson(Map<String, dynamic> json) => _$GetGenresResponseFromJson(json);
}