import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb/constant/api_constant.dart';
import 'package:tmdb/network/responses/detail_response/detail_response.dart';
import 'package:tmdb/network/responses/get_genres_response/get_genres_response.dart';
import 'package:tmdb/network/responses/movie_response/get_now_playing_response.dart';


import '../responses/credits_response/credits_response.dart';
import '../responses/video_response/video_response.dart';

part 'api.g.dart';

@RestApi(baseUrl: kBaseURL)
abstract class Api{

  factory Api(Dio dio) => _Api(dio);

  @GET(kGetNowPlayingEndPoint)
  Future<GetNowPlayingResponse> getNowPlayingResponse(
      @Query(kQueryParamsApiKey) String apiKey,
      @Query(kQueryParamsPage) int page
      );

  @GET(kGetPopularMovieEndPoint)
  Future<GetNowPlayingResponse> getPopularMovieResponse(
      @Query(kQueryParamsApiKey) String apiKey,
      @Query(kQueryParamsPage) int page
      );

  @GET(kGetMoviesByGenresEndPoint)
  Future<GetNowPlayingResponse> getMoviesByGenresResponse(
      @Query(kQueryParamsApiKey) String apiKey,
      @Query(kQueryParamsPage) int page,
      @Query(kQueryParamsWithGenres) int genreID
      );

  @GET(kGetDetailEndPoint)
  Future<DetailResponse> getDetailResponse(
      @Path(kPathParamsMovieID) String movieID,
      @Query(kQueryParamsApiKey) String apiKey,
      );

  @GET(kGetGenresEndPoint)
  Future<GetGenresResponse> getGenresResponse(
      @Query(kQueryParamsApiKey) String apiKey,
      );

  @GET(kGetCreditsEndPoint)
  Future<CreditsResponse> getCreditsResponse(
      @Path(kPathParamsMovieID) String movieID,
      @Query(kQueryParamsApiKey) String apiKey,
      );

  @GET(kGetVideoEndPoint)
  Future<VideoResponse> getVideoResponse(
      @Path(kPathParamsMovieID) String movieID,
      @Query(kQueryParamsApiKey) String apiKey,
      );

  @GET(kGetSimilarMovieEndPoint)
  Future<GetNowPlayingResponse> getSimilarMovieResponse(
      @Path(kPathParamsMovieID) String movieID,
      @Query(kQueryParamsApiKey) String apiKey,
      @Query(kQueryParamsPage) int page
      );

  @GET(kGetSearchMovieEndPoint)
  Future<GetNowPlayingResponse> getSearchMovieResponse(
      @Query(kQueryParamsApiKey) String apiKey,
      @Query(kQueryParamsQuery) String query
      );
}