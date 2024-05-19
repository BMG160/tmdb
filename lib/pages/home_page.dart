import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/bloc/home_page_bloc.dart';
import 'package:tmdb/constant/color.dart';
import 'package:tmdb/data/vos/genres_vo/genres_vo.dart';
import 'package:tmdb/data/vos/movie_vo/movie_vo.dart';
import 'package:tmdb/pages/detail_page.dart';
import 'package:tmdb/utils/extensions.dart';

import '../constant/api_constant.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
        create: (_) => HomePageBloc(),
        child: Scaffold(
          backgroundColor: kPrimaryBackgroundColor,
          appBar: AppBar(
            backgroundColor: kPrimaryBackgroundColor,
            centerTitle: true,
            title: const Text('TMDB App', style: TextStyle(color: kPrimaryTextColor, fontSize: 25, fontWeight: FontWeight.w900),),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BannerView(),
                    PopularMovieView(),
                    MovieView()
                  ],
                )
            ),
          )
        ),
    );
  }
}

class BannerView extends StatelessWidget {
  const BannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 500,
      child: Selector<HomePageBloc, List<MovieVO>?>(
          selector: (_, bloc) => bloc.getGetNowPlayingList,
          builder: (_, getNowPlayingList, child) => (getNowPlayingList == null) ?
          const Center(
            child: CircularProgressIndicator(
              color: kIconColor,
            ),
          ) : CarouselSlider.builder(
            itemCount: getNowPlayingList.length,
            itemBuilder: (context, itemIndex, pageIndex) => GestureDetector(
              onTap: (){
                context.navigateToNextScreenReplace(context, DetailPage(movieID: (getNowPlayingList[itemIndex].id ?? '').toString()));
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Stack(
                  children: [
                    Positioned.fill(child: (getNowPlayingList[itemIndex].posterPath==null) ? CachedNetworkImage(imageUrl: kDefaultImage, fit: BoxFit.fill,) : CachedNetworkImage(imageUrl: "$kPrefixImageLink${getNowPlayingList[itemIndex].posterPath}", fit: BoxFit.fill,)),
                    Positioned.fill(child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          )
                      ),
                    )),
                    const Positioned.fill(
                      child: Icon(
                        Icons.play_circle,
                        color: kIconColor,
                        size: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              enlargeCenterPage: true,
              viewportFraction: 0.7,
              aspectRatio: 1,
              initialPage: 1,
            ),
          )
      ),
    );
  }
}

class PopularMovieView extends StatelessWidget {
  const PopularMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 450,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Text('Popular Movies', style: TextStyle(color: kPrimaryTextColor, fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          Selector<HomePageBloc, ScrollController>(
            selector: (_, bloc) => bloc.getPopularMovieScrollController,
            builder: (_, popularMovieScrollController, child) => Selector<HomePageBloc, List<MovieVO>?>(
              selector: (_, bloc) => bloc.getGetPopularMovieList,
              builder: (_, popularMovieList, child) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: (popularMovieList == null) ?
                  const Center(
                      child: CircularProgressIndicator(
                        color: kIconColor,
                      )
                  ) : ListView.separated(
                    controller: popularMovieScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: popularMovieList.length,
                    itemBuilder: (context, index) =>GestureDetector(
                      onTap: (){
                        context.navigateToNextScreenReplace(context, DetailPage(movieID: (popularMovieList?[index].id ?? '').toString()));
                      },
                      child: SizedBox(
                        width: 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 300,
                                child:(popularMovieList[index].backdropPath == null) ? CachedNetworkImage(imageUrl: kDefaultImage, fit: BoxFit.fill,) :
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                  child:  CachedNetworkImage(imageUrl: "$kPrefixImageLink${popularMovieList[index].backdropPath ?? ''}", fit: BoxFit.fill,),
                                )
                            ),
                            SizedBox(
                              height: 100,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(popularMovieList[index].title ?? '', style: const TextStyle(color: kPrimaryTextColor, fontSize: 15, fontWeight: FontWeight.normal),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('${popularMovieList[index].voteAverage?.toStringAsFixed(1)}', style: const TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                                      const SizedBox(
                                        width: 0.5,
                                      ),
                                      RatingBar.builder(
                                          initialRating: popularMovieList[index].voteAverage as double,
                                          allowHalfRating: true,
                                          ignoreGestures: true,
                                          itemCount: 10,
                                          itemPadding: const EdgeInsets.symmetric(horizontal: 0.5),
                                          itemSize: 15,
                                          itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.white,),
                                          onRatingUpdate: (rating){

                                          })
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(width: 20,),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}


class MovieView extends StatelessWidget {
  const MovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 550,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Selector<HomePageBloc, List<GenresVO>?>(
            selector: (_, bloc) => bloc.getGenresList,
            builder: (_, genresList, child) => Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: (genresList == null) ?
              const Center(
                child: CircularProgressIndicator(
                  color: kIconColor,
                ),
              ) : Selector<HomePageBloc, int>(
                selector: (_, bloc) => bloc.getSelectedIndex,
                builder: (_, selectedIndex, child) => ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: (){
                        context.read<HomePageBloc>().changeMovieGenre(genresList[index].id ?? 0, index);
                      },
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: (index == selectedIndex) ? kSecondaryBackgroundColor : kTertiaryBackgroundColor,
                        ),
                        child: Center(
                          child: Text(genresList[index].name ?? '', style: TextStyle(color: kPrimaryTextColor),),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(width: 20,),
                    itemCount: genresList.length
                ),
              )
            )
          ),
          Selector<HomePageBloc, ScrollController>(
            selector: (_, bloc) => bloc.getMovieScrollController,
            builder: (_, movieScrollController, child) => Selector<HomePageBloc, List<MovieVO>?>(
              selector: (_, bloc) => bloc.getMovieList,
              builder: (_, movieList, child) => SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 450,
                  child: (movieList == null) ? const Center(
                    child: CircularProgressIndicator(),
                  ) :
                  ListView.separated(
                    controller: movieScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: movieList.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: (){
                        context.navigateToNextScreenReplace(context, DetailPage(movieID:( movieList?[index].id ?? '').toString()));
                      },
                      child: Container(
                        width: 200,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 300,
                                child: (movieList[index].backdropPath == null) ?
                                CachedNetworkImage(imageUrl: kDefaultImage) :
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                  child: CachedNetworkImage(imageUrl: "$kPrefixImageLink${movieList[index].backdropPath}", fit: BoxFit.fill, placeholder: (context, _) => const Center(child: CircularProgressIndicator(color: kIconColor,),),),
                                )
                            ),
                            SizedBox(
                              height: 150,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: Text(movieList[index].title ?? '', style: const TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('${movieList[index].voteAverage?.toStringAsFixed(1)}', style: const TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                                        const SizedBox(
                                          width: 0.5,
                                        ),
                                        RatingBar.builder(
                                            initialRating: movieList[index].voteAverage as double,
                                            allowHalfRating: true,
                                            ignoreGestures: true,
                                            itemCount: 10,
                                            itemPadding: const EdgeInsets.symmetric(horizontal: 0.5),
                                            itemSize: 15,
                                            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.white,),
                                            onRatingUpdate: (rating){

                                            })
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 20,
                    ),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}


