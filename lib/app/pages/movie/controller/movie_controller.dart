import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:movies_trailler_apps/config/constants/api_movies.dart';

class MovieController extends GetxController {
  RxBool isFavourite = false.obs;
  RxList listGenres = [].obs;
  RxInt idMovie = 0.obs;
  RxMap<String, dynamic> movieDetail = <String, dynamic>{}.obs;
  RxList listTopCast = [].obs;
  RxList listMoviesSimalar = [].obs;
  RxList listMovieTrailler = [].obs;
  RxBool isLoadPage = false.obs;

  onChangeStatusFavourite() {
    isFavourite.value = !isFavourite.value;
    update();
  }

  @override
  void onInit() {
    var id = Get.arguments;
    idMovie.value = id;
    isLoadPage(false);
    fetchMoviesDetail();
    fetchMovieCast();
    fetchMoviesSimalar();
    fetchMoviesTrailler();
    isLoadPage(true);
    super.onInit();
  }

  fetchMoviesDetail() async {
    var data =
        await fetchApi(ApiMovies.movieDetailsEndpoint(idMovie.value), null);
    movieDetail.value = data;
    listGenres.value = [];
    for (var i = 0; i < data["genres"].length; i++) {
      listGenres.add(data["genres"][i]["name"]);
    }
    update();
    return movieDetail;
  }

  fetchMovieCast() async {
    var data =
        await fetchApi(ApiMovies.movieCreditsEndpoint(idMovie.value), null);
    listTopCast.value = data["cast"];
    update();
    return listTopCast;
  }

  fetchMoviesSimalar() async {
    var data =
        await fetchApi(ApiMovies.similarMoviesEndpoint(idMovie.value), null);
    listMoviesSimalar.value = data["results"];
    update();
    return listMoviesSimalar;
  }

  fetchMoviesTrailler() async {
    var data =
        await fetchApi(ApiMovies.movieVideosEndpoimt(idMovie.value), null);
    listMovieTrailler.value = [];
    for (var i = 0; i < data["results"].length; i++) {
      if (data["results"][i]["type"] == "Trailer") {
        listMovieTrailler.add(data["results"][i]);
      }
    }
    update();
    return listMovieTrailler;
  }

  fetchApi(endpoints, params) async {
    var dio = Dio();
    Response response;
    var url = endpoints;
    try {
      response = await dio.get(url, queryParameters: params ?? {});
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return {};
      }
    }
  }
}
