import 'package:get/get.dart';
import 'package:revalesuva/views/forgot_password/forgot_password_view.dart';
import 'package:revalesuva/views/forgot_password/reset_password_view.dart';
import 'package:revalesuva/views/forgot_password/verify_otp_view.dart';
import 'package:revalesuva/views/home/home_screen.dart';
import 'package:revalesuva/views/login/login_screen.dart';
import 'package:revalesuva/views/making_contact/contact_us_list_view.dart';
import 'package:revalesuva/views/my_plan/program_summary_report/program_summary_view.dart';
import 'package:revalesuva/views/personal_area/personal_area_screen.dart';
import 'package:revalesuva/views/personal_detail/personal_details_screen.dart';
import 'package:revalesuva/views/personal_detail/video_tutorial_view.dart';
import 'package:revalesuva/views/personal_profile/body_and_medical_info/body_and_medical_information_view.dart';
import 'package:revalesuva/views/personal_profile/general_info/general_Information_view.dart';
import 'package:revalesuva/views/personal_profile/personal_profile_list_view.dart';
import 'package:revalesuva/views/regulations/regulations_list_view.dart';
import 'package:revalesuva/views/splash/splash_screen.dart';
import 'package:revalesuva/views/trainer/blood_report/blood_report_detail_view.dart';
import 'package:revalesuva/views/trainer/blood_report/customer_blood_report_list_view.dart';
import 'package:revalesuva/views/trainer/chat/customer_chat_view.dart';
import 'package:revalesuva/views/trainer/customer_Info/customer_info_view.dart';
import 'package:revalesuva/views/trainer/daily_nutrition/customer_daily_nutrition_view.dart';
import 'package:revalesuva/views/trainer/daily_report/customer_daily_report_detail_view.dart';
import 'package:revalesuva/views/trainer/daily_report/customer_daily_report_list_view.dart';
import 'package:revalesuva/views/trainer/fasting/customer_fasting_history_list.dart';
import 'package:revalesuva/views/trainer/home/trainer_home_view.dart';
import 'package:revalesuva/views/trainer/profile/profile_view.dart';
import 'package:revalesuva/views/trainer/report/customer_graph_and_report_view.dart';
import 'package:revalesuva/views/trainer/tasks/customer_task_detail.dart';
import 'package:revalesuva/views/trainer/tasks/customer_task_list_view.dart';
import 'package:revalesuva/views/trainer/vegetable_challenge/customer_vegetable_challenge_view.dart';
import 'package:revalesuva/views/trainer/weekly_report/customer_weekly_report_detail_view.dart';
import 'package:revalesuva/views/trainer/weekly_report/customer_weekly_report_list_view.dart';

class AuthMiddleware extends GetMiddleware {
  // @override
  // RouteSettings? redirect(String? route) {
  //   return Get.find<UserDetailsConstants>().userId.value.isNotEmpty ? null : const RouteSettings(name: '/auth/login');
  // }
}

