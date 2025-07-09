import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/list_item.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/personal_detail/common_media_view_model.dart';

import 'show_cms_view.dart';

class RegulationsListView extends StatefulWidget {
  const RegulationsListView({super.key});

  @override
  State<RegulationsListView> createState() => _RegulationsListViewState();
}

class _RegulationsListViewState extends State<RegulationsListView> {
  final CommonMediaViewModel commonMediaViewModel = Get.find<CommonMediaViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   regulationViewModel.callGetCms();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const RegulationsListView());
      },
      canPop: true,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await commonMediaViewModel.callGetCms();
          },
          child: ListView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()
            ),
            children: [
              const Gap(10),
              TextHeadlineMedium(
                text: StringConstants.regulations,
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
              const Gap(12),
              ListItem(
                title: StringConstants.shippingAndReturnsPolicy,
                onTab: () {
                  var data = commonMediaViewModel.getCmsData(slug: "shipping-and-return-policy");
                  if (data != null) {
                    NavigationHelper.pushScreenWithNavBar(
                      widget: ShowCmsView(
                        data: data,
                      ),
                      context: context,
                    );
                  }
                },
                icon: Assets.iconsIcShoppingPolicy,
              ),
              const Gap(12),
              ListItem(
                title: StringConstants.privacyPolicy,
                onTab: () {
                  var data = commonMediaViewModel.getCmsData(slug: "privacy-policy");
                  if (data != null) {
                    NavigationHelper.pushScreenWithNavBar(
                      widget: ShowCmsView(
                        data: data,
                      ),
                      context: context,
                    );
                  }
                },
                icon: Assets.iconsIcPrivacyPolicy,
              ),
              const Gap(12),
              ListItem(
                title: StringConstants.termsAndConditions,
                onTab: () {
                  var data = commonMediaViewModel.getCmsData(slug: "terms-of-use");
                  if (data != null) {
                    NavigationHelper.pushScreenWithNavBar(
                      widget: ShowCmsView(
                        data: data,
                      ),
                      context: context,
                    );

                  }
                },
                icon: Assets.iconsIcTermsOfUse,
              ),
              const Gap(12),
              ListItem(
                title: StringConstants.accessibility,
                onTab: () {
                  var data = commonMediaViewModel.getCmsData(slug: "accessibility");
                  if (data != null) {
                     NavigationHelper.pushScreenWithNavBar(widget: ShowCmsView(
                       data: data,
                     ), context: context);

                  }
                },
                icon: Assets.iconsIcAccessibility,
              ),
              const Gap(30),
              const Gap(80),
            ],
          ),
        ),
      ),
    );
  }
}
