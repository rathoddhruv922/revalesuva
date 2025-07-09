import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/medical_question/user_ans_model.dart' as user_ans_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/strings_constant.dart';

class ReportAnswerItem extends StatelessWidget {
  const ReportAnswerItem({super.key, required this.question, this.answer});

  final String question;
  final user_ans_model.Datum? answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitleSmall(
          text: question,
          maxLine: 10,
        ),
        const Gap(5),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 10),
          child: getOptionByType(answer: answer),
        ),
        const Gap(10),
        const Divider(),
      ],
    );
  }

  Widget getOptionByType({user_ans_model.Datum? answer}) {
    //
    switch (answer?.answerType ?? "") {
      case "input_box":
        {
          return TextBodySmall(
            text: answer?.answer?.capitalize ?? "",
            color: AppColors.textPrimary,
          );
        }
      case "yes_with_input":
        {
          if (answer?.answer == "yes") {
            return TextBodySmall(
              text: "${answer?.answer?.capitalize ?? ""}. ${answer?.subAnswer ?? ""}",
              color: AppColors.textPrimary,
            );
          } else {
            return TextBodySmall(
              text: answer?.answer?.capitalize ?? "",
              color: AppColors.textPrimary,
            );
          }
        }
      case "no_with_input":
        {
          if (answer?.answer == "no") {
            return TextBodySmall(
              text: "${answer?.answer?.capitalize ?? ""}. ${answer?.subAnswer ?? ""}",
              color: AppColors.textPrimary,
            );
          } else {
            return TextBodySmall(
              text: answer?.answer?.capitalize ?? "",
              color: AppColors.textPrimary,
            );
          }
        }
      case "yes_no":
        {
          return TextBodySmall(
            text: answer?.answer?.capitalize ?? "",
            color: AppColors.textPrimary,
          );
        }
      case "mcq":
        {
          return TextBodySmall(
            text: answer?.answer?.capitalize ?? "",
            color: AppColors.textPrimary,
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
                    child: Container(
                      height: 25,
                      width: 25,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (answer?.answer == value.toString()) ? AppColors.surfaceBrand : AppColors.surfaceTertiary,
                        border: Border.all(
                          color: AppColors.borderPrimary,
                        ),
                      ),
                      child: TextTitleMedium(
                        text: value.toString(),
                        color: AppColors.textPrimary,
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
                    return index == 0
                        ? Container(
                            height: 25,
                            width: 25,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  (answer?.answer == "+${value.toString()}") ? AppColors.surfaceBrand : AppColors.surfaceTertiary,
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
                              color: (answer?.answer == "${value + 1}") ? AppColors.surfaceBrand : AppColors.surfaceTertiary,
                              border: Border.all(
                                color: AppColors.borderPrimary,
                              ),
                            ),
                            child: TextTitleMedium(
                              text: "${value + 1}",
                              color: AppColors.textPrimary,
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
          return const TextBodySmall(
            text: "Not Answer found",
            color: AppColors.textPrimary,
          );
        }
    }
  }
}
