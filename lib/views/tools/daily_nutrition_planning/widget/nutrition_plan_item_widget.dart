import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';

class NutritionPlanItemWidget extends StatelessWidget {
  const NutritionPlanItemWidget({
    super.key,
    required this.hint,
    required this.onTap,
    required this.status,
    required this.selectedValue,
    required this.onStatusChanged,
  });

  final String hint;
  final Function() onTap;
  final String status;
  final String selectedValue;
  final Function() onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomClick(
            onTap: onTap,
            child: CustomTextField(
              hint: hint,
              enabled: false,
              controller: TextEditingController(text: selectedValue),
              suffixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ImageIcon(
                  AssetImage(
                    Assets.iconsIcDownArrow,
                  ),
                  color: AppColors.iconPrimary,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
        const Gap(10),
        CustomClick(
          onTap: onStatusChanged,
          child: getCheckBoxWithStatus(status: status),
        )
        // Transform.scale(
        //   scale: 2,
        //   child: CheckboxTheme(
        //     data: CheckboxThemeData(
        //       side: BorderSide(
        //         color: status == "pending" || status.isEmpty ? AppColors.lightGray : AppColors.borderGreen,
        //         width: 0.5,
        //       ),
        //       fillColor: WidgetStatePropertyAll(
        //         status == "pending" ? AppColors.lightGray : AppColors.surfaceTertiary,
        //       ),
        //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //     ),
        //     child: Checkbox(
        //       activeColor: AppColors.surfaceGreen,
        //       value: status == "completed" ? true : false,
        //       onChanged: onStatusChanged,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget getCheckBoxWithStatus({required String status}) {
    if (status == "completed") {
      return Image.asset(
        Assets.iconsIcCheckBox,
        width: 35,
      );
    } else if (status == "approved") {
      return Container(
        width: 35,
        height: 35,
        clipBehavior: Clip.hardEdge,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.surfaceGreen, width: 1)),
      );
    } else {
      return Image.asset(
        Assets.iconsIcDisableCheckBox,
        width: 35,
      );
    }
  }
}
