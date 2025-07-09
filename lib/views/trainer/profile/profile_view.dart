import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_button.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/app_validator.dart';
import 'package:revalesuva/utils/default_list.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/trainer/trainer_home_view_model.dart';
import 'package:revalesuva/views/common_widget/profile_picture.dart';
import 'package:revalesuva/views/personal_profile/widget/info_display_edit_dropdown_widget.dart';
import 'package:revalesuva/views/personal_profile/widget/info_display_edit_widget.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TrainerHomeViewModel homeViewModel = Get.find<TrainerHomeViewModel>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        homeViewModel.setupUserInfo();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBarTrainer(
        key: scaffoldKey,
      ),
      drawer: DrawerWidget(
        drawerKey: scaffoldKey,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomClick(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: TextBodySmall(
                  text: "< ${StringConstants.backTo} ${StringConstants.personalProfile}",
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
              ),
              const Gap(10),
              const Align(
                alignment: Alignment.center,
                child: ProfilePicture(),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceTertiary,
                        borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(
                            AppCorner.editCard,
                          ),
                          topEnd: Radius.circular(
                            AppCorner.editCard,
                          ),
                        ),
                      ),
                      child: Column(
                        textDirection:
                            Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
                        children: [
                          InfoDisplayEditWidget(
                            title: StringConstants.fullName,
                            controller: homeViewModel.txtName.value,
                            validator: (value) => FormValidate.requiredField(
                              value,
                              StringConstants.fullName,
                            ),
                          ),
                          const Gap(10),
                          InfoDisplayEditWidget(
                            title: StringConstants.phoneNumber,
                            controller: homeViewModel.txtPhoneNo.value,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            textInputType: TextInputType.number,
                            validator: (value) =>
                                FormValidate.requiredField(value, StringConstants.phoneNumber),
                          ),
                          const Gap(10),
                          InfoDisplayEditWidget(
                            title: StringConstants.street,
                            controller: homeViewModel.txtStreet.value,
                            validator: (value) =>
                                FormValidate.requiredField(value, StringConstants.street),
                          ),
                          const Gap(10),
                          InfoDisplayEditWidget(
                            title: StringConstants.house,
                            controller: homeViewModel.txtHouse.value,
                            validator: (value) =>
                                FormValidate.requiredField(value, StringConstants.house),
                          ),
                          const Gap(10),
                          InfoDisplayEditWidget(
                            title: StringConstants.apartment,
                            controller: homeViewModel.txtApartment.value,
                            validator: (value) =>
                                FormValidate.requiredField(value, StringConstants.apartment),
                          ),
                          const Gap(10),
                          InfoDisplayEditWidget(
                            title: StringConstants.postalCode,
                            controller: homeViewModel.txtPostalCode.value,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            textInputType: TextInputType.number,
                            // validator: (value) =>
                            //     FormValidate.requiredField(value, StringConstants.postalCode),
                          ),
                          const Gap(10),
                          Obx(
                            () => InfoDisplayEditDropdownWidget(
                              dropdownItems: DefaultList.ganderList,
                              title: StringConstants.gender,
                              onChanged: (value) {
                                homeViewModel.txtGender.value = value ?? DefaultList.ganderList.first;
                              },
                              value: homeViewModel.txtGender.value.isNotEmpty
                                  ? homeViewModel.txtGender.value
                                  : null,
                            ),
                          ),
                          const Gap(10),
                          Obx(
                            () => InfoDisplayEditDropdownWidget(
                              dropdownItems: DefaultList.cityList,
                              title: StringConstants.city,
                              onChanged: (value) {
                                homeViewModel.txtCity.value = value ?? DefaultList.cityList.first;
                              },
                              value: homeViewModel.txtCity.value.isNotEmpty
                                  ? homeViewModel.txtCity.value
                                  : null,
                            ),
                          ),
                          const Gap(10),
                          InfoDisplayEditWidget(
                            title: StringConstants.occupation,
                            controller: homeViewModel.txtOccupation.value,
                            validator: (value) =>
                                FormValidate.requiredField(value, StringConstants.occupation),
                          ),
                          const Gap(20),
                          SimpleButton(
                            text: StringConstants.saveChanges,
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                homeViewModel.updateGeneralInfo();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
