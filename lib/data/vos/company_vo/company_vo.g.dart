// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyVO _$CompanyVOFromJson(Map<String, dynamic> json) => CompanyVO(
      (json['id'] as num?)?.toInt(),
      json['logo_path'] as String?,
      json['name'] as String?,
      json['origin_country'] as String?,
    );

Map<String, dynamic> _$CompanyVOToJson(CompanyVO instance) => <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logoPath,
      'name': instance.name,
      'origin_country': instance.originCountry,
    };
