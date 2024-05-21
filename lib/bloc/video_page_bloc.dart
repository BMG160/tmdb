import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class VideoPageBloc extends ChangeNotifier{
  YoutubePlayerController? controller;

  bool _dispose = false;

  bool get isDispose => _dispose;
  YoutubePlayerController? get getController => controller;

  VideoPageBloc(String uri){
    controller = YoutubePlayerController(initialVideoId: uri, flags: const YoutubePlayerFlags(autoPlay: true, mute: false));
    notifyListeners();
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
    controller?.dispose();
  }
}