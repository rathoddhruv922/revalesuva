import 'package:get/get.dart';
import 'package:revalesuva/model/medical_question/create_user_answer_model.dart'
    as create_user_answer_model;
import 'package:revalesuva/model/my_plan/program_completion_report/submit_program_answer_model.dart'
    as submit_program_answer_model;
import 'package:revalesuva/model/order/create_order_model.dart';
import 'package:revalesuva/model/personal_detail/set_user_model.dart' as set_user;
import 'package:revalesuva/model/tools/nutrition_model/change_nutrition_status_model.dart';
import 'package:revalesuva/model/tools/nutrition_model/store_nutrition_model.dart'
    as store_nutrition_model;
import 'package:revalesuva/model/tools/vegetable_challenge/store_user_challenge_model.dart'
    as store_user_challenge_model;
import 'package:revalesuva/model/workshop_events/create_workshop_event_model.dart';
import 'package:revalesuva/services/api_constant.dart';
import 'package:revalesuva/services/api_services.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/enums.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/notification_helper.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

class Repository {
  static final Repository _instance = Repository._internal();

  factory Repository() {
    return _instance;
  }

  Repository._internal();

  static Repository get instance => _instance;

  Future<APIStatus> loginApi({required String email, required String password}) async {
    var fcmToken = await HelperNotification.getFcmToken();
    Map<String, dynamic> params = {
      APIConstant.instance.kEmail: email.trim(),
      APIConstant.instance.kPassword: password,
      APIConstant.instance.kFcmToken: fcmToken
    };
    APIStatus response = await APIServices.instance.postAPICall(
      param: params,
      url: APIConstant.instance.loginApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> userLogout() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.userLogout,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getCommonMedia() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICall(
      param: params,
      url: APIConstant.instance.commonMedia,
    );
    return response;
  }

  Future<APIStatus> forgotPasswordRequestApi({required String email}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kEmail: email,
    };

    APIStatus response = await APIServices.instance.postAPICall(
      param: params,
      url: APIConstant.instance.forgotPassword,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> verifyApi({required String email, required String otp}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kEmail: email.trim(),
      APIConstant.instance.kOtp: otp.trim(),
    };
    APIStatus response = await APIServices.instance.postAPICall(
      param: params,
      url: APIConstant.instance.verifyOtp,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kEmail: email,
      APIConstant.instance.kOtp: otp,
      APIConstant.instance.kNewPassword: newPassword,
    };
    APIStatus response = await APIServices.instance.postAPICall(
      param: params,
      url: APIConstant.instance.resetPassword,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kOldPassword: oldPassword,
      APIConstant.instance.kNewPassword: newPassword,
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.changePassword,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getUserApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getUserApi,
    );
    return response;
  }

  Future<APIStatus> checkUsernameApi({required String username}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kUsername: username.trim(),
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.checkUsernameApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> updateUserApi({required set_user.SetUserModel userData}) async {
    Map<String, dynamic> params = userData.toJson();
    APIStatus response = await APIServices.instance.postAPICallAuthFileUpload(
      param: params,
      url: APIConstant.instance.updateUserApi,
    );
    return response;
  }

  Future<APIStatus> technicalSupportApi({required String title, required String detail}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kHelpQuestion: title,
      APIConstant.instance.kHelpDetails: detail,
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.technicalSupportApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> technicalSupportListApi({required String perPage, required String page}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.technicalSupportApi,
      isData: true,
    );
    return response;
  }

  Future<APIStatus> technicalSupportDeleteApi({required List<int> id}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kId: id,
    };
    APIStatus response = await APIServices.instance.deleteAPICallAuth(
        param: params, url: APIConstant.instance.technicalSupportApi, paramType: ParamType.raw);
    return response;
  }

  Future<APIStatus> inquirySupportApi({required String title, required String detail}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kUserId: Get.find<UserViewModel>().userData.value.id,
      APIConstant.instance.kHelpQuestion: title,
      APIConstant.instance.kHelpDetails: detail,
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.serviceInquiryApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> serviceInquiryListApi({required String perPage, required String page}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.serviceInquiryApi,
      isData: true,
    );
    return response;
  }

  Future<APIStatus> serviceInquiryDeleteApi({required List<int> id}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kId: id,
    };
    APIStatus response = await APIServices.instance.deleteAPICallAuth(
        param: params, url: APIConstant.instance.serviceInquiryApi, paramType: ParamType.raw);
    return response;
  }

