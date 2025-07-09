import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/list_item.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/router.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/trainer/trainer_home_view_model.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';

class TrainerHomeView extends StatefulWidget {
  const TrainerHomeView({super.key});

  @override
  State<TrainerHomeView> createState() => _TrainerHomeViewState();
}

class _TrainerHomeViewState extends State<TrainerHomeView> {
  final TrainerHomeViewModel homeViewModel = Get.put(TrainerHomeViewModel(), permanent: true);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        homeViewModel.isLoading.value = true;
        await homeViewModel.getCustomerByTrainer();
        homeViewModel.isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: customAppBarTrainer(
        key: scaffoldKey,
      ),
      drawer: SafeArea(
        child: DrawerWidget(
          drawerKey: scaffoldKey,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextHeadlineMedium(
              text: StringConstants.customer,
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            Expanded(
              child: Obx(
                () => homeViewModel.isLoading.isTrue
                    ? ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemBuilder: (context, index) {
                          return const CustomShimmer(
                            height: 50,
                            radius: AppCorner.listTile,
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(10),
                        itemCount: 10,
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemBuilder: (context, index) {
                          return ListItem(
                            title: homeViewModel.listCustomers[index].name ?? "",
                            onTab: () {
                              Get.toNamed(
                                RoutesName.trainerCustomerInfo,
                                arguments: homeViewModel.listCustomers[index],
                              );
                            },
                            icon: Assets.iconsIcPeople,
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(10),
                        itemCount: homeViewModel.listCustomers.length,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
