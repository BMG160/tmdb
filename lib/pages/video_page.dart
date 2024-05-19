import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/constant/color.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../bloc/video_page_bloc.dart';

class VideoPage extends StatelessWidget {
  final String uri;
  const VideoPage({super.key, required this.uri});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VideoPageBloc>(
        create: (_) => VideoPageBloc(uri),
        child: Scaffold(
          backgroundColor: kPrimaryBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new, color: kIconColor,),
            ),
          ),
          body: Selector<VideoPageBloc, YoutubePlayerController?>(
            selector: (_, bloc) => bloc.getController,
            builder: (_, controller, child) => (controller == null) ?
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kIconColor,
                    ),
                  ),
                ) : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: controller,
                      showVideoProgressIndicator: true,
                    ),
                    builder: (context, player){
                      return player;
                    }
                ),
              ),
            )
          ),
        ),
    );
  }
}
