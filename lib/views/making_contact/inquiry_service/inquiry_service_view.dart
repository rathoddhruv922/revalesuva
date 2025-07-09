part of '../contact_us_list_view.dart';

class InquiryServiceView extends StatefulWidget {
  const InquiryServiceView({super.key});

  @override
  State<InquiryServiceView> createState() => _InquiryServiceViewState();
}

class _InquiryServiceViewState extends State<InquiryServiceView> {
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
        NavigationHelper.onBackScreen(widget: const InquiryServiceView());
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
                  text: StringConstants.inquiryRegardingService,
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      CustomTextField(
                        controller: makingContactViewModel.txtTitle,
                        hint: StringConstants.iNeedHelpWith,
                        validator: (value) => FormValidate.requiredField(
                          value,
                          StringConstants.iNeedHelpWith,
                        ),
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
                            makingContactViewModel.callInquiryService(context: context);
                          }
                        },
                        text: StringConstants.send,
                      ),
                    ],
                  ),
                ),
                const Gap(60)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
