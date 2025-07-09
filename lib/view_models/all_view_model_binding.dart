import 'package:get/get.dart';
import 'package:revalesuva/view_models/hadas_strengthening/weekly_torah_portion_view_model.dart';
import 'package:revalesuva/view_models/my_plan/lessons_view_model.dart';
import 'package:revalesuva/view_models/my_plan/program_view_model.dart';
import 'package:revalesuva/view_models/order/order_view_model.dart';
import 'package:revalesuva/view_models/personal_detail/common_media_view_model.dart';
import 'package:revalesuva/view_models/personal_detail/que_and_ans_view_model.dart';
import 'package:revalesuva/view_models/product_recipes/recipe_favorites_view_model.dart';
import 'package:revalesuva/view_models/store/store_favorites_view_model.dart';
import 'package:revalesuva/view_models/tools/daily_nutrition_view_model.dart';
import 'package:revalesuva/view_models/tools/daily_reports_view_model.dart';
import 'package:revalesuva/view_models/tools/fasting_calculator_view_model.dart';
import 'package:revalesuva/view_models/tools/weekly_report_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/view_models/weighing_and_measuring/weighing_and_measuring_view_model.dart';

class AllViewModelBinding implements Bindings {
  @override
  void dependencies() {
//    Get.put(NetworkController(), permanent: true);
    Get.put(UserViewModel(), permanent: true);
    Get.put(CommonMediaViewModel(), permanent: true);
    Get.put(QueAndAnsViewModel(), permanent: true);
    Get.put(RecipeFavoritesViewModel(), permanent: true);
    Get.put(StoreFavoritesViewModel(), permanent: true);
    Get.put(OrderViewModel(), permanent: true);
    Get.put(WeighingAndMeasuringViewModel(), permanent: true);
    Get.put(FastingCalculatorViewModel(), permanent: true);
    Get.put(DailyNutritionViewModel(), permanent: true);
    Get.put(WeeklyTorahPortionViewModel(), permanent: true);
    Get.put(ProgramViewModel(), permanent: true);
    Get.put(DailyReportsViewModel(), permanent: true);
    Get.put(WeeklyReportViewModel(), permanent: true);
    Get.put(LessonsViewModel(), permanent: true);
  }
}
