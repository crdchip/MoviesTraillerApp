import 'package:movies_trailler_apps/config/constants/constants.dart';

class ApiMovies {
  static String api_key = AppConstant.apiKey;

  // endpoints
  static const String apiBaseUrl = 'https://api.themoviedb.org/3';
  static String trendingMoviesEndpoint =
      "$apiBaseUrl/trending/movie/day?api_key=$api_key";
  static String upcomingMoviesEndpoint =
      "$apiBaseUrl/movie/upcoming?api_key=$api_key";
  static String topRatedMoviesEndpoint =
      "$apiBaseUrl/movie/top_rated?api_key=$api_key";
  static String searchMoviesEndpoint =
      "$apiBaseUrl/search/movie?api_key=$api_key";

  // movie
  static String movieDetailsEndpoint(int id) =>
      "$apiBaseUrl/movie/$id?api_key=$api_key";
  static String movieCreditsEndpoint(int id) =>
      "$apiBaseUrl/movie/$id/credits?api_key=$api_key";
  static String similarMoviesEndpoint(int id) =>
      "$apiBaseUrl/movie/$id/similar?api_key=$api_key";
  static String movieVideosEndpoimt(int id) =>
      "$apiBaseUrl/movie/$id/videos?api_key=$api_key";

  // person
  static String personDetailsEndpoint(int id) =>
      "$apiBaseUrl/person/$id?api_key=$api_key";
  static String personMoviesEndpoint(int id) =>
      "$apiBaseUrl/person/$id/movie_credits?api_key=$api_key";

  // functions to get images of different widths, (show images using these to improve the loading times)
  static const String image500 = 'https://image.tmdb.org/t/p/w500';
  static const String image342 = 'https://image.tmdb.org/t/p/w342';
  static const String image185 = 'https://image.tmdb.org/t/p/w185';
  static const String videosYt = 'https://www.youtube.com/watch?v=';

  // fallback images
  static const String fallbackMoviePoster =
      'https://img.myloview.com/stickers/white-laptop-screen-with-hd-video-technology-icon-isolated-on-grey-background-abstract-circle-random-dots-vector-illustration-400-176057922.jpg';
  static const String fallbackPersonImage =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmUiF-YGjavA63_Au8jQj7zxnFxS_Ay9xc6pxleMqCxH92SzeNSjBTwZ0l61E4B3KTS7o&usqp=CAU';
  static const String fallbackMovieVideo =
      'https://www.youtube.com/watch?v=PoF4B_xPVlg';
}
