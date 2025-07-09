import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/view_models/tools/fasting_calculator_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/home/home_components_widget/event_calender_widget.dart';
import 'package:revalesuva/views/home/home_components_widget/fasting_calculator_widget.dart';
import 'package:revalesuva/views/home/home_components_widget/greeting_widget.dart';
import 'package:revalesuva/views/home/home_components_widget/message_notification_list_widget.dart';
import 'package:revalesuva/views/home/home_components_widget/my_task_widget.dart';
import 'package:revalesuva/views/home/home_components_widget/ovulation_forecast_widget.dart';
import 'package:revalesuva/views/home/home_components_widget/weight_graph_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var isLoading = false;

  Future<bool> getFasting() async {
    await Future.delayed(const Duration(seconds: 2));
    if(Get.find<UserViewModel>().isFastingModule.value){
      return await Get.find<FastingCalculatorViewModel>().getTodayFastingData(isShowLoader: false) &&
          Get.find<FastingCalculatorViewModel>().todayStartTime.isNotEmpty;
    }else{
      return false;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: RefreshIndicator(
          child: isLoading
              ? ListView(
                  padding: const EdgeInsets.all(20),
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    CustomShimmer(
                      radius: AppCorner.listTile,
                      height: 30,
                    ),
                    Gap(10),
                    CustomShimmer(
                      radius: AppCorner.listTile,
                      height: 30,
                    ),
                    Gap(10),
                    CustomShimmer(
                      radius: AppCorner.listTile,
                      height: 80,
                    ),
                    Gap(10),
                    CustomShimmer(
                      radius: AppCorner.listTile,
                      height: 200,
                    ),
                    Gap(10),
                    CustomShimmer(
                      radius: AppCorner.listTile,
                      height: 200,
                    )
                  ],
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GreetingWidget(),
                      const Gap(10),
                      const MessageNotificationListWidget(),
                      Obx(
                        () => Get.find<UserViewModel>().userPlanDetail.value.id != null
                            ? MyTaskWidget()
                            : const SizedBox(),
                      ),
                      Obx(
                        () => Get.find<UserViewModel>().userPlanDetail.value.id != null
                            ? const WeightGraphWidget()
                            : const SizedBox(),
                      ),
                      FutureBuilder<bool>(
                        future: getFasting(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                            bool isShowFasting = snapshot.data ?? false;
                            return Row(
                              children: [
                                Obx(
                                      () =>
                                  Get.find<UserViewModel>().userData.value.gender?.toLowerCase() ==
                                      "female"
                                      ? Expanded(child: OvulationForecastWidget())
                                      : const SizedBox(),
                                ),
                                if (isShowFasting) const Gap(10),
                                if (isShowFasting) const Expanded(child: FastingCalculatorWidget())
                              ],
                            );
                          } else {
                            return Row(
                              children: [
                                Obx(
                                      () =>
                                  Get.find<UserViewModel>().userData.value.gender?.toLowerCase() ==
                                      "female"
                                      ? Expanded(child: OvulationForecastWidget())
                                      : const SizedBox(),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const Gap(20),
                      const EventCalenderWidget(),
                    ],
                  ),
                ),
          onRefresh: () async {
            setState(() {
              isLoading = true;
            });
            await Future.delayed(const Duration(seconds: 5));
            setState(() {
              isLoading = false;
            });
            return;
          },
        ),
      ),
    );
  }
}
