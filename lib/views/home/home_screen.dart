import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_dialog.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/my_plan/plans/all_plan_model.dart' as all_plan_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/home/home_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/article/article_list_view.dart';
import 'package:revalesuva/views/general_message/general_message_list_view.dart';
import 'package:revalesuva/views/hadas_strengthening/hadas_strengthening_view.dart';
import 'package:revalesuva/views/home/widget/custom_bottom_nav_widget.dart';
import 'package:revalesuva/views/home/widget/drawer_item.dart';
import 'package:revalesuva/views/making_contact/contact_us_list_view.dart';
import 'package:revalesuva/views/my_plan/nutrition_plans_detail_view.dart';
import 'package:revalesuva/views/personal_area/personal_area_screen.dart';
import 'package:revalesuva/views/podcasts/podcast_host_list_view.dart';
import 'package:revalesuva/views/regulations/regulations_list_view.dart';
import 'package:revalesuva/views/workshop_events/workshop_event_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel homeViewModel = Get.put(HomeViewModel(), permanent: true);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime? lastBackPressed;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if(Get.find<UserViewModel>().childActiveScreenName.value == ""){

          if(homeViewModel.controller.index == 0){
            DateTime now = DateTime.now();
            if (lastBackPressed == null ||
                now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
              lastBackPressed = now;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Press back again to exit")),
              );
            } else {
              SystemNavigator.pop();
            }
          }
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: customAppBar2(
          key: scaffoldKey,
          onMessageTap: () {
            scaffoldKey.currentState?.closeDrawer();
            homeViewModel.controller.jumpToTab(0);
            NavigationHelper.pushScreenWithNavBar(
              widget: const GeneralMessageListView(),
              context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
            );
          },
        ),
        drawer: SafeArea(
          child: Drawer(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                DrawerItem(
                  title: StringConstants.personalArea,
                  onPressed: () {
                    scaffoldKey.currentState?.closeDrawer();
                    homeViewModel.controller.jumpToTab(0);
                    NavigationHelper.pushScreenWithNavBar(
                      widget: const PersonalAreaScreen(),
                      context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                    );
                  },
                ),
                ExpansionTileItem.flat(
                  title: TextTitleMedium(
                    text: StringConstants.nutritionPlans,
                    color: AppColors.textPrimary,
                  ),
                  childrenPadding: const EdgeInsets.only(
                    right: 5,
                    left: 5,
                    bottom: 10,
                  ),
                  isDefaultVerticalPadding: false,
                  trailingIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                  leading: const SizedBox.shrink(),
                  tilePadding: const EdgeInsets.all(0),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<List<all_plan_model.Datum>>(
                      future: homeViewModel.getAllPlanList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const SizedBox();
                        } else {
                          List<all_plan_model.Datum> data = snapshot.data ?? [];
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CustomClick(
                                onTap: () {
                                  scaffoldKey.currentState?.closeDrawer();
                                  homeViewModel.controller.jumpToTab(0);
                                  NavigationHelper.pushScreenWithNavBar(
                                    widget: NutritionPlansDetailView(
                                      planData: data[index],
                                    ),
                                    context:
                                        homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                                  );
                                },
                                child: TextBodySmall(
                                  text: data[index].name ?? "",
                                  color: AppColors.textPrimary,
                                ),
                              );
                            },
                            itemCount: data.length,
                            separatorBuilder: (BuildContext context, int index) {
                              return const Gap(15);
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
                const Divider(),
                FutureBuilder<List<all_plan_model.Datum>>(
                  future: homeViewModel.getAllProgram(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox.shrink();
                    } else {
                      List<all_plan_model.Datum> data = snapshot.data ?? [];
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return DrawerItem(
                            title: data[index].name ?? "",
                            onPressed: () {
                              scaffoldKey.currentState?.closeDrawer();
                              homeViewModel.controller.jumpToTab(0);
                              NavigationHelper.pushScreenWithNavBar(
                                widget: NutritionPlansDetailView(
                                  planData: data[index],
                                ),
                                context:
                                    homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(0),
                        itemCount: data.length,
                      );
                    }
                  },
                ),
                DrawerItem(
                  title: StringConstants.articles,
                  onPressed: () {
                    scaffoldKey.currentState?.closeDrawer();
                    homeViewModel.controller.jumpToTab(0);
                    NavigationHelper.pushScreenWithNavBar(
                      widget: const ArticleListView(),
                      context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                    );
                  },
                ),
                DrawerItem(
                  title: StringConstants.podcasts,
                  onPressed: () {
                    scaffoldKey.currentState?.closeDrawer();
                    homeViewModel.controller.jumpToTab(0);
                    NavigationHelper.pushScreenWithNavBar(
                      widget: const PodcastHostListView(),
                      context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                    );
                  },
                ),
                DrawerItem(
                  title: StringConstants.workshopsAndEvents,
                  onPressed: () {
                    scaffoldKey.currentState?.closeDrawer();
                    homeViewModel.controller.jumpToTab(0);
                    NavigationHelper.pushScreenWithNavBar(
                      widget: const WorkshopEventListView(),
                      context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                    );
                  },
                ),
                DrawerItem(
                  title: StringConstants.hadasStrengthening,
                  onPressed: () {
                    scaffoldKey.currentState?.closeDrawer();
                    homeViewModel.controller.jumpToTab(0);
                    NavigationHelper.pushScreenWithNavBar(
                      widget: const HadasStrengtheningView(),
                      context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                    );
                  },
                ),
                DrawerItem(
                  title: StringConstants.store,
                  onPressed: () {
                    scaffoldKey.currentState?.closeDrawer();
                    homeViewModel.controller.jumpToTab(5);
                  },
                ),
                DrawerItem(
                  title: StringConstants.contactUs,
                  onPressed: () {
                    scaffoldKey.currentState?.closeDrawer();
                    homeViewModel.controller.jumpToTab(0);
                    NavigationHelper.pushScreenWithNavBar(
                      widget: ContactUsListView(),
                      context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                    );
                  },
                ),
                DrawerItem(
                  title: StringConstants.termsAndConditions,
                  onPressed: () {
                    scaffoldKey.currentState?.closeDrawer();
                    homeViewModel.controller.jumpToTab(0);
                    NavigationHelper.pushScreenWithNavBar(
                      widget: const RegulationsListView(),
                      context: homeViewModel.persistentNavKey[0].currentState?.context ?? context,
                    );
                  },
                ),
                DrawerItem(
                  title: StringConstants.logout,
                  onPressed: () {
                    scaffoldKey.currentState?.closeDrawer();
                    homeViewModel.controller.jumpToTab(0);
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
        ),
        body: Obx(
          () => PersistentTabView(
            navBarHeight: 80,
            controller: homeViewModel.controller,
            tabs: homeViewModel.tabs(),
            navBarBuilder: (navBarConfig) {
              return Obx(
                () => CustomBottomNavWidget(
                  navBarConfig: navBarConfig,
                  backgroundColor: homeViewModel.isIceDeepScreen.isTrue
                      ? AppColors.surfaceBlue
                      : AppColors.surfaceGreen,
                ),
              );
            },
            resizeToAvoidBottomInset: false,
            navBarOverlap: const NavBarOverlap.full(),
            avoidBottomPadding: true,
            stateManagement: true,
            handleAndroidBackButtonPress: true,
            popAllScreensOnTapAnyTabs: true,
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            hideNavigationBar: homeViewModel.isNavigationBarHide.value,
            onTabChanged: (value) {
              homeViewModel.currentActiveTab.value = value;
            },
          ),
        ),
      ),
    );
  }
}
