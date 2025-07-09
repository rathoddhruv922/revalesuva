import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/model/workshop_events/workshop_event_model.dart' as workshop_event_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/workshop_events/workshop_event_view_model.dart';
import 'package:revalesuva/views/personal_profile/widget/edit_button_widget.dart';
import 'package:revalesuva/views/personal_profile/widget/info_display_widget.dart';

class RegistrationInfoWidget extends StatelessWidget {
  RegistrationInfoWidget({
    super.key,
    required this.title,
    required this.data,
    required this.isAlreadyIn,
  });

  final WorkshopEventViewModel workshopEventViewModel = Get.find<WorkshopEventViewModel>();
  final String title;
  final workshop_event_model.Datum data;
  final bool isAlreadyIn;

  @override
  Widget build(BuildContext context) {
    return CustomCard2(
      color: AppColors.surfaceTertiary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditButtonWidget(
            title: StringConstants.registrationFor.replaceAll("{}", title),
            onTab:isAlreadyIn ? null : () {
              workshopEventViewModel.isEditMode.value = true;
            },
          ),
          const Gap(10),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.fullName,
              value: workshopEventViewModel.txtFullName.value.text,
            ),
          ),
          const Gap(5),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.email,
              value: workshopEventViewModel.txtEmail.value.text,
            ),
          ),
          const Gap(5),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.fullName,
              value: workshopEventViewModel.txtPhone.value.text,
            ),
          ),
          const Gap(5),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.street,
              value: workshopEventViewModel.txtStreet.value.text,
            ),
          ),
          const Gap(5),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.house,
              value: workshopEventViewModel.txtHouse.value.text,
            ),
          ),
          const Gap(5),
          InfoDisplayWidget(
            title: StringConstants.apartment,
            value: workshopEventViewModel.txtApartment.value.text,
          ),
          const Gap(5),
          InfoDisplayWidget(
            title: StringConstants.postalCode,
            value: workshopEventViewModel.txtZipcode.value.text,

          ),
          const Gap(5),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.city,
              value: workshopEventViewModel.txtCity.value,
            ),
          ),
          const Gap(20),
          if(!isAlreadyIn)
          SimpleButton(
            width: 100.w,
            text: StringConstants.registration,
            onPressed: () async {
              var isSuccess = await workshopEventViewModel.createWorkshopEvent(
                event: data,
              );
              if (isSuccess && context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
