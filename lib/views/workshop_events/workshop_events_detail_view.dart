import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/view_models/workshop_events/workshop_event_view_model.dart';
import 'package:revalesuva/views/workshop_events/widget/event_info_item_widget.dart';
import 'package:revalesuva/views/workshop_events/widget/registration_info_edit_widget.dart';
import 'package:revalesuva/views/workshop_events/widget/registration_info_widget.dart';

class WorkshopEventsDetailView extends StatefulWidget {
  const WorkshopEventsDetailView({
    super.key,
    required this.data,
    required this.fromScreen,
  });

  final workshop_event_model.Datum data;
  final String fromScreen;

  @override
  State<WorkshopEventsDetailView> createState() => _WorkshopEventsDetailViewState();
}

class _WorkshopEventsDetailViewState extends State<WorkshopEventsDetailView> {
  final WorkshopEventViewModel workshopEventViewModel = Get.find<WorkshopEventViewModel>();
  future_workshop_event_model.Datum? userdata;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        workshopEventViewModel.isHide.value = true;
        await workshopEventViewModel.fetchFutureWorkshopEvent();
        userdata = workshopEventViewModel.listFutureEvent.firstWhereOrNull(
          (element) => element.workshopEventId == widget.data.id,
        );
        if (userdata != null) {
          workshopEventViewModel.txtFullName.value.text = userdata?.participantName ?? "";
          workshopEventViewModel.txtEmail.value.text = userdata?.email ?? "";
          workshopEventViewModel.txtPhone.value.text = userdata?.phoneNumber ?? "";
          workshopEventViewModel.txtStreet.value.text = userdata?.street ?? "";
          workshopEventViewModel.txtHouse.value.text = userdata?.house ?? "";
          workshopEventViewModel.txtApartment.value.text = userdata?.apartment ?? "";
          workshopEventViewModel.txtZipcode.value.text = userdata?.zipcode ?? "";
          workshopEventViewModel.txtCity.value = userdata?.city ?? "";
        } else {
          workshopEventViewModel.txtFullName.value.text =
              Get.find<UserViewModel>().userData.value.name ?? "";
          workshopEventViewModel.txtEmail.value.text =
              Get.find<UserViewModel>().userData.value.email ?? "";
          workshopEventViewModel.txtPhone.value.text =
              Get.find<UserViewModel>().userData.value.contactNumber ?? "";
          workshopEventViewModel.txtStreet.value.text =
              Get.find<UserViewModel>().userData.value.street ?? "";
          workshopEventViewModel.txtHouse.value.text =
              Get.find<UserViewModel>().userData.value.house ?? "";
          workshopEventViewModel.txtApartment.value.text =
              Get.find<UserViewModel>().userData.value.apartment ?? "";
          workshopEventViewModel.txtZipcode.value.text =
              Get.find<UserViewModel>().userData.value.zipcode ?? "";
          workshopEventViewModel.txtCity.value = Get.find<UserViewModel>().userData.value.city ?? "";
        }
        workshopEventViewModel.isHide.value = false;

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
          widget: WorkshopEventsDetailView(
            data: widget.data,
            fromScreen: widget.fromScreen,
          ),
        );
      },
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.productsAndRecipes}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(20),
              TextHeadlineMedium(
                text: widget.data.title ?? "",
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
              const Gap(10),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppCorner.listTileImage),
                      child: AspectRatio(
                        aspectRatio: 48 / 25,
                        child: CustomImageViewer(
                          imageUrl: widget.data.image,
                          errorImage: Image.asset(
                            Assets.imagesPlaceholderImg,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppCorner.eventInfoCard),
                        color: AppColors.surfaceYellow,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: EventInfoItemWidget(
                              icon: Assets.iconsIcEventCalender,
                              title: changeDateStringFormat(
                                date: widget.data.date.toString(),
                                format: DateFormatHelper.mdyFormat,
                              ),
                              description:
                                  "${widget.data.endTime?.substring(0, (widget.data.endTime?.length ?? 0) - 3) ?? ""} - "
                                  "${widget.data.startTime?.substring(0, (widget.data.startTime?.length ?? 0) - 3) ?? ""}",
                            ),
                          ),
                          const Gap(10),
                          Expanded(
                            flex: 4,
                            child: EventInfoItemWidget(
                              icon: Assets.iconsIcMoney,
                              title: widget.data.price != null
                                  ? "${widget.data.price} ${StringConstants.nis}"
                                  : StringConstants.freeOfCharge,
                              description: "",
                            ),
                          ),
                          const Gap(10),
                          Expanded(
                            flex: 5,
                            child: EventInfoItemWidget(
                              icon: Assets.iconsIcParticipat,
                              title: "${widget.data.noOfPeople} ${StringConstants.participants}",
                              description: "",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    CustomCard2(
                      color: AppColors.surfaceTertiary,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHeadlineMedium(text: StringConstants.soWhatsInTheEvent),
                          const Gap(10),
                          customHtmlWidget(widget.data.description ?? ""),
                        ],
                      ),
                    ),
                    const Gap(10),
                    widget.fromScreen == "past"
                        ? const SizedBox()
                        : widget.fromScreen == "future"
                            ? SimpleButton(
                                text: StringConstants.cancel,
                                onPressed: () async {
                                  var isSuccess = await workshopEventViewModel.deleteWorkshopEventById(
                                    eventId: userdata?.id ?? 0,
                                  );
                                  if (isSuccess && context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                },
                              )
                            : Obx(
                                () => workshopEventViewModel.isHide.value
                                    ? const CustomShimmer(
                                  height: 250,
                                  radius: AppCorner.listTile,
                                )
                                    : workshopEventViewModel.isEditMode.value
                                        ? RegistrationInfoEditWidget(
                                            title: widget.data.title ?? "",
                                          )
                                        : RegistrationInfoWidget(
                                            title: widget.data.title ?? "",
                                            data: widget.data,
                                            isAlreadyIn: userdata != null,
                                          ),
                              ),
                    const Gap(50)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
