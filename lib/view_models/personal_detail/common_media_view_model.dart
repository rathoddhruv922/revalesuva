import 'package:get/get.dart';
import 'package:revalesuva/model/cms/cms_model.dart' as cms_model;
import 'package:revalesuva/model/common_media/common_media_model.dart' as common_media_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class CommonMediaViewModel extends GetxController {
  var howToTakeUrl = "".obs;
  var howToTakeVideoId = "".obs;
  var howToMeasure = "".obs;
  var howToMeasureVideoId = "".obs;
  var letsGetStarted = "".obs;
  var letsGetStartedVideoId = "".obs;
  var cmsModel = cms_model.CmsModel().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  callCommonMedia() async {
    var response = await Repository.instance.getCommonMedia();
    if (response is Success) {
      var result = common_media_model.commonMediaModelFromJson(response.response.toString());
      for (common_media_model.Datum data in result.data ?? []) {
        if (data.slug == "how-to-take") {
          howToTakeVideoId.value = data.vimeoVideoId ?? "";
          howToTakeUrl.value = data.mediaUrl ?? "";
        } else if (data.slug == "how-to-measure") {
          howToMeasureVideoId.value = data.vimeoVideoId ?? "";
          howToMeasure.value = data.mediaUrl ?? "";
        } else if (data.slug == "lets-get-started") {
          letsGetStartedVideoId.value = data.vimeoVideoId ?? "";
          letsGetStarted.value = data.mediaUrl ?? "";
        }
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  callGetCms() async {
    var response = await Repository.instance.getCmsApi();
    if (response is Success) {
      if (response.code == 200) {
        cmsModel.value = cms_model.cmsModelFromJson(response.response.toString());
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  cms_model.Datum? getCmsData({required String slug}) {
    if (cmsModel.value.data != null) {
      for (var cms in cmsModel.value.data!) {
        if (cms.slug == slug) {
          return cms;
        }
      }
    }
    return null;
  }
}
