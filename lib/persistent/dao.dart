
import 'dart:async';

import '../data/vos/movie_vo/movie_vo.dart';

abstract class Dao{
  void saveGetNowPlaying(List<MovieVO> getNowPlayingMovieList);

  void saveGetPopularMovie(List<MovieVO> getPopularMovieList);

  void saveGetMovieByGenres(List<MovieVO> movieList);

  List<MovieVO>? getGetNowPlayingFromDatabase();

  List<MovieVO>? getPopularMovieFromDatabase();

  List<MovieVO>? getMovieListFromDatabase();

  Stream<List<MovieVO>?> getGetNowPlayingFromDatabaseStream();

  Stream<List<MovieVO>?> getPopularMovieFromDatabaseStream();

  Stream<List<MovieVO>?> getMovieListFromDatabaseStream();

  Stream watchGetNowPlayingMovieBox();

  Stream watchGetPopularMovieBox();

  Stream watchGetMoviesByGenresBox();

  void getNowPlayingMovieBoxClear();

  void getPopularMovieBoxClear();

  void getMoviesByGenresBoxClear();
}