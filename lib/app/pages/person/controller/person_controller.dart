import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:movies_trailler_apps/config/constants/api_movies.dart';

class PersonController extends GetxController {
  RxBool isFavourite = false.obs;

  RxInt idPerson = 0.obs;

  RxMap<String, dynamic> personDetail = <String, dynamic>{}.obs;
  RxList listPersonMovie = [].obs;

  @override
  void onInit() {
    var id = Get.arguments;
    idPerson.value = id;
    fetchPersonDetail();
    fetchPersonMovies();
    super.onInit();
  }

  onChangeStatusFavourite() {
    isFavourite.value = !isFavourite.value;
    update();
  }

  fetchPersonDetail() async {
    var data =
        await fetchApi(ApiMovies.personDetailsEndpoint(idPerson.value), null);
    personDetail.value = data;
    update();
    return personDetail;
  }

  fetchPersonMovies() async {
    var data =
        await fetchApi(ApiMovies.personMoviesEndpoint(idPerson.value), null);
    listPersonMovie.value = data["cast"];
    update();
    return listPersonMovie;
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
