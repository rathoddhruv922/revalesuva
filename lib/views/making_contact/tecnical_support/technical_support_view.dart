part of '../contact_us_list_view.dart';

class TechnicalSupportView extends StatefulWidget {
  const TechnicalSupportView({super.key});

  @override
  State<TechnicalSupportView> createState() => _TechnicalSupportViewState();
}

class _TechnicalSupportViewState extends State<TechnicalSupportView> {
  final MakingContactViewModel makingContactViewModel = Get.find<MakingContactViewModel>();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        makingContactViewModel.txtTitle.text = "";
        makingContactViewModel.txtDetail.text = "";
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(widget: const TechnicalSupportView());
      },
      canPop: true,
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomClick(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: TextBodySmall(
                    text: "< ${StringConstants.backTo} ${StringConstants.contactUs}",
                    color: AppColors.textPrimary,
                    letterSpacing: 0,
                  ),
                ),
                const Gap(10),
                TextHeadlineMedium(
                  text: StringConstants.technicalSupport,
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      CustomTextField(
                        hint: StringConstants.iNeedHelpWith,
                        controller: makingContactViewModel.txtTitle,
                        validator: (value) =>
                            FormValidate.requiredField(value, StringConstants.technicalSupport),
                      ),
                      const Gap(20),
                      CustomTextArea(
                        controller: makingContactViewModel.txtDetail,
                        hint: StringConstants.details,
                        validator: (value) => FormValidate.requiredField(
                          value,
                          StringConstants.details,
                        ),
                        maxLine: 8,
                      ),
                      const Gap(20),
                      SimpleButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            makingContactViewModel.callTechnicalSupport(context: context);
                          }
                        },
                        text: StringConstants.send,
                      ),
                      const Gap(60)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
