////Base URL
const kBaseURL = "https://api.themoviedb.org/3";

////End Point
const kGetNowPlayingEndPoint = "/movie/now_playing";
const kGetPopularMovieEndPoint = "/movie/popular";
const kGetGenresEndPoint = "/genre/movie/list";
const kGetMoviesByGenresEndPoint = "/discover/movie";
const kGetDetailEndPoint = "/movie/{$kPathParamsMovieID}";
const kGetCreditsEndPoint = "/movie/{$kPathParamsMovieID}/credits";
const kGetVideoEndPoint = "/movie/{$kPathParamsMovieID}/videos";
const kGetSimilarMovieEndPoint = "/movie/{$kPathParamsMovieID}/similar";
const kGetSearchMovieEndPoint = "/search/movie";

////Api Key
const kApiKey = "4a11f8fb1f5819153818ec4a83e6799a";

////Query Params
const kQueryParamsApiKey = "api_key";
const kQueryParamsPage = "page";
const kQueryParamsWithGenres = "with_genres";
const kQueryParamsMovieID = "id";
const kQueryParamsQuery = "query";

const kPathParamsMovieID = "movie_id";

////Image Constant
const kPrefixImageLink = "https://image.tmdb.org/t/p/w500";
const kDefaultImage = "https://user-images.githubusercontent.com/43302778/106805462-7a908400-6645-11eb-958f-cd72b74a17b3.jpg";
