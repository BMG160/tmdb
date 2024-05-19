
import 'package:tmdb/data/vos/cast_vo/cast_vo.dart';
import 'package:tmdb/data/vos/crew_vo/crew_vo.dart';
import 'package:tmdb/data/vos/genres_vo/genres_vo.dart';
import 'package:tmdb/data/vos/video_vo/video_vo.dart';
import 'package:tmdb/network/responses/detail_response/detail_response.dart';

import '../vos/movie_vo/movie_vo.dart';

abstract class Apply{
  Future<List<MovieVO>?> getGetNowPlayingNetwork(int page);

  Future<List<MovieVO>?> getPopularMovieFromNetwork(int page);

  Future<DetailResponse> getDetailsFromNetwork(String movieID);

  Future<List<GenresVO>?> getGenresFromNetwork();

  Future<List<CastVO>?> getCastFromNetwork(String movieID);

  Future<List<CrewVO>?> getCrewFromNetwork(String movieID);

  Future<List<VideoVO>?> getVideoFromNetwork(String movieID);

  Future<List<MovieVO>?> getMoviesByGenresFromNetwork(int page, int genreID);

  Stream<List<MovieVO>?> getGetNowPlayingFromDatabaseStream();

  Stream<List<MovieVO>?> getGetPopularMovieFromDatabaseStream();

  Stream<List<MovieVO>?> getMovieByGenresFromDatabaseStream();

  void getNowPlayingMovieBoxClear();

  void getPopularMovieBoxClear();

  void getMovieByGenresBoxClear();
}
