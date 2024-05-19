// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genres_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenresVO _$GenresVOFromJson(Map<String, dynamic> json) => GenresVO(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
    );

Map<String, dynamic> _$GenresVOToJson(GenresVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
