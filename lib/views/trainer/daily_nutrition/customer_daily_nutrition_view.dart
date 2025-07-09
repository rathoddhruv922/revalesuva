import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_bottom_sheet.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/tools/nutrition_model/selected_nutrition_data.dart'
    as selected_nutrition_data;
import 'package:revalesuva/model/trainer/home/customer_model.dart' as customer_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/app_validator.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/trainer/trainer_daily_nutrition_view_model.dart';
import 'package:revalesuva/views/trainer/daily_nutrition/widget/food_item_widget.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';

class CustomerDailyNutritionView extends StatefulWidget {
  const CustomerDailyNutritionView({super.key, required this.userData});

  final customer_model.Datum userData;

  @override
  State<CustomerDailyNutritionView> createState() => _CustomerDailyNutritionViewState();
}

class _CustomerDailyNutritionViewState extends State<CustomerDailyNutritionView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TrainerDailyNutritionViewModel dailyNutritionViewModel =
      Get.put(TrainerDailyNutritionViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        dailyNutritionViewModel.txtDate.value.text = changeDateStringFormat(
          date: DateTime.now().toString(),
          format: DateFormatHelper.ymdFormat,
        );
        dailyNutritionViewModel.isLoading.value = true;
        await dailyNutritionViewModel.getCustomerDailyReport(customerId: widget.userData.id.toString());
        dailyNutritionViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBarTrainer(
        key: scaffoldKey,
      ),
      drawer: DrawerWidget(
        drawerKey: scaffoldKey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomClick(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: TextBodySmall(
                text: "< ${StringConstants.backTo} ${StringConstants.customerOptions}",
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
            ),
            const Gap(10),
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextHeadlineMedium(
                      text: StringConstants.personalProfile,
                      color: AppColors.textPrimary,
                      letterSpacing: 0,
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                    child: CustomClick(
                      onTap: () {
                        Get.bottomSheet(
                          isScrollControlled: true,
                          ignoreSafeArea: false,
                          CustomBottomSheet(
                            bottomSheetTitle: StringConstants.date,
                            onDone: () async {
                              if (dailyNutritionViewModel.txtDate.value.text.isEmpty) {
                                dailyNutritionViewModel.txtDate.value.text = changeDateStringFormat(
                                  date: DateTime.now().toString(),
                                  format: DateFormatHelper.ymdFormat,
                                );
                              }
                              if (Get.isBottomSheetOpen ?? false) {
                                Get.back();
                              }
                              dailyNutritionViewModel.isLoading.value = true;

                              await dailyNutritionViewModel.getCustomerDailyReport(
                                  customerId: widget.userData.id.toString());

                              dailyNutritionViewModel.isLoading.value = false;
                            },
                            widget: SizedBox(
                              height: 30.h,
                              child: CupertinoTheme(
                                data: const CupertinoThemeData(brightness: Brightness.light),
                                child: CupertinoDatePicker(
                                  dateOrder: DatePickerDateOrder.ymd,
                                  itemExtent: 40,
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime:
                                      DateTime.tryParse(dailyNutritionViewModel.txtDate.value.text) ??
                                          DateTime.now(),
                                  minimumDate: DateTime(DateTime.now().year - 100),
                                  maximumDate: DateTime.now(),
                                  showDayOfWeek: true,
                                  onDateTimeChanged: (DateTime newDate) {
                                    dailyNutritionViewModel.txtDate.value.text = changeDateStringFormat(
                                      date: newDate.toString(),
                                      format: DateFormatHelper.ymdFormat,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: CustomTextField(
                        enabled: false,
                        hint: StringConstants.date,
                        controller: dailyNutritionViewModel.txtDate.value,
                        validator: (value) => FormValidate.requiredField(
                          value,
                          "${StringConstants.dateOfBirth} ${StringConstants.required}",
                        ),
                        suffixIcon: const Align(
                          child: ImageIcon(
                            AssetImage(
                              Assets.iconsIcCalendar,
                            ),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  return await dailyNutritionViewModel.getCustomerDailyReport(
                      customerId: widget.userData.id.toString());
                },
                child: Obx(
                  () => dailyNutritionViewModel.isLoading.isTrue
                      ? ListView(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          physics: const BouncingScrollPhysics(),
                          children: const [
                            CustomShimmer(
                              radius: AppCorner.listTile,
                              height: 170,
                            ),
                            Gap(10),
                            CustomShimmer(
                              radius: AppCorner.listTile,
                              height: 170,
                            ),
                            Gap(10),
                            CustomShimmer(
                              radius: AppCorner.listTile,
                              height: 170,
                            )
                          ],
                        )
                      : dailyNutritionViewModel.listDailyNutrition.isEmpty
                          ? noDataFoundWidget()
                          : ListView(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              physics: const BouncingScrollPhysics(),
                              children: [
                                FoodItemWidget(
                                  foodType: StringConstants.breakfast,
                                  nutritionType:
                                      dailyNutritionViewModel.userSelectedData.value.breakfast ??
                                          selected_nutrition_data.NutritionType(),
                                ),
                                const Gap(10),
                                FoodItemWidget(
                                  foodType: StringConstants.lunch,
                                  nutritionType:
                                      dailyNutritionViewModel.userSelectedData.value.breakfast ??
                                          selected_nutrition_data.NutritionType(),
                                ),
                                const Gap(10),
                                FoodItemWidget(
                                  foodType: StringConstants.snacks,
                                  nutritionType:
                                  dailyNutritionViewModel.userSelectedData.value.snacks ??
                                      selected_nutrition_data.NutritionType(),
                                ),
                                const Gap(10),
                                FoodItemWidget(
                                  foodType: StringConstants.dinner,
                                  nutritionType:
                                      dailyNutritionViewModel.userSelectedData.value.breakfast ??
                                          selected_nutrition_data.NutritionType(),
                                ),
                                const Gap(10),
                              ],
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
