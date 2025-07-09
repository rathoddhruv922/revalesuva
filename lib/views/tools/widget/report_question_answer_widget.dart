import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_radio_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/medical_question/create_user_answer_model.dart' as create_user_answer_model;
import 'package:revalesuva/model/medical_question/question_model.dart' as question_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/views/personal_profile/widget/info_display_edit_widget.dart';

class ReportQuestionAnswerWidget extends StatefulWidget {
  const ReportQuestionAnswerWidget({
    super.key,
    required this.question,
    this.answer,
    required this.index,
    required this.onChange,
    required this.onTextChange,
  });

  final question_model.Datum question;
  final create_user_answer_model.Answer? answer;
  final int index;
  final Function(String? value, String subAns, int index) onChange;
  final Function(String? value) onTextChange;

  @override
  State<ReportQuestionAnswerWidget> createState() => _ReportQuestionAnswerWidgetState();
}

class _ReportQuestionAnswerWidgetState extends State<ReportQuestionAnswerWidget> {
  late TextEditingController subAns;

  @override
  void initState() {
    super.initState();
    subAns = TextEditingController(text: widget.answer?.subAnswer ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.index != 0
            ? const Divider(
                height: 30,
              )
            : const Gap(10),
        TextTitleSmall(
          text: "${widget.index + 1}. ${widget.question.question}",
          textAlign: TextAlign.start,
        ),
        getOptionByType(),
      ],
    );
  }

  Widget getOptionByType() {
    //
    switch (widget.question.answerType ?? "") {
      case "input_box":
        {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: InfoDisplayEditWidget(
              title: StringConstants.details,
              controller: subAns,
              onChange: widget.onTextChange,
            ),
          );
        }
      case "yes_with_input":
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    child: CustomRadioButton(
                      text: StringConstants.yes,
                      value: "yes",
                      groupValue: widget.answer?.answer,
                      onChanged: (value) => widget.onChange(
                        value,
                        subAns.text,
                        widget.index,
                      ),
                    ),
                  ),
                  Flexible(
                    child: CustomRadioButton(
                      text: StringConstants.no,
                      value: "no",
                      groupValue: widget.answer?.answer,
                      onChanged: (value) => widget.onChange(
                        value,
                        "",
                        widget.index,
                      ),
                    ),
                  ),
                ],
              ),
              (widget.answer?.answerType == "yes_with_input" && widget.answer?.answer == "yes")
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: InfoDisplayEditWidget(
                        title: StringConstants.details,
                        controller: subAns,
                        onChange: widget.onTextChange,
                      ),
                    )
                  : const SizedBox()
            ],
          );
        }
      case "no_with_input":
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    child: CustomRadioButton(
                      text: StringConstants.yes,
                      value: "yes",
                      groupValue: widget.answer?.answer,
                      onChanged: (value) => widget.onChange(value, "", widget.index),
                    ),
                  ),
                  Flexible(
                    child: CustomRadioButton(
                      text: StringConstants.no,
                      value: "no",
                      groupValue: widget.answer?.answer,
                      onChanged: (value) => widget.onChange(
                        value,
                        subAns.text,
                        widget.index,
                      ),
                    ),
                  ),
                ],
              ),
              (widget.answer?.answerType == "no_with_input" && widget.answer?.answer == "no")
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: InfoDisplayEditWidget(
                        title: StringConstants.details,
                        controller: subAns,
                        onChange: widget.onTextChange,
                      ),
                    )
                  : const SizedBox()
            ],
          );
        }
      case "yes_no":
        {
          return Row(
            children: [
              Flexible(
                child: CustomRadioButton(
                  text: StringConstants.yes,
                  value: "yes",
                  groupValue: widget.answer?.answer,
                  onChanged: (value) => widget.onChange(value, subAns.text, widget.index),
                ),
              ),
              Flexible(
                child: CustomRadioButton(
                  text: StringConstants.no,
                  value: "no",
                  groupValue: widget.answer?.answer,
                  onChanged: (value) => widget.onChange(value, subAns.text, widget.index),
                ),
              ),
            ],
          );
        }
      case "mcq":
        {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CustomRadioButton(
                text: widget.question.mcqOptions?[index].options ?? "",
                value: widget.question.mcqOptions?[index].options ?? "",
                groupValue: widget.answer?.answer,
                onChanged: (value) => widget.onChange(value, subAns.text, widget.index),
              );
            },
            itemCount: widget.question.mcqOptions?.length ?? 0,
          );
        }
      case "rating7":
        {
          int numbers = 7;
          return Column(
            children: [
              const Gap(10),
              Row(
                children: List.generate(numbers, (index) {
                  var value = numbers - index;
                  return Expanded(
                    child: CustomClick(
                      onTap: () => widget.onChange(
                        value.toString(),
                        value.toString(),
                        widget.index,
                      ),
                      child: Container(
                        height: 25,
                        width: 25,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (widget.answer?.answer == value.toString()) ? AppColors.surfaceBrand : AppColors.surfaceTertiary,
                          border: Border.all(
                            color: AppColors.borderPrimary,
                          ),
                        ),
                        child: TextTitleMedium(
                          text: value.toString(),
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const Gap(10),
              Row(
                children: [
                  TextBodySmall(
                    text: StringConstants.very,
                    color: AppColors.textPrimary,
                  ),
                  const Spacer(),
                  TextBodySmall(
                    text: StringConstants.notAtAll,
                    color: AppColors.textPrimary,
                  ),
                ],
              )
            ],
          );
        }
      case "rating3+":
        {
          int numbers = 3;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              Row(
                children: List.generate(
                  numbers + 1,
                  (index) {
                    int value = numbers - index;
                    return CustomClick(
                      onTap: () => widget.onChange(
                        index == 0 ? "+$value" : "${value + 1}",
                        index == 0 ? "+$value" : "${value + 1}",
                        widget.index,
                      ),
                      child: index == 0
                          ? Container(
                              height: 25,
                              width: 25,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (widget.answer?.answer == "+${value.toString()}")
                                    ? AppColors.surfaceBrand
                                    : AppColors.surfaceTertiary,
                                border: Border.all(
                                  color: AppColors.borderPrimary,
                                ),
                              ),
                              child: TextTitleMedium(
                                text: "+$value",
                                color: AppColors.textPrimary,
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (widget.answer?.answer == value.toString())
                                    ? AppColors.surfaceBrand
                                    : AppColors.surfaceTertiary,
                                border: Border.all(
                                  color: AppColors.borderPrimary,
                                ),
                              ),
                              child: TextTitleMedium(
                                text: "${value + 1}",
                                color: AppColors.textPrimary,
                              ),
                            ),
                    );
                  },
                ),
              ),
              const Gap(10),
              TextBodySmall(
                text: "${StringConstants.moreThan}$numbers",
                color: AppColors.textPrimary,
              ),
            ],
          );
        }
      default:
        {
          return const SizedBox();
        }
    }
  }
}
