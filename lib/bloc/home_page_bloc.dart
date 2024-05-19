import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/data/apply/apply.dart';
import 'package:tmdb/data/apply/apply_impl.dart';
import 'package:tmdb/data/vos/genres_vo/genres_vo.dart';

import '../data/vos/movie_vo/movie_vo.dart';

class HomePageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  final CarouselController _carouselController = CarouselController();

  int getNowPlayingPage = 1;
  int popularMoviePage = 1;
  int moviePage = 1;

  int genreID = 0;

  int selectedIndex = 0;

  final ScrollController _popularMovieScrollController = ScrollController();
  final ScrollController _movieScrollController = ScrollController();

  List<MovieVO>? getNowPlayingList;
  List<MovieVO>? getPopularMovieList;
  List<GenresVO>? genresList;
  List<MovieVO>? movieList;

  CarouselController get getCarouselController => _carouselController;
  List<MovieVO>? get getGetNowPlayingList => getNowPlayingList;
  List<MovieVO>? get getGetPopularMovieList => getPopularMovieList;
  List<GenresVO>? get getGenresList => genresList;
  int get getGenreID => genreID;
  int get getSelectedIndex => selectedIndex;
  List<MovieVO>? get getMovieList => movieList;
  ScrollController get getMovieScrollController => _movieScrollController;
  ScrollController get getPopularMovieScrollController => _popularMovieScrollController;

  HomePageBloc(){
    _apply.getNowPlayingMovieBoxClear();
    _apply.getPopularMovieBoxClear();
    _apply.getMovieByGenresBoxClear();

    _apply.getGetNowPlayingNetwork(getNowPlayingPage).then((value) {
      getNowPlayingList = value?.take(5).toList();
      notifyListeners();
    });

    _apply.getPopularMovieFromNetwork(popularMoviePage);

    _apply.getGenresFromNetwork().then((value) {
      if(value?.isNotEmpty ?? false){
        genresList = value;
        _apply.getMoviesByGenresFromNetwork(moviePage, genresList?.first.id ?? 0).then((value) {
          genreID = genresList?.first.id ?? 0;
          notifyListeners();
        });
      }
    });

    _apply.getGetPopularMovieFromDatabaseStream().listen((event) {
      getPopularMovieList = event;
      notifyListeners();
    });

    _apply.getMovieByGenresFromDatabaseStream().listen((event) {
      movieList = event;
      notifyListeners();
    });

    _popularMovieScrollController.addListener(() {
      if(_popularMovieScrollController.position.atEdge){
        double pixel = _popularMovieScrollController.position.pixels;
        if(pixel != 0){
          popularMoviePage++;
          _apply.getPopularMovieFromNetwork(popularMoviePage);
          notifyListeners();
        }
      }
    });

    _movieScrollController.addListener(() {
      if(_movieScrollController.position.atEdge){
        double pixel = _movieScrollController.position.pixels;
        if(pixel != 0){
          moviePage++;
          _apply.getMoviesByGenresFromNetwork(moviePage, genreID);
          notifyListeners();
        }
      }
    });
  }

  void changeMovieGenre(int newGenreID, int index){
    moviePage = 1;
    _apply.getMovieByGenresBoxClear();
    _apply.getMoviesByGenresFromNetwork(moviePage, newGenreID);
    genreID = newGenreID;
    selectedIndex = index;
    notifyListeners();
  }


}