  Future<APIStatus> getCmsApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICall(
      param: params,
      url: APIConstant.instance.getCms,
    );
    return response;
  }

  Future<APIStatus> getMedicalQuestionApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getQuestionApi,
    );
    return response;
  }

  Future<APIStatus> createUserAnswerApi(
      {required create_user_answer_model.CreateUserAnswerModel createAnswerModel}) async {
    Map<String, dynamic> params = createAnswerModel.toJson();
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.userAnswerApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getUserAns() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.userAnswerApi,
    );
    return response;
  }

  Future<APIStatus> getTrainerApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getTrainerApi,
    );
    return response;
  }

  Future<APIStatus> generalMessageListApi({required String perPage, required String page}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.generalMessagesApi,
      isData: true,
    );
    return response;
  }

  Future<APIStatus> generalMessageDeleteApi({required List<int> id}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kMessageId: id,
    };
    APIStatus response = await APIServices.instance.deleteAPICallAuth(
      param: params,
      url: APIConstant.instance.messagesApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> generalMessageReadApi({required List<int> id, required bool status}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kMessageId: id,
      APIConstant.instance.kIsRead: status,
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.markReadStatusApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getPublicExcludeDayApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getPublicExcludeDays,
    );
    return response;
  }

  Future<APIStatus> createUpdateIntuitiveWritingApi(
      {required String description, required int id}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kDescription: description,
      if (id != 0) APIConstant.instance.kIntuitiveWritingId: id,
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.intuitiveApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> deleteIntuitiveWritingApi({required List<int> id}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kId: id,
    };
    APIStatus response = await APIServices.instance.deleteAPICallAuth(
      param: params,
      url: APIConstant.instance.intuitiveApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> intuitiveWritingListApi({required String perPage, required String page}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.intuitiveApi,
      isData: true,
    );
    return response;
  }

  Future<APIStatus> storeOvulationApi({
    required String? date,
    required int? days,
    required String periodType,
  }) async {
    Map<String, dynamic> params = {
      if (date != null) APIConstant.instance.kStartDate: date,
      if (days != null) APIConstant.instance.kDays: days,
      APIConstant.instance.kPeriodType: periodType,
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.storeOvaluationsApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getOvulation() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getOvaluationsApi,
    );
    return response;
  }

  Future<APIStatus> getNutritionalInformationApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getNutritionalInformationApi,
    );
    return response;
  }

  Future<APIStatus> getDailyNutritionApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getDailyNutritionsApi,
    );
    return response;
  }

  Future<APIStatus> getUserDailyNutritionApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.storeDailyNutritionsApi,
    );
    return response;
  }

  Future<APIStatus> getUserDailyNutritionByDateApi() async {
    Map<String, dynamic> params = {
      APIConstant.instance.kCurrentDate: changeDateStringFormat(
        date: DateTime.now().toString(),
        format: DateFormatHelper.ymdFormat,
      ),
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.userDailyNutritionsApiByDate,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> storeUserNutritionApi(
      {required store_nutrition_model.StoreNutritionModel userNutrition}) async {
    Map<String, dynamic> params = userNutrition.toJson();
    APIStatus response = await APIServices.instance.postAPICallAuth(
        param: params, url: APIConstant.instance.storeDailyNutritionsApi, paramType: ParamType.raw);
    return response;
  }

  Future<APIStatus> changeNutritionStatusApi(
      {required ChangeNutritionStatusModel changeNutrition}) async {
    Map<String, dynamic> params = changeNutrition.toJson();
    APIStatus response = await APIServices.instance.postAPICallAuth(
        param: params,
        url: APIConstant.instance.changeDailyNutritionsStatusApi,
        paramType: ParamType.raw);
    return response;
  }

  Future<APIStatus> getUserDailyReportListApi({required String date}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kDate: changeDateStringFormat(
        date: date,
        format: DateFormatHelper.ymdFormat,
      ),
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getUserDailyReportAnsApi,
    );
    return response;
  }

  Future<APIStatus> getDailyReportQuestionApi({required String planId}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPlanId: planId,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getDailyReportQuestionApi,
    );
    return response;
  }

  Future<APIStatus> getDailyReportListApi({required String perPage, required String page}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.userDailyReportListApi,
    );
    return response;
  }

  Future<APIStatus> createDailyReportUserAnswerApi({
    required create_user_answer_model.CreateUserAnswerModel createAnswerModel,
  }) async {
    Map<String, dynamic> params = createAnswerModel.toJson();
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.userDailyReportApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getUserWeeklyReportListApi({required String date}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kDate: changeDateStringFormat(
        date: date,
        format: DateFormatHelper.ymdFormat,
      ),
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getUserWeeklyReportAnsApi,
    );
    return response;
  }

  Future<APIStatus> getWeeklyReportQuestionApi({required String planId}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPlanId: planId,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getWeeklyReportQuestionApi,
    );
    return response;
  }

  Future<APIStatus> getWeeklyReportListApi({required String perPage, required String page}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.userWeeklyReportListApi,
    );
    return response;
  }

  Future<APIStatus> createWeeklyReportUserAnswerApi({
    required create_user_answer_model.CreateUserAnswerModel createAnswerModel,
  }) async {
    Map<String, dynamic> params = createAnswerModel.toJson();
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.userWeeklyReportApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getFastingListListApi({required String perPage, required String page}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.userFastingApi,
    );
    return response;
  }

  Future<APIStatus> createFastingApi({required Map<String, dynamic> param}) async {
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: param,
      url: APIConstant.instance.userFastingApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> updateFastingApi({
    required Map<String, dynamic> params,
  }) async {
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.updateFastingApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> endTimeFastingApi({
    required create_user_answer_model.CreateUserAnswerModel createAnswerModel,
  }) async {
    Map<String, dynamic> params = createAnswerModel.toJson();
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.endtimeFastingApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getProductsApi({
    required String perPage,
    required String page,
    bool? recommended,
    int? categoryId,
    String? search,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
      if (categoryId == -2) APIConstant.instance.kRecommended: true,
      if (categoryId != null && categoryId >= 0) APIConstant.instance.kCategoryId: categoryId,
      if (search != null) APIConstant.instance.kSearch: search,
    };
    APIStatus response = await APIServices.instance
        .getAPICallAuth(param: params, url: APIConstant.instance.getProductsApi, isRaw: true);
    return response;
  }

  Future<APIStatus> getAllProductCategoriesApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getProductCategories,
    );
    return response;
  }

  Future<APIStatus> getRecipesApi({
    required String perPage,
    required String page,
    String? tags,
    int? categoryId,
    String? search,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
      if (tags != null && tags.isNotEmpty) APIConstant.instance.kTags: tags,
      if (categoryId != null && categoryId > 0) APIConstant.instance.kCategoryId: categoryId,
      if (search != null && search.isNotEmpty) APIConstant.instance.kSearch: search,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getRecipesApi,
      isRaw: true,
      isData: true,
    );
    return response;
  }

  Future<APIStatus> getAllRecipeCategoriesApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getRecipesCategories,
    );
    return response;
  }

  Future<APIStatus> getAllFilterTagsApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getRecipesTags,
    );
    return response;
  }

  Future<APIStatus> getFavouriteRecipesApi({
    required String perPage,
    required String page,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getFavouriteRecipes,
      isRaw: true,
    );
    return response;
  }

  Future<APIStatus> addFavouriteRecipesApi({
    required int recipeId,
  }) async {
    Map<String, dynamic> params = {APIConstant.instance.kRecipeId: recipeId};
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.getFavouriteRecipes,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getAllStoreCategoriesApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getStoreCategories,
    );
    return response;
  }

  Future<APIStatus> getStoreProductApi({
    required String perPage,
    required String page,
    String? sortBy,
    int? categoryId,
    String? search,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
      if (sortBy != null && sortBy.isNotEmpty) APIConstant.instance.kSortBy: sortBy,
      if (categoryId != null && categoryId > 0) APIConstant.instance.kCategoryId: categoryId,
      if (search != null && search.isNotEmpty) APIConstant.instance.kSearch: search,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getStoreProduct,
      isRaw: true,
    );
    return response;
  }

  Future<APIStatus> getFavouriteStoreProductApi({
    required String perPage,
    required String page,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.favouriteStoreProduct,
      isRaw: true,
    );
    return response;
  }

  Future<APIStatus> addStoreFavouriteRecipesApi({
    required int storeProductId,
  }) async {
    Map<String, dynamic> params = {APIConstant.instance.kStoreProductId: storeProductId};
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.favouriteStoreProduct,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> createOrderApi({
    required CreateOrderModel order,
  }) async {
    Map<String, dynamic> params = order.toJson();
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.createOrderApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getOrdersApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.createOrderApi,
    );
    return response;
  }

  Future<APIStatus> getArticleApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getArticlesApi,
    );
    return response;
  }

  Future<APIStatus> getMyStarsApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getMyStars,
    );
    return response;
  }

  Future<APIStatus> getWeeklyPortionApi({
    required String perPage,
    required String page,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getWeeklyPortionApi,
    );
    return response;
  }

  Future<APIStatus> getStrengthTrainingApi({
    required String perPage,
    required String page,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getStrengthTrainingApi,
    );
    return response;
  }

  Future<APIStatus> orderCancelApi({required int orderId}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kOrderId: orderId,
    };
    APIStatus response = await APIServices.instance.deleteAPICallAuth(
      param: params,
      url: APIConstant.instance.orderCancelApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getFlexibilityApi({
    required String perPage,
    required String page,
    required String categoryId,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
      APIConstant.instance.kCategoryId: categoryId,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getFlexibilityApi,
      isRaw: true,
    );
    return response;
  }

  Future<APIStatus> getFlexibilityCategoryApi({
    required String perPage,
    required String page,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getFlexibilityCategoriesApi,
      isRaw: true,
    );
    return response;
  }

  Future<APIStatus> getLearningCookApi({
    required String perPage,
    required String page,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getLearningToCook,
      isRaw: true,
    );
    return response;
  }

  Future<APIStatus> getWorkshopEventApi({
    required String perPage,
    required String page,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getWorkshopEvents,
      isRaw: true,
    );
    return response;
  }

  Future<APIStatus> getPastWorkshopEventApi({
    required String perPage,
    required String page,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getMyPastWorkshopEvents,
      isRaw: true,
    );
    return response;
  }

  Future<APIStatus> createWorkshopEventApi({
    required CreateWorkshopEventModel workshop,
  }) async {
    var data = removeNullAndEmptyKeys(workshop.toJson());
    Map<String, dynamic> params = data;
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.workshopEventsApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getFutureWorkshopEventApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getMyFutureWorkshopEvents,
      isRaw: true,
    );
    return response;
  }

  Future<APIStatus> deleteEventApi({required int eventId}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kUserWorkshopEventId: eventId,
    };
    APIStatus response = await APIServices.instance.deleteAPICallAuth(
      param: params,
      url: APIConstant.instance.deleteWorkshopEventsApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getPodcastApi({
    required String perPage,
    required String page,
    required String hostId,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
      APIConstant.instance.kHostId: hostId,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getPodcastApi,
    );
    return response;
  }

  Future<APIStatus> getPodcastHostsApi({
    required String perPage,
    required String page,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getPodcastHosts,
    );
    return response;
  }

  Future<APIStatus> setUserWeight({
    required String date,
    required double weight,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kWeight: weight,
      APIConstant.instance.kDate: date,
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.setWeightApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> setUserCircumference({
    required String date,
    required double chest,
    required double hip,
    required double waist,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kChest: chest,
      APIConstant.instance.kHip: hip,
      APIConstant.instance.kWaist: waist,
      APIConstant.instance.kDate: date,
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.setCircumferencesApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getAllPlansApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getAllPlanApi,
    );
    return response;
  }

  Future<APIStatus> getUserPlanApiByStatus({required String status}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kStatus: status,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getUserPlanApi,
    );
    return response;
  }

  Future<APIStatus> getContentLibrariesByPlan({
    required String planId,
    required String perPage,
    required String page,
    String search = "",
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
      APIConstant.instance.kSearch: search,
      APIConstant.instance.kPlanId: planId,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getContentLibrariesApi,
      isRaw: true,
    );
    return response;
  }

  Future<APIStatus> getMyAchievement() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getAchievementsApi,
      isRaw: true,
    );
    return response;
  }

  createUserLessonByLessonId({required String lessonId}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kLessonId: lessonId,
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.createUserLessonApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> updateLessonWatchStatusApi({
    required String lessonId,
    required String watchStatus,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kLessonId: lessonId,
      APIConstant.instance.kWatchStatus: watchStatus,
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.updateUserLessonStatusApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getLessonByPlanIdApi({
    required String planId,
    required String page,
    required String perPage,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPlanId: planId,
      APIConstant.instance.kPage: page,
      APIConstant.instance.kPerPage: perPage,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getLessonsApi,
      isRaw: true,
    );
    return response;
  }

  Future<APIStatus> getTaskByIdApi({String? lessonId, String? planId}) async {
    Map<String, dynamic> params = {
      if (lessonId != null) APIConstant.instance.kLessonId: lessonId,
      if (planId != null) APIConstant.instance.kPlanId: planId,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getTasksApi,
      isRaw: true,
    );
    return response;
  }

  Future<APIStatus> getUserTaskByIdApi({String? lessonId, String? planId}) async {
    Map<String, dynamic> params = {
      if (lessonId != null) APIConstant.instance.kLessonId: lessonId,
      if (planId != null) APIConstant.instance.kPlanId: planId,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getUserTasksApi,
      isRaw: true,
    );
    return response;
  }

  Future<APIStatus> createUserTask({
    required String lessonId,
    required String planId,
    required String taskId,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kLessonId: lessonId,
      APIConstant.instance.kPlanId: planId,
      APIConstant.instance.kTaskId: taskId
    };
    APIStatus response = await APIServices.instance
        .postAPICallAuth(param: params, url: APIConstant.instance.userTaskApi, paramType: ParamType.raw);
    return response;
  }

  Future<APIStatus> deleteUserTask({
    required String taskId,
  }) async {
    Map<String, dynamic> params = {APIConstant.instance.kTaskId: taskId};
    APIStatus response = await APIServices.instance.deleteAPICallAuth(
      param: params,
      url: APIConstant.instance.userTaskApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getAllProgramApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getAllProgramsApi,
    );
    return response;
  }

  Future<APIStatus> getProgramCompletionReportQuestionApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getPlanSummaryReportsApi,
    );
    return response;
  }

  Future<APIStatus> submitCompletionReportApi({
    required submit_program_answer_model.SubmitProgramAnswerModel submitAnswer,
  }) async {
    Map<String, dynamic> params = submitAnswer.toJson();
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.setUserReportAnswerApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> updatePlanStatusApi({
    required String status,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kStatus: status,
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.updatePlanStatusApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> createUserAdviceApi({
    required String planId,
    required String adviceDetail,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPlanId: planId,
      APIConstant.instance.kAdviceDetail: adviceDetail,
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.createAdviceInquiryApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getUserProgramSummaryReport() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getUserProgramSummaryReportApi,
    );
    return response;
  }

  Future<APIStatus> getUserVegetableChallengeNutritionByDate() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getUserVegetableChallengeApi,
    );
    return response;
  }

  Future<APIStatus> storeUserChallengeNutritionApi({
    required store_user_challenge_model.StoreUserChallengeModel userNutrition,
  }) async {
    Map<String, dynamic> params = userNutrition.toJson();
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.storeUserNutritionChallengeApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> uploadUserAfterBeforePhotosApi({
    required String backPicPath,
    required String sidePicPath,
    required String frontPicPath,
    required String pictureType,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kBackPic: backPicPath,
      APIConstant.instance.kSidePic: sidePicPath,
      APIConstant.instance.kFrontPic: frontPicPath,
      APIConstant.instance.kPictureType: pictureType,
    };
    APIStatus response = await APIServices.instance.postAPICallAuthFileUpload(
      param: params,
      url: APIConstant.instance.afterBeforePhotoApi,
    );
    return response;
  }

  Future<APIStatus> getUserAfterBeforePhotosApi() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getUserPicturesApi,
    );
    return response;
  }

  Future<APIStatus> getUserProgram() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getUserProgramApi,
    );
    return response;
  }

  Future<APIStatus> getProgramSchedule({
    required String date,
    required String programId,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kProgramId: programId,
      APIConstant.instance.kDate: date,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.getUserScheduleApi,
    );
    return response;
  }

  Future<APIStatus> addScheduleApi({
    required String scheduleId,
    required String programId,
    required String date,
    required String status,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kScheduleId: scheduleId,
      APIConstant.instance.kProgramId: programId,
      APIConstant.instance.kDate: date,
      APIConstant.instance.kStatus: status,
    };
    APIStatus response = await APIServices.instance.postAPICallAuth(
      param: params,
      url: APIConstant.instance.scheduledApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> exitScheduleApi({
    required String scheduleId,
    required String programId,
    required String date,
    required String status,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kScheduleId: scheduleId,
      APIConstant.instance.kProgramId: programId,
      APIConstant.instance.kDate: date,
      APIConstant.instance.kStatus: status,
    };
    APIStatus response = await APIServices.instance.deleteAPICallAuth(
      param: params,
      url: APIConstant.instance.scheduledApi,
      paramType: ParamType.raw,
    );
    return response;
  }

  Future<APIStatus> getHomeEventForCalender({
    required String date,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kDate: date,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.homeGetEventApi,
      isRaw: true,
    );
    return response;
  }

  //trainer
  getCustomerByTrainer() async {
    Map<String, dynamic> params = {};
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.trainerCustomers,
      isRaw: true,
    );
    return response;
  }

  getCustomerDailyNutritionData({
    required String date,
    required String customerId,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kDate: date,
      APIConstant.instance.kCustomerId: customerId,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.customerDailyNutritionData,
      isRaw: true,
    );
    return response;
  }

  getCustomerTask({
    required String planId,
    required String customerId,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kPlanId: planId,
      APIConstant.instance.kCustomerId: customerId,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.customerTasksData,
      isRaw: true,
    );
    return response;
  }

  getFastingCalculatorApi({
    required String customerId,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kCustomerId: customerId,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.customerFastingData,
      isRaw: true,
    );
    return response;
  }

  getCustomerDetailByIdApi({
    required String customerId,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kCustomerId: customerId,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.customerDetailById,
      isRaw: true,
    );
    return response;
  }

  Future<APIStatus> getCustomerDailyReportListApi({
    required String customerId,
    required String perPage,
    required String page,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kCustomerId: customerId,
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.customerDailyReportList,
    );
    return response;
  }

  Future<APIStatus> getCustomerDailyReportDataApi({
    required String customerId,
    required String date,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kCustomerId: customerId,
      APIConstant.instance.kDate: changeDateStringFormat(
        date: date,
        format: DateFormatHelper.ymdFormat,
      ),
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.customerDailyReportData,
    );
    return response;
  }

  Future<APIStatus> getCustomerWeeklyReportListApi({
    required String customerId,
    required String perPage,
    required String page,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kCustomerId: customerId,
      APIConstant.instance.kPerPage: perPage,
      APIConstant.instance.kPage: page,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.customerWeeklyReportList,
    );
    return response;
  }

  Future<APIStatus> getCustomerWeeklyReportDataApi({
    required String customerId,
    required String date,
  }) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kCustomerId: customerId,
      APIConstant.instance.kDate: changeDateStringFormat(
        date: date,
        format: DateFormatHelper.ymdFormat,
      ),
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.customerWeeklyReportData,
    );
    return response;
  }

  Future<APIStatus> getVegetableChallengeNutritionByCustomerId({required String customerId}) async {
    Map<String, dynamic> params = {
      APIConstant.instance.kCustomerId: customerId,
    };
    APIStatus response = await APIServices.instance.getAPICallAuth(
      param: params,
      url: APIConstant.instance.customerVegChallenges,
    );
    return response;
  }
}
