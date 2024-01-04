import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:movies_trailler_apps/config/constants/api_movies.dart';

class SearchMoviesController extends GetxController {
  RxList listSearchMovies = [].obs;
  TextEditingController searchController = TextEditingController();

  fetchSearchMovies({required Map<String, dynamic> keyMovies}) async {
    var data = await fetchApi(ApiMovies.searchMoviesEndpoint, keyMovies);
    listSearchMovies.value = data["results"];
    update();
    return listSearchMovies;
  }

  fetchApi(endpoints, params) async {
    var dio = Dio();
    Response response;
    var url = endpoints;
    try {
      response = await dio.get(url,
          options: Options(), queryParameters: params ?? {"query : ''"});
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
