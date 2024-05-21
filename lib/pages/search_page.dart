import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/constant/api_constant.dart';
import 'package:tmdb/constant/color.dart';
import 'package:tmdb/data/vos/movie_vo/movie_vo.dart';
import 'package:tmdb/pages/detail_page.dart';
import 'package:tmdb/utils/extensions.dart';

import '../bloc/search_page_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchPageBloc>(
        create: (_) => SearchPageBloc(),
        child: Scaffold(
          backgroundColor: kPrimaryBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new, color: kIconColor,)),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Selector<SearchPageBloc, TextEditingController>(
                        selector: (_, bloc) => bloc.getSearchController,
                        builder: (_, searchController, child) => SizedBox(
                          width: MediaQuery.of(context).size.width*0.75,
                          height: 50,
                          child: TextFormField(
                            controller: searchController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(color: kPrimaryTextColor, fontSize: 15),
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: const TextStyle(color: kPrimaryTextColor, fontSize: 15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: kPrimaryTextColor)
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: kPrimaryTextColor),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: kPrimaryTextColor),
                                  borderRadius: BorderRadius.circular(10)
                              ),

                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const SearchButton(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Selector<SearchPageBloc, List<MovieVO>?>(
                    selector: (_, bloc) => bloc.getMovieList,
                    builder: (_, movieList, child) => SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.8,
                      child: (movieList?.isEmpty ?? false) ? const Center(
                        child: Text('SEARCH...', style: TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                      ) :
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: movieList?.length ?? 0,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: (){
                            context.navigateToNextScreenReplace(context, DetailPage(movieID: (movieList?[index].id ?? 0).toString()));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: (movieList?[index].backdropPath == null) ? CachedNetworkImage(imageUrl: kDefaultImage, fit: BoxFit.cover,) : CachedNetworkImage(imageUrl: "$kPrefixImageLink${movieList?[index].backdropPath}", fit: BoxFit.cover,)
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.55,
                                  height: 150,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${movieList?[index].title ?? 'Unknown'} (${movieList?[index].releaseDate ?? ''})", style: const TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('${movieList?[index].voteAverage?.toStringAsFixed(1)}', style: const TextStyle(color: kPrimaryTextColor, fontSize: 15),),
                                          RatingBar.builder(
                                              initialRating: movieList?[index].voteAverage as double,
                                              allowHalfRating: true,
                                              ignoreGestures: true,
                                              itemCount: 10,
                                              itemPadding: const EdgeInsets.symmetric(horizontal: 0.5),
                                              itemSize: 15,
                                              itemBuilder: (context, _) => const Icon(Icons.star, color: kSecondaryBackgroundColor,),
                                              onRatingUpdate: (rating){

                                              }
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(height: 20,),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<SearchPageBloc, TextEditingController>(
      selector: (_, bloc) => bloc.getSearchController,
      builder: (_, searchController, child) => GestureDetector(
        onTap: (){
          context.read<SearchPageBloc>().searchMovie(searchController.text);
        },
        child: Container(
          width: MediaQuery.of(context).size.width*0.15,
          height: 50,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: kSecondaryBackgroundColor
          ),
          child: const Center(child: Icon(Icons.search, color: kIconColor, size: 15,),),
        ),
      ),
    );
  }
}

