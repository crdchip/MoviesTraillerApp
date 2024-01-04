import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:movies_trailler_apps/config/constants/api_movies.dart';

class HomeController extends GetxController {
  RxList listTrendingMovies = [].obs;
  RxList listUpmingMovies = [].obs;
  RxList listTopRatedMovies = [].obs;
  @override
  void onInit() {
    fetchTrendingMovies();
    fetchUpmingMovies();
    fetchTopRatedMovies();
    super.onInit();
  }

  fetchTrendingMovies() async {
    var data = await fetchApi(ApiMovies.trendingMoviesEndpoint, null);
    listTrendingMovies.value = data["results"];

    return listTrendingMovies;
  }

  fetchUpmingMovies() async {
    var data = await fetchApi(ApiMovies.upcomingMoviesEndpoint, null);
    listUpmingMovies.value = data["results"];
    update();
    return listUpmingMovies;
  }

  fetchTopRatedMovies() async {
    var data = await fetchApi(ApiMovies.topRatedMoviesEndpoint, null);
    listTopRatedMovies.value = data["results"];
    update();
    return listTopRatedMovies;
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
