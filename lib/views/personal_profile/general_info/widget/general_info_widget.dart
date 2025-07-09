part of '../general_Information_view.dart';

class GeneralInfoWidget extends StatelessWidget {
  GeneralInfoWidget({super.key});

  final PersonalProfileViewModel personalProfileViewModel = Get.find<PersonalProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Obx(
            () => EditButtonWidget(
              title: personalProfileViewModel.txtName.value.text,
              onTab: () {
                personalProfileViewModel.isGeneralInfoEditable.value = true;
              },
            ),
          ),
          // const Gap(10),
          // Obx(
          //   () => InfoDisplayWidget(
          //     title: StringConstants.username,
          //     value: personalProfileViewModel.txtUserName.value.text,
          //   ),
          // ),
          const Gap(10),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.phoneNumber,
              value: personalProfileViewModel.txtPhoneNo.value.text,
            ),
          ),
          const Gap(10),
          Obx(
                () => InfoDisplayWidget(
              title: StringConstants.dateOfBirth,
              value: personalProfileViewModel.txtDateOfBirth.value.text,
            ),
          ),
          const Gap(10),
          Obx(
                () => InfoDisplayWidget(
              title: StringConstants.gender,
              value: personalProfileViewModel.txtGender.value,
            ),
          ),
          const Gap(10),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.street,
              value: personalProfileViewModel.txtStreet.value.text,
            ),
          ),
          const Gap(10),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.house,
              value: personalProfileViewModel.txtHouse.value.text,
            ),
          ),
          const Gap(10),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.apartment,
              value: personalProfileViewModel.txtApartment.value.text,
            ),
          ),
          const Gap(10),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.postalCode,
              value: personalProfileViewModel.txtPostalCode.value.text,

            ),
          ),
          const Gap(10),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.city,
              value: personalProfileViewModel.txtCity.value,
            ),
          ),
          const Gap(10),
          Obx(
            () => InfoDisplayWidget(
              title: StringConstants.occupation,
              value: personalProfileViewModel.txtOccupation.value.text,
            ),
          ),
        ],
      ),
    );
  }
}
