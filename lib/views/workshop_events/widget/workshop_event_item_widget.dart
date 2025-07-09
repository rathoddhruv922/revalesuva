import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_Image_viewer.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/workshop_events/workshop_event_model.dart' as workshop_event_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/date_format_helper.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/navigation_helper.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/views/workshop_events/workshop_events_detail_view.dart';

class WorkshopEventItemWidget extends StatelessWidget {
  const WorkshopEventItemWidget({
    super.key,
    required this.data,
  });

  final workshop_event_model.Datum data;

  @override
  Widget build(BuildContext context) {
    return CustomClick(
      onTap: () {},
      child: Container(
        height: 80,
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.surfaceTertiary,
          borderRadius: BorderRadius.circular(AppCorner.listTile),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 13 / 10,
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(
                  AppCorner.listTileImage,
                ),
                child: CustomImageViewer(
                  imageUrl: data.image,
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
                    text: data.title ?? "",
                    maxLine: 1,
                  ),
                  TextBodySmall(
                    text: "${StringConstants.onDate}:${changeDateStringFormat(
                      date: data.date.toString(),
                      format: DateFormatHelper.mdyFormat,
                    )}",
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
                          data: data,
                          fromScreen: "main",
                        ),
                        context: context,
                      );
                    },
                  ),
                ],
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
