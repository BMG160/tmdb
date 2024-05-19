
import 'package:dio/dio.dart';
import 'package:tmdb/constant/api_constant.dart';
import 'package:tmdb/data/vos/cast_vo/cast_vo.dart';
import 'package:tmdb/data/vos/crew_vo/crew_vo.dart';
import 'package:tmdb/data/vos/genres_vo/genres_vo.dart';
import 'package:tmdb/data/vos/movie_vo/movie_vo.dart';
import 'package:tmdb/data/vos/video_vo/video_vo.dart';
import 'package:tmdb/network/api/api.dart';
import 'package:tmdb/network/data_agent/data_agent.dart';
import 'package:tmdb/network/responses/detail_response/detail_response.dart';

class DataAgentImpl extends DataAgent{
  late Api _api;

  DataAgentImpl._(){
    _api = Api(Dio());
  }

  static final DataAgentImpl _singleton = DataAgentImpl._();

  factory DataAgentImpl() => _singleton;

  @override
  Future<List<MovieVO>?> getGetNowPlayingNetwork(int page) => _api
      .getNowPlayingResponse(kApiKey, page)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<List<MovieVO>?> getPopularMovieFromNetwork(int page) => _api
      .getPopularMovieResponse(kApiKey, page)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<DetailResponse> getDetailsFromNetwork(String movieID) => _api
      .getDetailResponse(movieID, kApiKey);

  @override
  Future<List<GenresVO>?> getGenresFromNetwork() => _api
      .getGenresResponse(kApiKey)
      .asStream()
      .map((event) => event.genres)
      .first;

  @override
  Future<List<MovieVO>?> getMoviesByGenresFromNetwork(int page, int genreID) => _api
      .getMoviesByGenresResponse(kApiKey, page, genreID)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<List<CastVO>?> getCastFromNetwork(String movieID) => _api
      .getCreditsResponse(movieID, kApiKey)
      .asStream()
      .map((event) => event.cast)
      .first;

  @override
  Future<List<CrewVO>?> getCrewFromNetwork(String movieID) => _api
      .getCreditsResponse(movieID, kApiKey)
      .asStream()
      .map((event) => event.crew)
      .first;

  @override
  Future<List<VideoVO>?> getVideoFromNetwork(String movieID) => _api
      .getVideoResponse(movieID, kApiKey)
      .asStream()
      .map((event) => event.results)
      .first;
  
}