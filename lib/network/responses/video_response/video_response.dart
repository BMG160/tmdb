
import 'package:json_annotation/json_annotation.dart';

import '../../../data/vos/video_vo/video_vo.dart';

part 'video_response.g.dart';

@JsonSerializable()
class VideoResponse{

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'results')
  List<VideoVO>? results;

  VideoResponse(this.id, this.results);

  factory VideoResponse.fromJson(Map<String, dynamic> json) => _$VideoResponseFromJson(json);
}