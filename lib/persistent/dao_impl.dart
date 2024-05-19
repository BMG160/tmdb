
import 'package:hive/hive.dart';
import 'package:tmdb/constant/hive_constant.dart';
import 'package:tmdb/persistent/dao.dart';
import 'package:tmdb/data/vos/movie_vo/movie_vo.dart';

class DaoImpl extends Dao{
  DaoImpl._();

  static final DaoImpl _singleton = DaoImpl._();

  factory DaoImpl() => _singleton;

  Box<MovieVO> _getNowPlayingBox() => Hive.box<MovieVO>(kBoxNameGetNowPlaying);
  Box<MovieVO> _getPopularMovieBox() => Hive.box<MovieVO>(kBoxNameGetPopularMovie);
  Box<MovieVO> _getMoviesByGenresBox() => Hive.box<MovieVO>(kBoxNameGetMoviesByGenres);

  @override
  List<MovieVO>? getGetNowPlayingFromDatabase() {
    final getMovies = _getNowPlayingBox().values.toList();
    getMovies.sort((a,b) => a.order ?? 0.compareTo(b.order ?? 0));
    return getMovies
        .where((element) => element.isGetNowPlaying ?? false)
        .toList();
  }

  @override
  List<MovieVO>? getPopularMovieFromDatabase() {
    final getMovies = _getPopularMovieBox().values.toList();
    getMovies.sort((a,b) => a.order!.compareTo(b.order!));
    return getMovies
        .where((element) => element.isGetPopularMovie ?? false)
        .toList();
  }

  @override
  List<MovieVO>? getMovieListFromDatabase() {
    final getMovies = _getMoviesByGenresBox().values.toList();
    getMovies.sort((a,b) => a.order!.compareTo(b.order!));
    return getMovies
        .where((element) => element.isGetMovieByGenres ?? false)
        .toList();
  }

  @override
  Stream<List<MovieVO>?> getGetNowPlayingFromDatabaseStream() => Stream.value(getGetNowPlayingFromDatabase());

  @override
  Stream<List<MovieVO>?> getPopularMovieFromDatabaseStream() => Stream.value(getPopularMovieFromDatabase());

  @override
  Stream<List<MovieVO>?> getMovieListFromDatabaseStream() => Stream.value(getMovieListFromDatabase());

  @override
  void saveGetNowPlaying(List<MovieVO> getNowPlayingMovieList) {
   int count = 0;
   final temp = getGetNowPlayingFromDatabase();
   if(temp != null && temp.isNotEmpty){
     count = temp.last.order ?? 0;
   } else {
     count = 0;
   }
   for(MovieVO movie in getNowPlayingMovieList){
     count++;
     movie.order = count;
     _getNowPlayingBox().put(movie.id, movie);
   }
  }

  @override
  void saveGetPopularMovie(List<MovieVO> getPopularMovieList) {
    int count = 0;
    final temp = getPopularMovieFromDatabase();
    if(temp != null && temp.isNotEmpty){
      count = temp.last.order ?? 0;
    } else {
      count = 0;
    }
    for(MovieVO movie in getPopularMovieList){
      count++;
      movie.order = count;
      _getPopularMovieBox().put(movie.id, movie);
    }
  }

  @override
  void saveGetMovieByGenres(List<MovieVO> movieList) {
    int count = 0;
    final temp = getMovieListFromDatabase();
    if(temp != null && temp.isNotEmpty){
      count = temp.last.order ?? 0;
    } else {
      count = 0;
    }
    for(MovieVO movie in movieList){
      count++;
      movie.order = count;
      _getMoviesByGenresBox().put(movie.id, movie);
    }
  }

  @override
  Stream watchGetNowPlayingMovieBox() => _getNowPlayingBox().watch();

  @override
  Stream watchGetPopularMovieBox() => _getPopularMovieBox().watch();

  @override
  Stream watchGetMoviesByGenresBox() => _getMoviesByGenresBox().watch();

  @override
  void getNowPlayingMovieBoxClear() => _getNowPlayingBox().clear();

  @override
  void getPopularMovieBoxClear() => _getPopularMovieBox().clear();
  @override
  void getMoviesByGenresBoxClear() => _getMoviesByGenresBox().clear();

}