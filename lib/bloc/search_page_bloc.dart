import 'package:flutter/material.dart';
import 'package:tmdb/data/apply/apply.dart';
import 'package:tmdb/data/apply/apply_impl.dart';

import '../data/vos/movie_vo/movie_vo.dart';

class SearchPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;


  final TextEditingController _searchController = TextEditingController();

  List<MovieVO>? movieList = [];

  bool get isDispose => _dispose;
  TextEditingController get getSearchController => _searchController;
  List<MovieVO>? get getMovieList => movieList;

  void searchMovie(String query){
    _apply.getSearchMovieFromNetwork(query).then((value) {
      movieList = value;
      notifyListeners();
    });
  }

  @override
  void notifyListeners() {
    if(!_dispose){
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dispose = true;
    _searchController.dispose();
  }
}