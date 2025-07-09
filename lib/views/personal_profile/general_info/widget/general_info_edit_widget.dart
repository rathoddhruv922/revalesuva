part of '../general_Information_view.dart';

class GeneralInfoEditWidget extends StatelessWidget {
  GeneralInfoEditWidget({super.key});

  final PersonalProfileViewModel personalProfileViewModel = Get.find<PersonalProfileViewModel>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        personalProfileViewModel.isGeneralInfoEditable.value = false;
      },
      child: Form(
        key: formKey,
        child: Column(
          textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.end,
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
                textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
                children: [
                  InfoDisplayEditWidget(
                    title: StringConstants.fullName,
                    controller: personalProfileViewModel.txtName.value,
                    validator: (value) => FormValidate.requiredField(value, StringConstants.fullName),
                  ),
                  const Gap(10),
                  InfoDisplayEditWidget(
                    title: StringConstants.phoneNumber,
                    controller: personalProfileViewModel.txtPhoneNo.value,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    validator: (value) => FormValidate.requiredField(value, StringConstants.phoneNumber),
                  ),
                  const Gap(10),
                  CustomClick(
                    onTap: () {
                      Get.bottomSheet(
                        isScrollControlled: true,
                        ignoreSafeArea: false,
                        CustomBottomSheet(
                          bottomSheetTitle: StringConstants.dateOfBirth,
                          onDone: () {
                            if (personalProfileViewModel.txtDateOfBirth.value.text.isEmpty) {
                              personalProfileViewModel.txtDateOfBirth.value.text = changeDateStringFormat(
                                  date: DateTime(DateTime.now().year - 5).toString(),
                                  format: DateFormatHelper.ymdFormat);
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
                                initialDateTime: DateTime.tryParse(
                                    personalProfileViewModel.txtDateOfBirth.value.text) ??
                                    DateTime(DateTime.now().year - 5),
                                minimumDate: DateTime(DateTime.now().year - 100),
                                maximumDate: DateTime(DateTime.now().year - 5),
                                showDayOfWeek: true,
                                onDateTimeChanged: (DateTime newDate) {
                                  personalProfileViewModel.txtDateOfBirth.value.text =
                                      changeDateStringFormat(
                                          date: newDate.toString(), format: DateFormatHelper.ymdFormat);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: InfoDisplayEditWidget(
                      title: StringConstants.dateOfBirth,
                      enabled: false,
                      controller: personalProfileViewModel.txtDateOfBirth.value,
                    ),
                  ),
                  const Gap(10),
                  Obx(
                        () => InfoDisplayEditDropdownWidget(
                      dropdownItems: DefaultList.ganderList,
                      title: StringConstants.gender,
                      onChanged: (value) {
                        personalProfileViewModel.txtGender.value = value ?? DefaultList.ganderList.first;
                      },
                      value: personalProfileViewModel.txtGender.value.isNotEmpty
                          ? personalProfileViewModel.txtGender.value
                          : null,
                    ),
                  ),
                  const Gap(10),
                  InfoDisplayEditWidget(
                    title: StringConstants.street,
                    controller: personalProfileViewModel.txtStreet.value,
                    validator: (value) => FormValidate.requiredField(value, StringConstants.street),
                  ),
                  const Gap(10),
                  InfoDisplayEditWidget(
                    title: StringConstants.house,
                    controller: personalProfileViewModel.txtHouse.value,
                    validator: (value) => FormValidate.requiredField(value, StringConstants.house),
                  ),
                  const Gap(10),
                  InfoDisplayEditWidget(
                    title: StringConstants.apartment,
                    controller: personalProfileViewModel.txtApartment.value,
                    // validator: (value) => FormValidate.requiredField(value, StringConstants.apartment),
                  ),
                  const Gap(10),
                  InfoDisplayEditWidget(
                    title: StringConstants.postalCode,
                    controller: personalProfileViewModel.txtPostalCode.value,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    // validator: (value) => FormValidate.requiredField(value, StringConstants.postalCode),
                  ),
                  /*  const Gap(10),
                  Obx(
                    () => SimpleDropdownButton(
                      hint: StringConstants.city,
                      value:
                          personalProfileViewModel.txtCity.value.isNotEmpty ? personalProfileViewModel.txtCity.value : null,
                      dropdownItems: DefaultList.cityList,
                      onChanged: (String? value) {
                        if (value != null) {
                          personalProfileViewModel.txtCity.value = value;
                        }
                      },
                    ),
                  ),*/
                  const Gap(10),
                  Obx(
                    () => InfoDisplayEditDropdownWidget(
                      dropdownItems: DefaultList.cityList,
                      title: StringConstants.city,
                      onChanged: (value) {
                        personalProfileViewModel.txtCity.value = value ?? DefaultList.cityList.first;
                      },
                      value: personalProfileViewModel.txtCity.value.isNotEmpty ? personalProfileViewModel.txtCity.value : null,
                    ),
                  ),
                  const Gap(10),
                  InfoDisplayEditWidget(
                    title: StringConstants.occupation,
                    controller: personalProfileViewModel.txtOccupation.value,
                    validator: (value) => FormValidate.requiredField(value, StringConstants.occupation),
                  ),
                ],
              ),
            ),
            const Gap(20),
            SimpleButton(
              text: StringConstants.saveChanges,
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  personalProfileViewModel.updateGeneralInfo();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
