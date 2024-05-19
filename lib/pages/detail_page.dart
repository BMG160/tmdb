import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/bloc/detail_page_bloc.dart';
import 'package:tmdb/constant/api_constant.dart';
import 'package:tmdb/constant/color.dart';
import 'package:tmdb/data/vos/cast_vo/cast_vo.dart';
import 'package:tmdb/data/vos/crew_vo/crew_vo.dart';
import 'package:tmdb/data/vos/video_vo/video_vo.dart';
import 'package:tmdb/network/responses/detail_response/detail_response.dart';
import 'package:tmdb/pages/video_page.dart';
import 'package:tmdb/utils/extensions.dart';

import '../data/vos/movie_vo/movie_vo.dart';

class DetailPage extends StatelessWidget {
  final String movieID;
  const DetailPage({super.key, required this.movieID});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailPageBloc>(
      create: (_) => DetailPageBloc(movieID),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: kPrimaryBackgroundColor,
        body: Selector<DetailPageBloc, DetailResponse?>(
          selector: (_, bloc) => bloc.getMovieVO,
          builder: (_, movie, child) => (movie == null) ?
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(
                color: kIconColor,
              ),
            ),
          ) : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: (movie.backdropPath == null) ?
                  CachedNetworkImage(imageUrl: kDefaultImage, fit: BoxFit.fill,) :
                      Stack(
                        children: [
                          Positioned.fill(child: CachedNetworkImage(imageUrl: "$kPrefixImageLink${movie.backdropPath}", fit: BoxFit.fill,)),
                          Positioned.fill(child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter
                              )
                            ),
                          )),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.height,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(movie?.originalTitle ?? 'Unknown', style: TextStyle(color: kPrimaryTextColor, fontSize: 25,),),
                            ),
                          )
                        ],
                      )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.start,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            spacing: 10,
                            runAlignment: WrapAlignment.start,
                            runSpacing: 10,
                            children: List.generate(movie.genres?.length ?? 0, (index) => Container(
                              width: 120,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: const BoxDecoration(
                                  color: kSecondaryBackgroundColor,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: Center(
                                child: Text(movie.genres?[index].name ?? '', style: const TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                              ),
                            )),
                          ),
                          Container(
                            width: 120,
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: kTertiaryBackgroundColor
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timelapse,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  Selector<DetailPageBloc, int>(
                                    selector: (_, bloc) => bloc.getHour,
                                    builder: (_, hour, child) => Selector<DetailPageBloc, int>(
                                      selector: (_, bloc) => bloc.getMin,
                                      builder: (_, min, child) => Text("${hour}hr${min}min", style: TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Overview', style: TextStyle(color: kSecondaryBackgroundColor, fontSize: 15,),),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(movie?.overview ?? '', style: TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('About', style: TextStyle(color: kSecondaryBackgroundColor, fontSize: 15,),),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text('Original Title', style: TextStyle(color: kSecondaryTextColor, fontSize: 15),),
                          ),
                          SizedBox(
                            child: Text(movie.originalTitle ?? '', style: TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text('Released Date', style: TextStyle(color: kSecondaryTextColor, fontSize: 15),),
                          ),
                          SizedBox(
                            child: Text(movie.releaseDate ?? '', style: TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text('Rating', style: TextStyle(color: kSecondaryTextColor, fontSize: 15),),
                          ),
                          SizedBox(
                            child: Text(movie.voteAverage.toString() ?? '', style: TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text('Description', style: TextStyle(color: kSecondaryTextColor, fontSize: 15),),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Text(movie.overview ?? '', style: const TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Cast', style: TextStyle(color: kSecondaryBackgroundColor, fontSize: 15),),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: Selector<DetailPageBloc, List<CastVO>?>(
                          selector: (_, bloc) => bloc.getCastList,
                          builder: (_, castList, child) => (castList?.isEmpty ?? false) ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ) : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: castList?.length ?? 0,
                            itemBuilder: (context, index) => Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: CachedNetworkImage(imageUrl: "$kPrefixImageLink${castList?[index].profilePath ?? ''}", fit: BoxFit.cover,),
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: Text("${castList?[index].originalName} as ${castList?[index].character}", style: TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                                )
                              ],
                            ),
                            separatorBuilder: (context, index) => const SizedBox(width: 20,),
                          )
                        ),
                      ),
                      Text('Crew', style: TextStyle(color: kSecondaryBackgroundColor, fontSize: 15),),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: Selector<DetailPageBloc, List<CrewVO>?>(
                            selector: (_, bloc) => bloc.getCrewList,
                            builder: (_, crewList, child) => (crewList?.isEmpty ?? false) ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ) : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: crewList?.length ?? 0,
                              itemBuilder: (context, index) => Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: (crewList?[index].profilePath == null) ? CachedNetworkImage(imageUrl: kDefaultImage, fit: BoxFit.cover,) : CachedNetworkImage(imageUrl: "$kPrefixImageLink${crewList?[index].profilePath ?? ''}", fit: BoxFit.cover,),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: Text("${crewList?[index].originalName} (${crewList?[index].job})", style: TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                                  )
                                ],
                              ),
                              separatorBuilder: (context, index) => const SizedBox(width: 20,),
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: Selector<DetailPageBloc, List<VideoVO>?>(
                          selector: (_, bloc) => bloc.getVideoList,
                          builder: (_, videoList, child) => (videoList?.isEmpty ?? false) ? 
                          Center(
                            child: CircularProgressIndicator(
                              color: kIconColor,
                            ),
                          ) : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: videoList?.length ?? 0,
                            itemBuilder: (context, index) => Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 50,
                                  child: Text(videoList?[index].type ?? "Unknown", style: TextStyle(color: kSecondaryBackgroundColor, fontSize: 15),),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                          child: Container(
                                            color: kTertiaryBackgroundColor,
                                          )
                                      ),
                                      Positioned.fill(
                                          child: IconButton(
                                              onPressed: (){
                                                context.navigateToNextScreenReplace(context, VideoPage(uri: videoList?[index].key ?? ''));
                                              },
                                              icon: Icon(Icons.play_circle, color: kIconColor, size: 25,)
                                          )
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            separatorBuilder: (context, index) => const SizedBox(width: 10,),
                          )
                        ),
                      )
                    ],
                  )
                ),

              ],
            ),
          )
        )
      ),
    );
  }
}
