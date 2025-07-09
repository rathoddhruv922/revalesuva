import 'package:get/get.dart';
import 'package:revalesuva/model/personal_detail/user_model.dart' as user_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/helper_method.dart';

class BloodReportViewModel extends GetxController {
  var userData = user_model.Data().obs;
  var listBloodTest = <user_model.BloodTest>[].obs;
  var isLoading = false.obs;

  getCustomerDetailById({required String customerId}) async {
    var response = await Repository.instance.getCustomerDetailByIdApi(
      customerId: customerId,
    );
    if (response is Success) {
      var result = user_model.userModelFromJson(response.response.toString());
      userData.value = result.data ?? user_model.Data();
      listBloodTest.assignAll(userData.value.bloodTests?.reversed ?? []);
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }
}
