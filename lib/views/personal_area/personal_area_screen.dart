import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/list_item.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/view_models/tools/daily_nutrition_view_model.dart';
import 'package:revalesuva/view_models/tools/daily_reports_view_model.dart';
import 'package:revalesuva/view_models/tools/weekly_report_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/common_widget/profile_picture.dart';
import 'package:revalesuva/views/general_message/general_message_list_view.dart';
import 'package:revalesuva/views/making_contact/contact_us_list_view.dart';
import 'package:revalesuva/views/my_plan/my_plan_list_view.dart';
import 'package:revalesuva/views/my_stars/my_stars_view.dart';
import 'package:revalesuva/views/order/order_list_view.dart';
import 'package:revalesuva/views/personal_profile/personal_profile_list_view.dart';
import 'package:revalesuva/views/product_and_recipes/recipes/recipes_loved_list_view.dart';
import 'package:revalesuva/views/product_and_recipes/shopping_list/my_shopping_list_view.dart';
import 'package:revalesuva/views/store/my_cart_list_view.dart';
import 'package:revalesuva/views/store/store_product_loved_list_view.dart';
import 'package:revalesuva/views/tools/tools_list_view.dart';
import 'package:revalesuva/views/weighing_and_measuring/weighing_and_measuring_view.dart';
import 'package:revalesuva/views/workshop_events/my_workshop_event_list_view.dart';

