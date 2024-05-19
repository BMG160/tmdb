import 'package:json_annotation/json_annotation.dart';

part 'company_vo.g.dart';

@JsonSerializable()
class CompanyVO{

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'logo_path')
  String? logoPath;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'origin_country')
  String? originCountry;

  CompanyVO(this.id, this.logoPath, this.name, this.originCountry);

  factory CompanyVO.fromJson(Map<String, dynamic> json) => _$CompanyVOFromJson(json);
}

