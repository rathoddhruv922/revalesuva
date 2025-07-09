import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/trainer/home/customer_model.dart' as customer_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/router.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/trainer/trainer_task_view_model.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';

class CustomerTaskListView extends StatefulWidget {
  const CustomerTaskListView({super.key, required this.userData});

  final customer_model.Datum userData;

  @override
  State<CustomerTaskListView> createState() => _CustomerTaskListViewState();
}

class _CustomerTaskListViewState extends State<CustomerTaskListView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TrainerTaskViewModel trainerTaskViewModel = Get.put(TrainerTaskViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        trainerTaskViewModel.isLoading.value = true;
        await trainerTaskViewModel.getAllTask(planId: "${widget.userData.plan?.id ?? ""}");
        await trainerTaskViewModel.getCustomerTaskList(
          planId: "${widget.userData.plan?.id ?? ""}",
          customerId: "${widget.userData.id ?? ""}",
        );
        trainerTaskViewModel.isLoading.value = false;
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
            TextHeadlineMedium(
              text: StringConstants.tasks,
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(10),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  trainerTaskViewModel.isLoading.value = true;
                  trainerTaskViewModel.getAllTask(planId: "${widget.userData.plan?.id ?? ""}");
                  trainerTaskViewModel.getCustomerTaskList(
                    planId: "${widget.userData.plan?.id ?? ""}",
                    customerId: "${widget.userData.id ?? ""}",
                  );
                  trainerTaskViewModel.isLoading.value = false;
                },
                child: Obx(
                  () => trainerTaskViewModel.isLoading.isTrue
                      ? ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return const CustomShimmer(
                              radius: AppCorner.listTile,
                              height: 60,
                            );
                          },
                          separatorBuilder: (context, index) => const Gap(10),
                          itemCount: 10,
                        )
                      : trainerTaskViewModel.listAllTask.isEmpty
                          ? noDataFoundWidget()
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                bool isCompleted = trainerTaskViewModel.listCustomerTask.any(
                                  (element) =>
                                      element.taskId == trainerTaskViewModel.listAllTask[index].id,
                                );
                                return CustomClick(
                                  onTap: () {
                                    Get.toNamed(
                                      RoutesName.customerTaskDetail,
                                      arguments: [trainerTaskViewModel.listAllTask[index], isCompleted],
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceTertiary,
                                      borderRadius: BorderRadius.circular(AppCorner.listTile),
                                    ),
                                    child: Column(
                                      children: [
                                        TextBodyMedium(
                                          text: trainerTaskViewModel.listAllTask[index].title ?? "",
                                          maxLine: 2,
                                          color: AppColors.textPrimary,
                                        ),
                                        const Gap(10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextBodySmall(
                                                text: StringConstants.forMoreDetails,
                                                color: AppColors.surfaceGreen,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: isCompleted
                                                    ? AppColors.surfaceGreen
                                                    : AppColors.surfaceError,
                                                borderRadius: BorderRadius.circular(AppCorner.button),
                                              ),
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 3,
                                                horizontal: 10,
                                              ),
                                              child: TextTitleMedium(
                                                text: isCompleted ? "Completed" : "Pending",
                                                color: AppColors.textTertiary,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => const Gap(10),
                              itemCount: trainerTaskViewModel.listAllTask.length,
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
