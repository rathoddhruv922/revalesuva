import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/empty_model/empty_model.dart';
import 'package:revalesuva/model/home/event_model.dart' as event_model;
import 'package:revalesuva/model/my_plan/plans/all_plan_model.dart' as all_plan_model;
import 'package:revalesuva/model/my_plan/plans/user_plan_model.dart' as user_plan_model;
import 'package:revalesuva/model/my_plan/program/program_schedule_model.dart' as program_schedule_model;
import 'package:revalesuva/model/my_plan/program/user_program_model.dart' as user_program_model;
import 'package:revalesuva/model/my_plan/tasks/task_model.dart' as task_model;
import 'package:revalesuva/model/my_plan/tasks/user_task_model.dart' as user_task_model;
import 'package:revalesuva/model/product_and_recipes/shopping_model.dart';
import 'package:revalesuva/model/store/store_model.dart' as store_model;
import 'package:revalesuva/model/tools/ovulation_calculator/get_ovulation_model.dart'
as get_ovulation_model;
import 'package:revalesuva/repository/repository.dart';
import 'package:revalesuva/services/api_status.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/local_cart_helper.dart';
import 'package:revalesuva/utils/local_shopping_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/home/widget/bottom_bar_item_widget.dart';
import 'package:revalesuva/view_models/theme_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/hadas_strengthening/hadas_strengthening_view.dart';
import 'package:revalesuva/views/home/home_view.dart';
import 'package:revalesuva/views/my_plan/my_plan_list_view.dart';
import 'package:revalesuva/views/my_stars/my_stars_view.dart';
import 'package:revalesuva/views/product_and_recipes/product_recipes_leading_view.dart';
import 'package:revalesuva/views/store/store_product_list_view.dart';

class HomeViewModel extends GetxController {
  final PersistentTabController controller = PersistentTabController();
  var isNavigationBarHide = false.obs;
  var isHomeRefresh = false.obs;
  var isIceDeepScreen = false.obs;
  var shoppingListItemCount = 0.obs;
  var cartListItemCount = 0.obs;
  var listActiveProgram = <user_program_model.Datum>[].obs;
  var listEvents = <event_model.Datum>[].obs;
  var calenderLoader = false.obs;
  var selectedDateForCalender = DateTime
      .now()
      .obs;
  var programData = program_schedule_model
      .Datum()
      .obs;
  var listTask = <task_model.Datum>[].obs;
  var listUserTask = <user_task_model.Datum>[].obs;
  var userTaskTotal = 0.obs;
  var taskTotal = 0.obs;
  var userPlanDetail = user_plan_model
      .Datum()
      .obs;
  var menstruationDays = 0.obs;
  var ovulationDays = 0.obs;
  var expectedOvulation = 0.obs;
  var listOvulation = <get_ovulation_model.Datum>[].obs;
  var startingDate = DateTime
      .now()
      .obs;
  var endingDate = DateTime
      .now()
      .obs;
  var numberOfCycleDays = 0.obs;
  var totalNumberOfCycleDays = 0.obs;
  var percentage = 0.0.obs;

  fetchOvulationDate() async {
    final response = await Repository.instance.getOvulation();
    if (response is Success) {
      final result = get_ovulation_model.getOvulationModelFromJson(response.response.toString());
      listOvulation.assignAll(result.data ?? []);
      if (listOvulation.isNotEmpty) {
        ovulationDays.value = result.data
            ?.where(
              (element) =>
          element.type == "ovulation" && (element.date?.isAfter(DateTime.now()) ?? false),
        )
            .length ??
            0;
        DateTime? firstOvulationDate =
            result.data
                ?.firstWhereOrNull((element) => element.type == "ovulation")
                ?.date;

        if (firstOvulationDate != null) {
          expectedOvulation.value = firstOvulationDate
              .difference(DateTime.now())
              .inDays;
        }

        menstruationDays.value = getLastMenstruationInfo(listOvulation);
        totalNumberOfCycleDays.value = listOvulation.length;
        int cycleDaysPassed =
            listOvulation
                .where((element) => element.date?.isBefore(DateTime.now()) ?? false)
                .length;

        numberOfCycleDays.value = cycleDaysPassed;
        percentage.value = (numberOfCycleDays.value / totalNumberOfCycleDays.value);
      }
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
  }

  int getLastMenstruationInfo(List<get_ovulation_model.Datum> menstruationDates) {
    final today = DateTime.now();

    final pastDates = menstruationDates.firstWhereOrNull((item) =>
    item.type == "menstrual" && (item.date?.isBefore(today) ?? false));

    if (pastDates != null && pastDates.date != null) {
      final gap = today
          .difference(pastDates.date!)
          .inDays;
      return gap;
    } else {
      return 0;
    }
  }

  updateCalenderDate({required DateTime date}) async {
    selectedDateForCalender.value = date;
    calenderLoader.value = true;
    await getEventsForCalender();
    await getUserProgramForCalender();
    calenderLoader.value = false;
  }

  updateIceDeepTheme({required bool active}) {
    isIceDeepScreen.value = active;
    Get.find<ThemeViewModel>().updateTheme(
      isLight: true,
      isIceBlue: isIceDeepScreen.value,
    );
  }

  final List<GlobalKey<NavigatorState>> persistentNavKey = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];
  var currentActiveTab = 0.obs;

