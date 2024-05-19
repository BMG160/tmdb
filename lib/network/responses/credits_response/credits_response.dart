
import 'package:json_annotation/json_annotation.dart';

import '../../../data/vos/cast_vo/cast_vo.dart';
import '../../../data/vos/crew_vo/crew_vo.dart';

part 'credits_response.g.dart';

@JsonSerializable()
class CreditsResponse{

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'cast')
  List<CastVO>? cast;

  @JsonKey(name: 'crew')
  List<CrewVO>? crew;

  CreditsResponse(this.id, this.cast, this.crew);

  factory CreditsResponse.fromJson(Map<String, dynamic> json) => _$CreditsResponseFromJson(json);
}