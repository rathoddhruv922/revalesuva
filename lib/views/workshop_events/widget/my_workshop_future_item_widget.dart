import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/workshop_events/future_workshop_event_model.dart'
    as future_workshop_event_model;
import 'package:revalesuva/model/workshop_events/workshop_event_model.dart' as workshop_event_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/views/workshop_events/workshop_events_detail_view.dart';

class MyWorkshopFutureItemWidget extends StatelessWidget {
  const MyWorkshopFutureItemWidget({
    super.key,
    required this.data,
    this.onUpdate,
  });

  final future_workshop_event_model.Datum data;
  final Function()? onUpdate;

  @override
  Widget build(BuildContext context) {
    return CustomClick(
      onTap: () {},
      child: Container(
        height: 100,
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.surfaceTertiary,
          borderRadius: BorderRadius.circular(AppCorner.listTile),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 13 / 10,
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(
                  AppCorner.listTileImage,
                ),
                child: CustomImageViewer(
                  imageUrl: data.workShopEvent?.image,
                  errorImage: Image.asset(
                    Assets.imagesPlaceholderImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextTitleMedium(
                    text: data.workShopEvent?.title ?? "",
                    maxLine: 1,
                  ),
                  TextBodySmall(
                    text: "${StringConstants.onDate}: ${changeDateStringFormat(
                      date: data.workShopEvent?.date.toString() ?? "",
                      format: DateFormatHelper.mdyFormat,
                    )}",
                    maxLine: 1,
                    color: AppColors.textPrimary,
                  ),
                  const Gap(5),
                  TextBodySmall(
                    text:
                        "${StringConstants.from}: ${data.workShopEvent?.endTime?.substring(0, (data.workShopEvent?.endTime?.length ?? 0) - 3) ?? ""} - "
                        "${data.workShopEvent?.startTime?.substring(0, (data.workShopEvent?.startTime?.length ?? 0) - 3) ?? ""}",
                    maxLine: 1,
                    color: AppColors.textPrimary,
                  ),
                  const Gap(5),
                  CustomTextButton(
                    text: StringConstants.forMoreDetails,
                    underline: true,
                    onPressed: () {
                      NavigationHelper.pushScreenWithNavBar(
                        widget: WorkshopEventsDetailView(
                          fromScreen: "future",
                          data: workshop_event_model.Datum(
                            price: data.workShopEvent?.price,
                            date: data.workShopEvent?.date,
                            id: data.workShopEvent?.id,
                            updatedAt: data.workShopEvent?.updatedAt,
                            createdAt: data.workShopEvent?.createdAt,
                            isActive: data.workShopEvent?.isActive,
                            image: data.workShopEvent?.image,
                            title: data.workShopEvent?.title,
                            description: data.workShopEvent?.description,
                            endTime: data.workShopEvent?.endTime,
                            noOfPeople: data.workShopEvent?.noOfPeople,
                            startTime: data.workShopEvent?.startTime,
                          ),
                        ),
                        context: context,
                      );
                    },
                  ),
                ],
              ),
            ),
            const Gap(10),
            CustomClick(
              onTap: onUpdate,
              child: Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceBrand,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const ImageIcon(
                  AssetImage(Assets.iconsIcEdit2),
                  size: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
