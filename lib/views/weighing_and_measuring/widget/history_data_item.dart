import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_dropdown.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/weight_and_measuring/chart_model.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/helper_method.dart';
import 'package:revalesuva/views/weighing_and_measuring/widget/chart_widget.dart';
import 'package:revalesuva/views/weighing_and_measuring/widget/data_table_widget.dart';

class HistoryDataItem extends StatelessWidget {
  const HistoryDataItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isChartShow,
    required this.firstLabel,
    required this.firstValue,
    required this.lastLabel,
    required this.lastValue,
    required this.message,
    required this.selectedValue,
    this.onChanged,
    required this.onTapChart,
    required this.onTabTable,
    required this.dataList, required this.dropDownList,
  });

  final String title;
  final String icon;
  final bool isChartShow;
  final String firstLabel;
  final String firstValue;
  final String lastLabel;
  final String lastValue;
  final String message;
  final String selectedValue;
  final ValueChanged<String?>? onChanged;
  final Function() onTapChart;
  final Function() onTabTable;
  final List<ChartModel> dataList;
  final List<String> dropDownList;

  @override
  Widget build(BuildContext context) {
    return CustomCard2(
      color: AppColors.surfaceTertiary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageIcon(
                AssetImage(icon),
                size: 20,
              ),
              const Gap(10),
              TextTitleMedium(text: title),
              const Spacer(),
              CustomClick(
                onTap: onTabTable,
                child: Image.asset(
                  isChartShow ? Assets.iconsIcTableUnselected : Assets.iconsIcTableSelected,
                  width: 25,
                ),
              ),
              const Gap(10),
              CustomClick(
                onTap: onTapChart,
                child: Image.asset(
                  isChartShow ? Assets.iconsIcGraphSelected : Assets.iconsIcGraphUnselected,
                  width: 25,
                ),
              ),
            ],
          ),
          const Gap(10),
          getFirstLastLabel(
            title: firstLabel,
            value: firstValue,
          ),
          const Gap(10),
          getFirstLastLabel(
            title: lastLabel,
            value: lastValue,
          ),
          const Gap(10),
          TextBodySmall(
            text: message,
            color: AppColors.textPrimary,
          ),
          isChartShow
              ? ChartWidget(
                  dataList: dataList,
                )
              : DataTableWidget(
                  dataList: dataList,
                  title: "Date",
                  subTitle: "Weight",
                ),
          SizedBox(
            width: 30.w,
            height: 30,
            child: SimpleDropdownButton(
              buttonPadding: const EdgeInsetsDirectional.only(start: 10, end: 5),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppCorner.button),
                color: AppColors.surfacePurpleLight,
              ),
              hint: "",
              value: selectedValue.isNotEmpty ? selectedValue : null,
              dropdownItems: dropDownList,
              onChanged: onChanged,
            ),
          )
        ],
      ),
    );
  }

  Widget getFirstLastLabel({required String title, required String value}) {
    return Row(
      children: [
        Flexible(
          child: TextBodyMedium(
            text: title,
            color: AppColors.textPrimary,
          ),
        ),
        const Gap(10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.surfacePurpleLight.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(AppCorner.button),
          ),
          child: TextHeadlineSmall(text: value),
        ),
      ],
    );
  }
}
