import 'package:json_annotation/json_annotation.dart';

part 'language_vo.g.dart';

@JsonSerializable()
class LanguageVO{

  @JsonKey(name: 'english_name')
  String? englishName;

  @JsonKey(name: 'iso_639_1')
  String? iso6391;

  @JsonKey(name: 'name')
  String? name;

  LanguageVO(this.englishName, this.iso6391, this.name);

  factory LanguageVO.fromJson(Map<String, dynamic> json) => _$LanguageVOFromJson(json);
}
