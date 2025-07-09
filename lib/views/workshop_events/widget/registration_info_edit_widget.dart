import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/workshop_events/future_workshop_event_model.dart'
    as future_workshop_event_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_validator.dart';
import 'package:revalesuva/utils/default_list.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/workshop_events/workshop_event_view_model.dart';
import 'package:revalesuva/views/personal_profile/widget/info_display_edit_dropdown_widget.dart';
import 'package:revalesuva/views/personal_profile/widget/info_display_edit_widget.dart';

class RegistrationInfoEditWidget extends StatefulWidget {
  const RegistrationInfoEditWidget({super.key, required this.title, this.data});

  final future_workshop_event_model.Datum? data;
  final String title;

  @override
  State<RegistrationInfoEditWidget> createState() => _RegistrationInfoEditWidgetState();
}

class _RegistrationInfoEditWidgetState extends State<RegistrationInfoEditWidget> {
  final WorkshopEventViewModel workshopEventViewModel = Get.find<WorkshopEventViewModel>();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      workshopEventViewModel.txtFullName.value.text = widget.data?.participantName ?? "";
      workshopEventViewModel.txtEmail.value.text = widget.data?.email ?? "";
      workshopEventViewModel.txtPhone.value.text = widget.data?.phoneNumber ?? "";
      workshopEventViewModel.txtStreet.value.text = widget.data?.street ?? "";
      workshopEventViewModel.txtHouse.value.text = widget.data?.house ?? "";
      workshopEventViewModel.txtApartment.value.text = widget.data?.apartment ?? "";
      workshopEventViewModel.txtZipcode.value.text = widget.data?.zipcode ?? "";
      workshopEventViewModel.txtCity.value = widget.data?.city ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard2(
      color: AppColors.surfaceTertiary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextTitleMedium(
                  text: StringConstants.registrationFor.replaceAll("{}", widget.title),
                ),
              ),
              widget.data == null
                  ? SimpleButton(
                      height: 30,
                      text: StringConstants.submit,
                      onPressed: () {
                        workshopEventViewModel.isEditMode.value = false;
                      },
                    )
                  : const SizedBox()
            ],
          ),
          const Gap(20),
          InfoDisplayEditWidget(
            title: StringConstants.fullName,
            controller: workshopEventViewModel.txtFullName.value,
            validator: (value) => FormValidate.requiredField(value, StringConstants.fullName),
          ),
          const Gap(10),
          InfoDisplayEditWidget(
            title: StringConstants.email,
            controller: workshopEventViewModel.txtEmail.value,
            validator: (value) => FormValidate.requiredField(value, StringConstants.email),
          ),
          const Gap(10),
          InfoDisplayEditWidget(
            title: StringConstants.phoneNumber,
            controller: workshopEventViewModel.txtPhone.value,
            validator: (value) => FormValidate.requiredField(value, StringConstants.phoneNumber),
          ),
          const Gap(10),
          InfoDisplayEditWidget(
            title: StringConstants.street,
            controller: workshopEventViewModel.txtStreet.value,
            validator: (value) => FormValidate.requiredField(value, StringConstants.street),
          ),
          const Gap(10),
          InfoDisplayEditWidget(
            title: StringConstants.house,
            controller: workshopEventViewModel.txtHouse.value,
            validator: (value) => FormValidate.requiredField(value, StringConstants.house),
          ),
          const Gap(10),
          InfoDisplayEditWidget(
            title: StringConstants.apartment,
            controller: workshopEventViewModel.txtApartment.value,
            validator: (value) => FormValidate.requiredField(value, StringConstants.apartment),
          ),
          const Gap(10),
          InfoDisplayEditWidget(
            title: StringConstants.postalCode,
            controller: workshopEventViewModel.txtZipcode.value,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) => FormValidate.requiredField(value, StringConstants.postalCode),
          ),
          const Gap(10),
          Obx(
            () => InfoDisplayEditDropdownWidget(
              dropdownItems: DefaultList.cityList,
              title: StringConstants.city,
              onChanged: (value) {
                workshopEventViewModel.txtCity.value = value ?? DefaultList.cityList.first;
              },
              value: workshopEventViewModel.txtCity.value.isNotEmpty
                  ? workshopEventViewModel.txtCity.value
                  : null,
            ),
          ),
          const Gap(20),
          widget.data != null
              ? SimpleButton(
                  width: 100.w,
                  text: StringConstants.registration,
                  onPressed: () async {
                    var isSuccess = await workshopEventViewModel.updateWorkshopEvent(
                      event: widget.data,
                    );
                    if (isSuccess && context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
