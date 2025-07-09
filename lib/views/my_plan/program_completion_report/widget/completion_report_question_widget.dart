import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_radio_button.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/model/my_plan/program_completion_report/program_question_model.dart'
    as program_question_model;
import 'package:revalesuva/utils/strings_constant.dart';

class CompletionReportQuestionWidget extends StatefulWidget {
  const CompletionReportQuestionWidget({
    super.key,
    required this.question,
    required this.index,
    required this.onChange,
    required this.onTextChange,
    required this.subAns,
  });

  final program_question_model.Datum question;
  final int index;
  final Function(String? value, String subAns, int index) onChange;
  final Function(String? value) onTextChange;
  final String subAns;

  @override
  State<CompletionReportQuestionWidget> createState() => _CompletionReportQuestionWidgetState();
}

class _CompletionReportQuestionWidgetState extends State<CompletionReportQuestionWidget> {
   TextEditingController subAns = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextTitleMedium(
          text: "${widget.index + 1}. ${widget.question.question1}",
          textAlign: TextAlign.start,
        ),
        const Gap(20),
        getOptionByType(),
      ],
    );
  }

  Widget getOptionByType() {
    subAns.text = widget.subAns;
    switch (widget.question.answerType ?? "") {
      case "input_box":
        {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: CustomTextField(
              controller: subAns,
              hint: StringConstants.details,
              onChange: widget.onTextChange,
              maxLine: 2,
              minLine: 2,
            ),
          );
        }
      case "text_area":
        {
          return CustomTextField(
            controller: subAns,
            hint: StringConstants.details,
            onChange: widget.onTextChange,
            maxLine: 8,
            minLine: 8,
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
                      groupValue: widget.question.tempAns,
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
                      groupValue: widget.question.tempAns,
                      onChanged: (value) => widget.onChange(
                        value,
                        "",
                        widget.index,
                      ),
                    ),
                  ),
                ],
              ),
              (widget.question.answerType == "yes_with_input" && widget.question.tempAns == "yes")
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: CustomTextField(
                        controller: subAns,
                        hint: StringConstants.details,
                        onChange: widget.onTextChange,
                        maxLine: 2,
                        minLine: 2,
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
                      groupValue: widget.question.tempAns,
                      onChanged: (value) => widget.onChange(value, "", widget.index),
                    ),
                  ),
                  Flexible(
                    child: CustomRadioButton(
                      text: StringConstants.no,
                      value: "no",
                      groupValue: widget.question.tempAns,
                      onChanged: (value) => widget.onChange(
                        value,
                        subAns.text,
                        widget.index,
                      ),
                    ),
                  ),
                ],
              ),
              (widget.question.answerType == "no_with_input" && widget.question.tempAns == "no")
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: CustomTextField(
                        controller: subAns,
                        hint: StringConstants.details,
                        onChange: widget.onTextChange,
                        maxLine: 2,
                        minLine: 2,
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
                  groupValue: widget.question.tempAns,
                  onChanged: (value) => widget.onChange(value, subAns.text, widget.index),
                ),
              ),
              Flexible(
                child: CustomRadioButton(
                  text: StringConstants.no,
                  value: "no",
                  groupValue: widget.question.tempAns,
                  onChanged: (value) => widget.onChange(value, subAns.text, widget.index),
                ),
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
