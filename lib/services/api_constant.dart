import 'dart:core';

import 'package:revalesuva/utils/enums.dart';

class APIConstant {
  static final APIConstant _instance = APIConstant._internal();

  factory APIConstant() {
    return _instance;
  }

  APIConstant._internal();

  static APIConstant get instance => _instance;
  static Environment environment = Environment.main;
  final String appVersion = "1.0";

  static String get domain {
    switch (environment) {
      case Environment.staging:
        return '';
      case Environment.uat:
        return '';
      case Environment.main:
        return '';
    }
  }

  // TODO: API PATH SETUP
  static String apiPath = "/api/v1/";
  static String baseUrl = "$domain$apiPath";

  // TODO: API END-POINTS
  final String loginApi = "${baseUrl}user/login";
  final String getUserApi = "${baseUrl}user";
  final String userLogout = "${baseUrl}logout";
  final String commonMedia = "${baseUrl}common-media";
  final String forgotPassword = "${baseUrl}forgot-password";
  final String verifyOtp = "${baseUrl}verify-otp";
  final String resetPassword = "${baseUrl}reset-password";
  final String changePassword = "${baseUrl}change-password";
  final String updateUserApi = "${baseUrl}user/update";
  final String checkUsernameApi = "${baseUrl}check-username";
  final String logoutApi = "${baseUrl}user/logout";
  final String technicalSupportApi = "${baseUrl}technical-support";
  final String getCms = "${baseUrl}get-cms";
  final String serviceInquiryApi = "${baseUrl}service-inquiry";
  final String getQuestionApi = "${baseUrl}question";
  final String userAnswerApi = "${baseUrl}user-answer";
  final String getTrainerApi = "${baseUrl}trainer";
  final String generalMessagesApi = "${baseUrl}general-messages";
  final String messagesApi = "${baseUrl}messages";
  final String markReadStatusApi = "${baseUrl}mark-read-status";
  final String getPublicExcludeDays = "${baseUrl}get-public-exclude-days";
  final String intuitiveApi = "${baseUrl}intuitive-writing";
  final String storeOvaluationsApi = "${baseUrl}store-ovaluations";
  final String getOvaluationsApi = "${baseUrl}get-ovaluations";
  final String getNutritionalInformationApi = "${baseUrl}nutritional-information";
  final String getDailyNutritionsApi = "${baseUrl}get-daily-nutritions";
  final String storeDailyNutritionsApi = "${baseUrl}user/daily-nutrition";
  final String userDailyNutritionsApiByDate = "${baseUrl}user/daily-nutrition-by-date";
  final String changeDailyNutritionsStatusApi = "${baseUrl}user/change-status-daily-nutrition";
  final String getDailyReportQuestionApi = "${baseUrl}daily-report/question";
  final String getUserDailyReportAnsApi = "${baseUrl}user/daily-report";
  final String userDailyReportApi = "${baseUrl}user/daily-report";
  final String userDailyReportListApi = "${baseUrl}user/daily-report-list";
  final String getWeeklyReportQuestionApi = "${baseUrl}weekly-report/question";
  final String getUserWeeklyReportAnsApi = "${baseUrl}user/weekly-report";
  final String userWeeklyReportApi = "${baseUrl}user/weekly-report";
  final String userWeeklyReportListApi = "${baseUrl}user/weekly-report-list";
  final String userFastingApi = "${baseUrl}user/fasting-calculator";
  final String updateFastingApi = "${baseUrl}user/update-fasting-calculation";
  final String endtimeFastingApi = "${baseUrl}user/endtime-update";
  final String getProductsApi = "${baseUrl}products";
  final String getRecipesApi = "${baseUrl}recipes";
  final String getProductCategories = "${baseUrl}product-categories";
  final String getRecipesCategories = "${baseUrl}recipes-categories";
  final String getRecipesTags = "${baseUrl}recipes/tags";
  final String getFavouriteRecipes = "${baseUrl}recipes/favourite";
  final String getStoreCategories = "${baseUrl}store-categories";
  final String getStoreProduct = "${baseUrl}store-product";
  final String favouriteStoreProduct = "${baseUrl}store-product/favourite";
  final String createOrderApi = "${baseUrl}user/order";
  final String getArticlesApi = "${baseUrl}get-articles";
  final String orderCancelApi = "${baseUrl}user/cancel-order";
  final String getMyStars = "${baseUrl}my-stars";
  final String getWeeklyPortionApi = "${baseUrl}weekly-portion";
  final String getStrengthTrainingApi = "${baseUrl}strength-training";
  final String getFlexibilityCategoriesApi = "${baseUrl}flexibility-categories";
  final String getFlexibilityApi = "${baseUrl}flexibility";
  final String getLearningToCook = "${baseUrl}learning-to-cook";
  final String getWorkshopEvents = "${baseUrl}get-workshop-events";
  final String getMyPastWorkshopEvents = "${baseUrl}user/my-past-events";
  final String workshopEventsApi = "${baseUrl}user/workshop-events";
  final String deleteWorkshopEventsApi = "${baseUrl}user/workshop-event";
  final String getMyFutureWorkshopEvents = "${baseUrl}user/my-future-events";
  final String getPodcastApi = "${baseUrl}podcast";
  final String getPodcastHosts = "${baseUrl}podcasthosts";
  final String setWeightApi = "${baseUrl}user/weight";
  final String setCircumferencesApi = "${baseUrl}user/circumferences";
  final String getAllPlanApi = "${baseUrl}plans";
  final String getAllProgramsApi = "${baseUrl}programs";
  final String getUserPlanApi = "${baseUrl}user/plans";
  final String getContentLibrariesApi = "${baseUrl}content-libraries";
  final String getAchievementsApi = "${baseUrl}get-achievements";
  final String getLessonsApi = "${baseUrl}lessons";
  final String getTasksApi = "${baseUrl}tasks";
  final String getUserTasksApi = "${baseUrl}task/plans";
  final String createUserLessonApi = "${baseUrl}user/lessons/create";
  final String updateUserLessonStatusApi = "${baseUrl}user/lessons/update-status";
  final String userTaskApi = "${baseUrl}user/tasks";
  final String getPlanSummaryReportsApi = "${baseUrl}get-plan-summary-reports";
  final String setUserReportAnswerApi = "${baseUrl}user/plan-summary-report";
  final String updatePlanStatusApi = "${baseUrl}user/update-plan-status";
  final String createAdviceInquiryApi = "${baseUrl}user/advice-inquiry";
  final String getUserProgramSummaryReportApi = "${baseUrl}user/plan-summary-reports";
  final String getUserProgramApi = "${baseUrl}user/programs";
  final String getUserScheduleApi = "${baseUrl}user/programs-schedule";
  final String scheduledApi = "${baseUrl}user/schedule";
  final String exitRegistrationApi = "${baseUrl}exit-registration";
  final String afterBeforePhotoApi = "${baseUrl}user/update-pictures";
  final String userWaitingListApi = "${baseUrl}user/waiting-list";
  final String getUserPicturesApi = "${baseUrl}user/pictures";
  final String getUserVegetableChallengeApi = "${baseUrl}nutrition/by-date";
  final String storeUserNutritionChallengeApi = "${baseUrl}user/nutrition-challenge";
  final String homeGetEventApi = "${baseUrl}home/workshop-and-events";
  final String customerVegChallenges = "${baseUrl}customer-veg-challenges";


