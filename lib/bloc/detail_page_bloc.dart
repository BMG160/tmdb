import 'package:flutter/material.dart';
import 'package:tmdb/data/apply/apply.dart';
import 'package:tmdb/data/apply/apply_impl.dart';
import 'package:tmdb/data/vos/cast_vo/cast_vo.dart';
import 'package:tmdb/data/vos/crew_vo/crew_vo.dart';
import 'package:tmdb/data/vos/video_vo/video_vo.dart';
import 'package:tmdb/network/responses/detail_response/detail_response.dart';

import '../data/vos/movie_vo/movie_vo.dart';

class DetailPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  DetailResponse? movieVO;

  List<CastVO>? castList = [];
  List<CrewVO>? crewList = [];
  List<VideoVO>? videoList = [];
  int hour = 0;
  int min = 0;

  DetailResponse? get getMovieVO => movieVO;
  int get getHour => hour;
  int get getMin => min;
  List<CastVO>? get getCastList => castList;
  List<CrewVO>? get getCrewList => crewList;
  List<VideoVO>? get getVideoList => videoList;

  DetailPageBloc(String movieID){
    _apply.getDetailsFromNetwork(movieID).then((value) {
      movieVO = value;
      hour = (value.runtime ?? 0) ~/ 60;
      min = ((value.runtime ?? 0).toInt()) % 60;
      notifyListeners();
    });

    _apply.getCastFromNetwork(movieID).then((value) {
      castList = value;
      notifyListeners();
    });

    _apply.getCrewFromNetwork(movieID).then((value) {
      crewList = value;
      notifyListeners();
    });

    _apply.getVideoFromNetwork(movieID).then((value) {
      videoList = value;
      notifyListeners();
    });
  }
}

