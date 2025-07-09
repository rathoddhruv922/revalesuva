import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/tools/nutritional_information/nutritional_information_model.dart'
    as nutritional_information_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/tools/nutritional_information_view_model.dart';
import 'package:revalesuva/views/tools/nutritional_information/nutritional_information_detail_view.dart';
import 'package:revalesuva/views/tools/nutritional_information/widget/nutritional_information_item.dart';

class NutritionalInformationListView extends StatefulWidget {
  const NutritionalInformationListView({super.key});

  @override
  State<NutritionalInformationListView> createState() => _NutritionalInformationListViewState();
}

class _NutritionalInformationListViewState extends State<NutritionalInformationListView> {
  final NutritionalInformationViewModel nutritionalInformationViewModel =
      Get.put(NutritionalInformationViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        nutritionalInformationViewModel.fetchNutritionalInformation();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const NutritionalInformationListView());
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.tools}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(10),
              TextHeadlineMedium(
                text: StringConstants.nutritionalInformation,
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
              const Gap(20),
              Expanded(
                child: Obx(
                  () => nutritionalInformationViewModel.isLoading.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomShimmer(
                              height: 40,
                              width: 100.w,
                              radius: 15,
                            ),
                          ],
                        )
                      : (nutritionalInformationViewModel.listNutritional.isNotEmpty)
                          ? RefreshIndicator(
                              onRefresh: () {
                                return nutritionalInformationViewModel.fetchNutritionalInformation();
                              },
                              child: ListView.separated(
                                physics:
                                    const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                itemBuilder: (BuildContext context, int index) {
                                  nutritional_information_model.Datum data =
                                      nutritionalInformationViewModel.listNutritional[index];
                                  return NutritionalInformationItem(
                                    index: index,
                                    data: data,
                                    onTap: () {
                                      NavigationHelper.pushScreenWithNavBar(
                                        widget: NutritionalInformationDetailView(
                                          data: data,
                                        ),
                                        context: context,
                                      );
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) => const Gap(10),
                                itemCount: nutritionalInformationViewModel.listNutritional.length,
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () {
                                return nutritionalInformationViewModel.fetchNutritionalInformation();
                              },
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50.h,
                                  child: TextHeadlineMedium(text: StringConstants.noDataFound),
                                ),
                              ),
                            ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
