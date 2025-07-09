import 'package:get/get.dart';
import 'package:revalesuva/model/article/article_model.dart' as article_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class ArticleViewModel extends GetxController {
  var listArticle = <article_model.Datum>[].obs;
  var isLoading = false.obs;

  fetchArticle() async {
    isLoading.value = true;
    var response = await Repository.instance.getArticleApi();
    isLoading.value = false;
    if (response is Success) {
      var result = article_model.articleModelFromJson(response.response.toString());
      listArticle.assignAll(result.data ?? []);
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  List<article_model.Datum> getInnerList({required int articleId}) {
    return listArticle.where((element) => element.id != articleId).toList();
  }
}