class PersonalAreaScreen extends StatelessWidget {
  const PersonalAreaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const PersonalAreaScreen());
      },
      canPop: true,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await Get.find<UserViewModel>().onInit();
            return;
          },
          child: ListView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            children: [
              const Gap(10),
              const ProfilePicture(),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: TextBodySmall(
                  text: StringConstants.imageEditing,
                  color: AppColors.textPrimary,
                ),
              ),
              const Gap(20),
              TextBodyMedium(
                text: StringConstants.general,
                color: AppColors.textSecondary,
                letterSpacing: 3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListItem(
                  title: StringConstants.personalProfile,
                  onTab: () {
                    NavigationHelper.pushScreenWithNavBar(
                      widget: PersonalProfileListView(),
                      context: context,
                    );
                  },
                  icon: Assets.iconsIcPerson,
                ),
              ),
              Obx(
                () => Get.find<UserViewModel>().isLessonSummary.isTrue
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ListItem(
                          title: StringConstants.myPlan,
                          onTab: () {
                            NavigationHelper.pushScreenWithNavBar(
                              widget: const MyPlanListView(),
                              context: context,
                            );
                          },
                          icon: Assets.iconsIcMyPlan,
                        ),
                      )
                    : const SizedBox(),
              ),
              Obx(
                () => Get.find<UserViewModel>().isMeasurement.isTrue ||
                        Get.find<UserViewModel>().isWeightModule.isTrue
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ListItem(
                          title: StringConstants.weightAndMeasurementsTracking,
                          onTab: () {
                            NavigationHelper.pushScreenWithNavBar(
                              widget: const WeighingAndMeasuringView(),
                              context: context,
                            );
                          },
                          icon: Assets.iconsIcWeightMachine,
                        ),
                      )
                    : const SizedBox(),
              ),
              Obx(
                () => Get.find<UserViewModel>().isShowDailyNutrition.isTrue
                    ? (Get.find<DailyReportsViewModel>().listUserAns.isEmpty ||
                            Get.find<WeeklyReportViewModel>().listUserAns.isEmpty ||
                            Get.find<DailyNutritionViewModel>().isAvailable.isTrue)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: ListItem(
                              title: StringConstants.tools,
                              onTab: () {
                                NavigationHelper.pushScreenWithNavBar(
                                  widget: const ToolsListView(),
                                  context: context,
                                );
                              },
                              icon: Assets.iconsIcTools,
                              showReminderIcon: true,
                              reminderColor: AppColors.surfaceError,
                              reminder: StringConstants.reminderToFillReports,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: ListItem(
                              title: StringConstants.tools,
                              onTab: () {
                                NavigationHelper.pushScreenWithNavBar(
                                  widget: const ToolsListView(),
                                  context: context,
                                );
                              },
                              icon: Assets.iconsIcTools,
                            ),
                          )
                    : const SizedBox(),
              ),
              const Gap(30),
              TextBodyMedium(
                text: StringConstants.healthyConsumption,
                color: AppColors.textSecondary,
                letterSpacing: 3,
              ),
              const Gap(12),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ListItem(
                    title: StringConstants.myShoppingList,
                    onTab: () {
                      NavigationHelper.pushScreenWithNavBar(
                        widget: const MyShoppingListView(),
                        context: context,
                      );
                    },
                    icon: Assets.iconsIcShoppingList,
                    notificationCount: Get.find<HomeViewModel>().shoppingListItemCount.value == 0
                        ? ""
                        : Get.find<HomeViewModel>().shoppingListItemCount.value.toString(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListItem(
                  title: StringConstants.theRecipesILoved,
                  onTab: () {
                    NavigationHelper.pushScreenWithNavBar(
                      widget: const RecipesLovedListView(),
                      context: context,
                    );
                  },
                  icon: Assets.iconsIcRecipes,
                ),
              ),
              const Gap(30),
              TextBodyMedium(
                text: StringConstants.healthyConsumption,
                color: AppColors.textSecondary,
                letterSpacing: 3,
              ),
              const Gap(6),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ListItem(
                    title: StringConstants.myShoppingCart,
                    onTab: () {
                      NavigationHelper.pushScreenWithNavBar(
                        widget: const MyCartListView(),
                        context: context,
                      );
                    },
                    icon: Assets.iconsIcShoppingCart,
                    notificationCount: Get.find<HomeViewModel>().cartListItemCount.value == 0
                        ? ""
                        : Get.find<HomeViewModel>().cartListItemCount.value.toString(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListItem(
                  title: StringConstants.myWorkshopsEvents,
                  onTab: () {
                    NavigationHelper.pushScreenWithNavBar(
                      widget: const MyWorkshopEventListView(),
                      context: context,
                    );
                  },
                  icon: Assets.iconsIcWorkshop,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListItem(
                  title: StringConstants.theProductsILoved,
                  onTab: () {
                    NavigationHelper.pushScreenWithNavBar(
                      widget: const StoreProductLovedListView(),
                      context: context,
                    );
                  },
                  icon: Assets.iconsIcFavorite,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListItem(
                  title: StringConstants.myOrders,
                  onTab: () {
                    NavigationHelper.pushScreenWithNavBar(
                      widget: const OrderListView(),
                      context: context,
                    );
                  },
                  icon: Assets.iconsIcOrders,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListItem(
                  title: StringConstants.myStars,
                  onTab: () {
                    NavigationHelper.pushScreenWithNavBar(
                      widget: const MyStarsView(),
                      context: context,
                    );
                  },
                  icon: Assets.iconsIcStartBlack,
                ),
              ),
              const Gap(30),
              TextBodyMedium(
                text: StringConstants.contact,
                color: AppColors.textSecondary,
                letterSpacing: 3,
              ),
              const Gap(12),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListItem(
                  title: StringConstants.contactUs,
                  onTab: () {
                    NavigationHelper.pushScreenWithNavBar(
                      widget: ContactUsListView(),
                      context: context,
                    );
                  },
                  icon: Assets.iconsIcPhone,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListItem(
                  title: StringConstants.generalMessages,
                  onTab: () {
                    NavigationHelper.pushScreenWithNavBar(
                      widget: const GeneralMessageListView(),
                      context: context,
                    );
                  },
                  icon: Assets.iconsIcPhone,
                ),
              ),
              const Gap(12),
              appVersion(),
              const Gap(80),
            ],
          ),
        ),
      ),
    );
  }
}
