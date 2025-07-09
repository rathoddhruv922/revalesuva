import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/my_stars/my_stars_view_model.dart';

class MyStarsView extends StatefulWidget {
  const MyStarsView({super.key, this.isShowBack = true});

  final bool isShowBack;

  @override
  State<MyStarsView> createState() => _MyStarsViewState();
}

class _MyStarsViewState extends State<MyStarsView> {
  MyStarsViewModel myStarsViewModel = Get.put(MyStarsViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        myStarsViewModel.fetchStars();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            if (widget.isShowBack)
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.personalArea}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
            const Gap(10),
            TextHeadlineMedium(text: StringConstants.myStars),
            const Gap(5),
            AspectRatio(
              aspectRatio: 16 / 8,
              child: Image.asset(Assets.imagesStarLeading),
            ),
            const Gap(10),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppCorner.messageBox),
                color: AppColors.surfaceOrange,
              ),
              child: Row(
                children: [
                  const ImageIcon(
                    AssetImage(Assets.iconsIcMyStarsUnselected),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Obx(
                      () => TextTitleMedium(
                        text: StringConstants.soFarYouHaveEarnedStars
                            .replaceAll("{}", myStarsViewModel.totalEarnedStar.toString()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            Expanded(
              child: Obx(
                () => myStarsViewModel.isLoading.value
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
                    : (myStarsViewModel.listStars.isNotEmpty)
                        ? RefreshIndicator(
                            onRefresh: () {
                              return myStarsViewModel.fetchStars();
                            },
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return ExpansionTileItem.card(
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: TextTitleMedium(
                                      text: myStarsViewModel.listStars[index].question ?? "",
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceTertiary,
                                    borderRadius: BorderRadius.circular(AppCorner.listTile),
                                  ),
                                  elevation: 0,
                                  childrenPadding:
                                      const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                                  isDefaultVerticalPadding: false,
                                  trailingIcon: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: TextBodyMedium(
                                        text: myStarsViewModel.listStars[index].answer ?? "",
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const Gap(5),
                                    Align(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: TextBodySmall(
                                        text: changeDateStringFormat(
                                          date: myStarsViewModel.listStars[index].createdAt.toString(),
                                          format: DateFormatHelper.ymdFormat,
                                        ),
                                        color: AppColors.textPrimary,
                                        size: -1,
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) => const Gap(10),
                              itemCount: myStarsViewModel.listStars.length,
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () {
                              return myStarsViewModel.fetchStars();
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
    );
  }
}