  var totalAmountToBePaid = 0.0.obs;
  var subTotal = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getShoppingListItemCount();
    getCartListItemCount();
  }

  List<PersistentTabConfig> tabs() =>
      [
        PersistentTabConfig(
          screen: const HomeView(),
          item: getBottomBarItem(
              title: StringConstants.homePage,
              activeImage: Assets.iconsIcHomeSelected,
              inActiveImage: Assets.iconsIcHomeUnselected),
          navigatorConfig: NavigatorConfig(
            navigatorKey: persistentNavKey[0],
          ),
        ),
        PersistentTabConfig(
          screen: const MyPlanListView(
            isShowBack: false,
          ),
          navigatorConfig: NavigatorConfig(
            navigatorKey: persistentNavKey[1],
          ),
          item: getBottomBarItem(
              title: StringConstants.myPlan,
              activeImage: Assets.iconsIcMyplanSelected,
              inActiveImage: Assets.iconsIcMyplanUnselected),
        ),
        PersistentTabConfig(
          screen: const ProductRecipesLeadingView(),
          navigatorConfig: NavigatorConfig(
            navigatorKey: persistentNavKey[2],
          ),
          item: getBottomBarItem(
              title: StringConstants.productsRecipes,
              activeImage: Assets.iconsIcProductsSelected,
              inActiveImage: Assets.iconsIcProductUnselected),
        ),
        PersistentTabConfig(
          navigatorConfig: NavigatorConfig(
            navigatorKey: persistentNavKey[3],
          ),
          screen: const HadasStrengtheningView(),
          item: getBottomBarItem(
              title: StringConstants.hizukitMehadas,
              activeImage: Assets.iconsIcMehadasSelected,
              inActiveImage: Assets.iconsIcMehadasUnselected),
        ),
        PersistentTabConfig(
          navigatorConfig: NavigatorConfig(
            navigatorKey: persistentNavKey[4],
          ),
          screen: const MyStarsView(
            isShowBack: false,
          ),
          item: getBottomBarItem(
              title: StringConstants.myStars,
              activeImage: Assets.iconsIcMyStarsSelected,
              inActiveImage: Assets.iconsIcMyStarsUnselected),
        ),
        PersistentTabConfig(
          navigatorConfig: NavigatorConfig(
            navigatorKey: persistentNavKey[5],
          ),
          screen: const StoreProductListView(),
          item: getBottomBarItem(
              title: StringConstants.store,
              activeImage: Assets.iconsIcStoreSelected,
              inActiveImage: Assets.iconsIcStoreUnselected),
        ),
      ];

  List<ShoppingModel> getShoppingListItemCount() {
    var data = LocalShoppingHelper.instance.getAllProducts();
    // shoppingListItemCount.value = 0;
    // for (var item in data) {
    //   shoppingListItemCount.value = shoppingListItemCount.value + (item.qty ?? 0);
    // }
    shoppingListItemCount.value = data.length;
    return data;
  }

  List<store_model.Datum> getCartListItemCount() {
    var data = LocalCartHelper.instance.getAllProducts();
    // cartListItemCount.value = data.length;
    cartListItemCount.value = 0;
    totalAmountToBePaid.value = 0.0;
    subTotal.value = 0.0;
    for (var item in data) {
      cartListItemCount.value = cartListItemCount.value + (item.qty ?? 1);
      var total =
          totalAmountToBePaid.value + (double.tryParse(item.price ?? "") ?? 0) * (item.qty ?? 0.0);
      totalAmountToBePaid.value = total;
      subTotal.value = total;
    }
    return data;
  }

  Future<List<all_plan_model.Datum>> getAllPlanList() async {
    var response = await Repository.instance.getAllPlansApi();
    if (response is Success) {
      var result = all_plan_model.allPlanModelFromJson(response.response.toString());
      return result.data ?? [];
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
    return [];
  }

  Future<List<all_plan_model.Datum>> getAllProgram() async {
    var response = await Repository.instance.getAllProgramApi();
    if (response is Success) {
      var result = all_plan_model.allPlanModelFromJson(response.response.toString());
      return result.data ?? [];
    } else if (response is Failure) {
      debugPrint(response.errorResponse.toString() ?? "");
    }
    return [];
  }

  Future<List<user_program_model.Datum>> getActiveProgramList() async {
    var response = await Repository.instance.getUserProgram();
    if (response is Success) {
      var result = user_program_model.userProgramModelFromJson(response.response.toString());
      return result.data ?? [];
    } else if (response is Failure) {}
    return [];
  }

  getEventsForCalender() async {
    var response = await Repository.instance.getHomeEventForCalender(
      date: changeDateStringFormat(
        date: selectedDateForCalender.toString(),
        format: DateFormatHelper.ymdFormat,
      ),
    );
    if (response is Success) {
      var result = event_model.eventModelFromJson(response.response.toString());
      listEvents.assignAll(result.data ?? []);
    } else if (response is Failure) {
      listEvents.clear();
    }
  }

  getUserProgramForCalender() async {
    var response = await Repository.instance.getProgramSchedule(
      programId: Get
          .find<UserViewModel>()
          .userData
          .value
          .programs
          ?.first
          .id
          .toString() ?? "",
      date: changeDateStringFormat(
        date: selectedDateForCalender.toString(),
        format: DateFormatHelper.ymdFormat,
      ),
    );
    if (response is Success) {
      var result = program_schedule_model.programScheduleModelFromJson(response.response.toString());
      programData.value = result.data?.firstWhereOrNull(
            (element) => element.user?.status != null,
      ) ??
          program_schedule_model.Datum();
    } else if (response is Failure) {
      programData.value = program_schedule_model.Datum();
    }
  }

  getActivePlan() async {
    var response = await Repository.instance.getUserPlanApiByStatus(
      status: "active",
    );
    if (response is Success) {
      var result = user_plan_model.userPlanModelFromJson(response.response.toString());
      userPlanDetail.value = result.data?.first ?? user_plan_model.Datum();
    } else if (response is Failure) {
      userPlanDetail.value = user_plan_model.Datum();
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
  }

  getTaskByPlanId({String? planId}) async {
    var response = await Repository.instance.getTaskByIdApi(
      planId: planId,
    );
    if (response is Success) {
      var result = task_model.taskModelFromJson(response.response.toString());
      listTask.assignAll(result.data ?? []);
    } else if (response is Failure) {
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
    taskTotal.value = listTask.length;
  }

  getUserTaskByPlanId({required String planId}) async {
    var response = await Repository.instance.getUserTaskByIdApi(
      planId: planId,
    );
    if (response is Success) {
      var result = user_task_model.userTaskModelFromJson(response.response.toString());
      listUserTask.assignAll(result.data ?? []);
    } else if (response is Failure) {
      listUserTask.clear();
      if (response.code != 404) {
        showToast(msg: "${response.errorResponse ?? ""}");
      }
    }
    userTaskTotal.value = listUserTask.length;
    listUserTask.refresh();
  }

  Future<bool> createUserTask({
    required String lessonId,
    required String planId,
    required String taskId,
  }) async {
    showLoader();
    var response = await Repository.instance.createUserTask(
      lessonId: lessonId,
      planId: planId,
      taskId: taskId,
    );
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      return true;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }

    return false;
  }

  Future<bool> deleteUserTask({required String taskId, required String planId}) async {
    showLoader();
    var response = await Repository.instance.deleteUserTask(
      taskId: taskId,
    );
    hideLoader();
    if (response is Success) {
      var result = emptyModelFromJson(response.response.toString());
      return true;
    } else if (response is Failure) {
      showToast(msg: "${response.errorResponse ?? ""}");
    }
    return false;
  }
}