getPageRoute() {
  return [
    GetPage(
      name: RoutesName.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: RoutesName.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: RoutesName.personalDetail,
      page: () => PersonalDetailsScreen(),
    ),
    GetPage(
      name: RoutesName.videoTutorial,
      page: () => const VideoTutorialView(),
    ),
    GetPage(
      name: RoutesName.home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: RoutesName.personalArea,
      page: () => const PersonalAreaScreen(),
    ),
    GetPage(
      name: RoutesName.personalArea,
      page: () => const RegulationsListView(),
    ),
    GetPage(
      name: RoutesName.personalProfileList,
      page: () => PersonalProfileListView(),
    ),
    GetPage(
      name: RoutesName.generalInfo,
      page: () => GeneralInformationView(),
    ),
    GetPage(
      name: RoutesName.bodyAndMedicalInfo,
      page: () => BodyAndMedicalInformationView(),
    ),
    GetPage(
      name: RoutesName.contactUsListView,
      page: () => ContactUsListView(),
    ),
    GetPage(
      name: RoutesName.inquiryServiceView,
      page: () => const InquiryServiceView(),
    ),
    GetPage(
      name: RoutesName.technicalSupportView,
      page: () => const TechnicalSupportView(),
    ),
    GetPage(
      name: RoutesName.regulationsListView,
      page: () => const RegulationsListView(),
    ),
    GetPage(
      name: RoutesName.forgotPasswordView,
      page: () => ForgotPasswordView(),
    ),
    GetPage(
      name: RoutesName.verifyOtpView,
      page: () => VerifyOtpView(),
    ),
    GetPage(
      name: RoutesName.resetPasswordView,
      page: () => ResetPasswordView(),
    ),
    GetPage(
      name: RoutesName.initRoot,
      page: () => const ProgramSummaryView(),
    ),
    GetPage(
      name: RoutesName.trainerHome,
      page: () => const TrainerHomeView(),
    ),
    GetPage(
      name: RoutesName.trainerProfile,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: RoutesName.trainerCustomerInfo,
      page: () {
        var data = Get.arguments;
        return CustomerInfoView(
          data: data,
        );
      },
    ),
    GetPage(
      name: RoutesName.customerDailyReportView,
      page: () {
        var data = Get.arguments;
        return CustomerDailyReportListView(
          userData: data,
        );
      },
    ),
    GetPage(
      name: RoutesName.customerDailyReportDetailView,
      page: () {
        var data = Get.arguments[0];
        var date = Get.arguments[1];
        var day = Get.arguments[2];
        return CustomerDailyReportDetailView(
          userData: data,
          date: date,
          day: day,
        );
      },
    ),
    GetPage(
      name: RoutesName.customerDailyNutritionView,
      page: () {
        var data = Get.arguments;
        return CustomerDailyNutritionView(
          userData: data,
        );
      },
    ),
    GetPage(
      name: RoutesName.customerTaskListView,
      page: () {
        var data = Get.arguments;
        return CustomerTaskListView(
          userData: data,
        );
      },
    ),
    GetPage(
      name: RoutesName.customerTaskDetail,
      page: () {
        var data = Get.arguments[0];
        var status = Get.arguments[1];
        return CustomerTaskDetail(
          taskData: data,
          isCompleted: status,
        );
      },
    ),
    GetPage(
      name: RoutesName.customerFastingHistoryList,
      page: () {
        var data = Get.arguments;
        return CustomerFastingHistoryList(
          data: data,
        );
      },
    ),
    GetPage(
      name: RoutesName.customerGraphAndReport,
      page: () {
        var data = Get.arguments;
        return CustomerGraphAndReportView(
          data: data,
        );
      },
    ),
    GetPage(
      name: RoutesName.customerChatView,
      page: () {
        var data = Get.arguments;
        return CustomerChatView(
          data: data,
        );
      },
    ),
    GetPage(
      name: RoutesName.customerWeeklyReportListView,
      page: () {
        var data = Get.arguments;
        return CustomerWeeklyReportListView(
          userData: data,
        );
      },
    ),
    GetPage(
      name: RoutesName.customerWeeklyReportDetailView,
      page: () {
        var data = Get.arguments[0];
        var date = Get.arguments[1];
        return CustomerWeeklyReportDetailView(
          userData: data,
          date: date,
        );
      },
    ),
    GetPage(
      name: RoutesName.customerBloodReportListView,
      page: () {
        var data = Get.arguments;
        return CustomerBloodReportListView(
          data: data,
        );
      },
    ),
    GetPage(
      name: RoutesName.customerWeeklyReportDetailView,
      page: () {
        return const BloodReportDetailView();
      },
    ),
    GetPage(
      name: RoutesName.customerVegetableChallengeView,
      page: () {
        var data = Get.arguments;
        return CustomerVegetableChallengeView(
          userData: data,
        );
      },
    ),
  ];
}

class RoutesName {
  static const String splash = '/';
  static const String login = '/login';
  static const String personalDetail = '/personalDetail';
  static const String videoTutorial = '/videoTutorial';
  static const String home = '/home';
  static const String personalArea = '/personalArea';
  static const String regulationsList = '/regulationsList';
  static const String personalProfileList = '/personalProfileList';
  static const String generalInfo = '/generalInfo';
  static const String bodyAndMedicalInfo = '/bodyAndMedicalInfo';
  static const String contactUsListView = '/contactUsListView';
  static const String inquiryServiceView = '/inquiryServiceView';
  static const String technicalSupportView = '/technicalSupportView';
  static const String regulationsListView = '/regulationsListView';
  static const String showCmsView = '/showCmsView';
  static const String forgotPasswordView = '/forgotPasswordView';
  static const String verifyOtpView = '/verifyOtpView';
  static const String resetPasswordView = '/ResetPasswordView';
  static const String initRoot = '/initroot';

  static const String trainerHome = '/trainer/home';
  static const String trainerProfile = '/trainer/profile';
  static const String trainerCustomerInfo = '/trainer/customerInfo';
  static const String customerDailyReportView = '/trainer/customerDailyReportView';
  static const String customerDailyReportDetailView = '/trainer/CustomerDailyReportDetailView';
  static const String customerDailyNutritionView = '/trainer/customerDailyNutritionView';
  static const String customerTaskListView = '/trainer/customerTaskListView';
  static const String customerTaskDetail = '/trainer/customerTaskDetail';
  static const String customerFastingHistoryList = '/trainer/customerFastingHistoryList';
  static const String customerGraphAndReport = '/trainer/customerGraphAndReport';
  static const String customerChatView = '/trainer/customerChatView';
  static const String customerWeeklyReportListView = '/trainer/customerWeeklyReportListView';
  static const String customerWeeklyReportDetailView = '/trainer/customerWeeklyReportDetailView';
  static const String customerBloodReportListView = '/trainer/customerBloodReportListView';
  static const String customerBloodReportDetailView = '/trainer/customerBloodReportDetailView';
  static const String customerVegetableChallengeView = '/trainer/customerVegetableChallengeView';
}
