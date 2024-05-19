import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class VideoPageBloc extends ChangeNotifier{
  YoutubePlayerController? controller;

  YoutubePlayerController? get getController => controller;

  VideoPageBloc(String uri){
    controller = YoutubePlayerController(initialVideoId: uri, flags: YoutubePlayerFlags(autoPlay: true, mute: false));
    notifyListeners();
  }
}