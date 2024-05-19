// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageVO _$LanguageVOFromJson(Map<String, dynamic> json) => LanguageVO(
      json['english_name'] as String?,
      json['iso_639_1'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$LanguageVOToJson(LanguageVO instance) =>
    <String, dynamic>{
      'english_name': instance.englishName,
      'iso_639_1': instance.iso6391,
      'name': instance.name,
    };
