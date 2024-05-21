
import 'package:stream_transform/stream_transform.dart';
import 'package:tmdb/data/apply/apply.dart';
import 'package:tmdb/data/vos/cast_vo/cast_vo.dart';
import 'package:tmdb/data/vos/crew_vo/crew_vo.dart';
import 'package:tmdb/data/vos/genres_vo/genres_vo.dart';
import 'package:tmdb/data/vos/movie_vo/movie_vo.dart';
import 'package:tmdb/data/vos/video_vo/video_vo.dart';
import 'package:tmdb/network/data_agent/data_agent.dart';
import 'package:tmdb/network/data_agent/data_agent_impl.dart';
import 'package:tmdb/network/responses/detail_response/detail_response.dart';
import 'package:tmdb/persistent/dao.dart';
import 'package:tmdb/persistent/dao_impl.dart';

class ApplyImpl extends Apply{
  ApplyImpl._();
  
  static final ApplyImpl _singleton = ApplyImpl._();
  
  factory ApplyImpl() => _singleton;
  
  final DataAgent _agent = DataAgentImpl();
  final Dao _dao = DaoImpl();

  @override
  Stream<List<MovieVO>?> getGetNowPlayingFromDatabaseStream() => _dao
      .watchGetNowPlayingMovieBox()
      .startWith(_dao.getGetNowPlayingFromDatabaseStream())
      .map((event) => _dao.getGetNowPlayingFromDatabase());

  @override
  Future<List<MovieVO>?> getGetNowPlayingNetwork(int page) => _agent.getGetNowPlayingNetwork(page).then((value) {
    final temp = value?.map((e) {
      e.isGetNowPlaying = true;
      return e;
    }).toList();
    return temp;
  });

  @override
  Future<List<MovieVO>?> getPopularMovieFromNetwork(int page) => _agent.getPopularMovieFromNetwork(page).then((value) {
    final temp = value?.map((e){
      e.isGetPopularMovie = true;
      return e;
    }).toList();
    _dao.saveGetPopularMovie(temp ?? []);
    return temp;
  });

  @override
  Future<List<MovieVO>?> getMoviesByGenresFromNetwork(int page, int genreID) => _agent.getMoviesByGenresFromNetwork(page, genreID).then((value) {
    final temp = value?.map((e) {
      e.isGetMovieByGenres = true;
      return e;
    }).toList();
    _dao.saveGetMovieByGenres(temp ?? []);
    return temp;
  });

  @override
  Future<DetailResponse> getDetailsFromNetwork(String movieID) {
    return _agent.getDetailsFromNetwork(movieID);
  }

  @override
  Future<List<GenresVO>?> getGenresFromNetwork() => _agent.getGenresFromNetwork();

  @override
  void getNowPlayingMovieBoxClear() => _dao.getNowPlayingMovieBoxClear();

  @override
  Stream<List<MovieVO>?> getGetPopularMovieFromDatabaseStream() => _dao
     .watchGetPopularMovieBox()
      .startWith(_dao.getPopularMovieFromDatabaseStream())
      .map((event) => _dao.getPopularMovieFromDatabase());

  @override
  void getPopularMovieBoxClear() => _dao.getPopularMovieBoxClear();

  @override
  void getMovieByGenresBoxClear() => _dao.getMoviesByGenresBoxClear();

  @override
  Stream<List<MovieVO>?> getMovieByGenresFromDatabaseStream() => _dao
      .watchGetMoviesByGenresBox()
      .startWith(_dao.getMovieListFromDatabaseStream())
      .map((event) => _dao.getMovieListFromDatabase());

  @override
  Future<List<CastVO>?> getCastFromNetwork(String movieID) => _agent.getCastFromNetwork(movieID);

  @override
  Future<List<CrewVO>?> getCrewFromNetwork(String movieID) => _agent.getCrewFromNetwork(movieID);

  @override
  Future<List<VideoVO>?> getVideoFromNetwork(String movieID) => _agent.getVideoFromNetwork(movieID);

  @override
  Future<List<MovieVO>?> getSimilarMovieFromNetwork(String movieID, int page) => _agent.getSimilarMovieFromNetwork(movieID, page);

  @override
  Future<List<MovieVO>?> getSearchMovieFromNetwork(String query) => _agent.getSearchMovieFromNetwork(query);

}