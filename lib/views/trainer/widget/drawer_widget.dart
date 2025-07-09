import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_dialog.dart';
import 'package:revalesuva/utils/router.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/trainer/trainer_home_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/home/widget/drawer_item.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key, required this.drawerKey});

  final TrainerHomeViewModel homeViewModel = Get.find<TrainerHomeViewModel>();
  final GlobalKey<ScaffoldState> drawerKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            DrawerItem(
              title: StringConstants.personalArea,
              onPressed: () {
                drawerKey.currentState?.closeDrawer();
                Get.toNamed(RoutesName.trainerProfile);
              },
            ),
            DrawerItem(
              title: StringConstants.logout,
              onPressed: () {
                drawerKey.currentState?.closeDrawer();
                CustomDialog.positiveNegativeButtons(
                  title: StringConstants.areYouSureYouWantToLogOut,
                  onNegativePressed: () {
                    if (Get.isDialogOpen ?? false) {
                      Get.back();
                    }
                    //showLoader();
                    Get.find<UserViewModel>().logoutUser();
                  },
                  onPositivePressed: () {
                    if (Get.isDialogOpen ?? false) {
                      Get.back();
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