  //trainer
  final String trainerCustomers = "${baseUrl}trainer/customers";
  final String customerDailyNutritionData = "${baseUrl}customer-daily-nutrition-data";
  final String customerTasksData = "${baseUrl}customer-tasks-data";
  final String customerFastingData = "${baseUrl}customer-fasting-data";
  final String customerDetailById = "${baseUrl}customer-detail";
  final String customerDailyReportList = "${baseUrl}customer-daily-report-list";
  final String customerDailyReportData = "${baseUrl}customer-daily-report-data";

  final String customerWeeklyReportList = "${baseUrl}customer-weekly-report-list";
  final String customerWeeklyReportData = "${baseUrl}customer-weekly-report-data";

  // TODO: API PARAM KEYS
  //Login
  final String kEmail = "email";
  final String kPassword = "password";
  final String kUsername = "user_name";
  final String kFcmToken = "fcm_token";

  //support and service
  final String kUserId = "user_id";
  final String kHelpQuestion = "help_question";
  final String kHelpDetails = "help_details";
  final String kPerPage = "per_page";
  final String kId = "id";
  final String kMessageId = "message_id";
  final String kIsRead = "is_read";
  final String kPage = "page";
  final String kDescription = "description";
  final String kIntuitiveWritingId = "intuitive_writing_id";

  //otp
  final String kOtp = "otp";
  final String kNewPassword = "new_password";

  //change password
  final String kOldPassword = "old_password";

  //Ovulation calculator
  final String kType = "type";
  final String kDates = "dates";
  final String kStartDate = "start_date";
  final String kDays = "days";
  final String kPeriodType = "period_type";

  //daily report
  final String kDate = "date";

  //fasting
  final String kStartTime = "start_time";
  final String kEndTime = "end_time";
  final String kFastingId = "fasting_id";
  final String kNoOfFastingHours = "no_of_fasting_hours";

  //product
  final String kRecommended = "recommended";
  final String kCategoryId = "category_id";
  final String kSearch = "search";

  //recipes
  final String kTags = "tags";
  final String kRecipeId = "recipe_id";

  //store product
  final String kStoreProductId = "store_product_id";
  final String kSortBy = "sort_by";

  //Order
  final String kOrderId = "order_id";

  //workshop Event
  final String kUserWorkshopEventId = "user_workshop_event_id";

  //Podcast
  final String kHostId = "host_id";

  //daily nutrition
  final String kCurrentDate = "current_date";

  //weighing and measuring
  final String kWeight = "weight";
  final String kChest = "chest";
  final String kHip = "hip";
  final String kWaist = "waist";

  //MyPlan
  final String kStatus = "status";
  final String kPlanId = "plan_id";
  final String kTaskId = "task_id";
  final String kWatchStatus = "watch_status";
  final String kLessonId = "lesson_id";
  final String kAdviceDetail = "advice_detail";

  final String kBackPic = "back_pic";
  final String kSidePic = "side_pic";
  final String kFrontPic = "front_pic";
  final String kPictureType = "picture_type";

  //My Program
  final String kScheduleId = "schedule_id";
  final String kProgramId = "program_id";

  //trainer
  final String kCustomerId = "customer_id";
}
