part of 'personal_details_screen.dart';

class GeneralDetailView extends StatelessWidget {
  GeneralDetailView({super.key});

  final PersonalDetailsViewModel personalDetailsViewModel = Get.find<PersonalDetailsViewModel>();
  final formKeyPersonalDetail3 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyPersonalDetail3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextTitleMedium(text: StringConstants.personalDetail3Title),
            const Gap(20),
            Row(
              textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Expanded(
                  child: Obx(
                    () => SimpleDropdownButton(
                      hint: StringConstants.gender,
                      value:
                          personalDetailsViewModel.txtGender.value.isNotEmpty ? personalDetailsViewModel.txtGender.value : null,
                      dropdownItems: DefaultList.ganderList,
                      onChanged: (String? value) {
                        if (value != null) {
                          personalDetailsViewModel.txtGender.value = value;
                        }
                      },
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: CustomClick(
                    onTap: () {
                      Get.bottomSheet(
                        isScrollControlled: true,
                        ignoreSafeArea: false,
                        CustomBottomSheet(
                          bottomSheetTitle: StringConstants.dateOfBirth,
                          onDone: () {
                            if (personalDetailsViewModel.txtDateOfBirth.text.isEmpty) {
                              personalDetailsViewModel.txtDateOfBirth.text = changeDateStringFormat(
                                  date: DateTime(DateTime.now().year - 5).toString(), format: DateFormatHelper.ymdFormat);
                            }
                            if (Get.isBottomSheetOpen ?? false) {
                              Get.back();
                            }
                          },
                          widget: SizedBox(
                            height: 30.h,
                            child: CupertinoTheme(
                              data: const CupertinoThemeData(brightness: Brightness.light),
                              child: CupertinoDatePicker(
                                dateOrder: DatePickerDateOrder.ymd,
                                itemExtent: 40,
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.tryParse(personalDetailsViewModel.txtDateOfBirth.text) ??
                                    DateTime(DateTime.now().year - 5),
                                minimumDate: DateTime(DateTime.now().year - 100),
                                maximumDate: DateTime(DateTime.now().year - 5),
                                showDayOfWeek: true,
                                onDateTimeChanged: (DateTime newDate) {
                                  personalDetailsViewModel.txtDateOfBirth.text =
                                      changeDateStringFormat(date: newDate.toString(), format: DateFormatHelper.ymdFormat);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: CustomTextField(
                      enabled: false,
                      hint: StringConstants.dateOfBirth,
                      controller: personalDetailsViewModel.txtDateOfBirth,
                      validator: (value) =>
                          FormValidate.requiredField(value, "${StringConstants.dateOfBirth} ${StringConstants.required}"),
                      suffixIcon: const Align(
                        child: ImageIcon(
                          AssetImage(
                            Assets.iconsIcCalendar,
                          ),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
            CustomTextField(
              hint: StringConstants.street,
              controller: personalDetailsViewModel.txtStreet,
              validator: (value) => FormValidate.requiredField(value, StringConstants.street),
            ),
            const Gap(10),
            Row(
              textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Expanded(
                  flex: 7,
                  child: CustomTextField(
                    hint: StringConstants.house,
                    controller: personalDetailsViewModel.txtHouse,
                    validator: (value) => FormValidate.requiredField(value, StringConstants.house),
                  ),
                ),
                const Gap(10),
                Expanded(
                  flex: 7,
                  child: CustomTextField(
                    hint: StringConstants.apartment,
                    controller: personalDetailsViewModel.txtApartment,
                    // validator: (value) => FormValidate.requiredField(value, StringConstants.apartment),
                  ),
                ),
                const Gap(10),
                Expanded(
                  flex: 10,
                  child: CustomTextField(
                    hint: StringConstants.postalCode,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: personalDetailsViewModel.txtZipCode,
                    textInputType: TextInputType.number,
                    // validator: (value) => FormValidate.requiredField(value, StringConstants.postalCode),
                  ),
                ),
              ],
            ),
            const Gap(10),
            Obx(
              () => SimpleDropdownButton(
                hint: StringConstants.city,
                value: personalDetailsViewModel.txtCity.value.isNotEmpty ? personalDetailsViewModel.txtCity.value : null,
                dropdownItems: DefaultList.cityList,
                onChanged: (String? value) {
                  if (value != null) {
                    personalDetailsViewModel.txtCity.value = value;
                  }
                },
              ),
            ),
            const Gap(10),
            Obx(
              () => SimpleDropdownButton(
                hint: StringConstants.personalStatus,
                value: personalDetailsViewModel.txtPersonalStatus.value.isNotEmpty
                    ? personalDetailsViewModel.txtPersonalStatus.value
                    : null,
                dropdownItems: DefaultList.personalStatusList,
                onChanged: (String? value) {
                  if (value != null) {
                    personalDetailsViewModel.txtPersonalStatus.value = value;
                  }
                },
              ),
            ),
            const Gap(10),
            CustomTextField(
              hint: StringConstants.occupation,
              controller: personalDetailsViewModel.txtOccupation,
              validator: (value) => FormValidate.requiredField(value, StringConstants.occupation),
            ),
            const Gap(30),
            Row(
              textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
              children: [
                CustomTextButton(
                  onPressed: () {
                    personalDetailsViewModel.onPreviousStepClick();
                  },
                  text: StringConstants.previousStep,
                  icon: Icons.arrow_back_ios,
                  underline: false,
                ),
                const Spacer(),
                CustomIconButton(
                  onPressed: () {
                    if (formKeyPersonalDetail3.currentState?.validate() ?? false) {
                      if (Get.find<UserViewModel>().userPlanDetail.value.id != null) {
                        personalDetailsViewModel.onNextStepClick();
                      } else {
                        personalDetailsViewModel.updateUserData();
                      }
                    }
                  },
                  text: StringConstants.nextStep,
                  icon: Icons.arrow_forward_ios,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
