import 'package:flutter/material.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/weight_and_measuring/chart_model.dart';
import 'package:revalesuva/utils/app_colors.dart';

class DataTableWidget extends StatefulWidget {
  const DataTableWidget({super.key, required this.dataList, required this.title, required this.subTitle});

  final List<ChartModel> dataList;

  final String title;
  final String subTitle;

  @override
  State<DataTableWidget> createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: TableBorder.all(color: AppColors.borderTertiary),
          //  decoration:  BoxDecoration(color: AppColors.surfacePurple.withOpacity(0.7)),
          headingRowHeight: 30,
          dataRowMinHeight: 30,
          dataRowMaxHeight: 30,
          headingRowColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              return AppColors.surfacePurpleLight;
            },
          ),
          dataRowColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              return AppColors.surfaceTertiary;
            },
          ),
          horizontalMargin: 10,
          columnSpacing: 10,
          columns: [
            DataColumn(
              headingRowAlignment: MainAxisAlignment.center,
              label: TextTitleSmall(
                text: widget.title,
              ),
            ),
            ...widget.dataList.map(
              (data) => DataColumn(
                headingRowAlignment: MainAxisAlignment.center,
                label: TextTitleSmall(
                  text: data.date ??"",
                ),
              ),
            ),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(
                  Center(
                    child: TextBodySmall(
                      text: widget.subTitle,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                ...widget.dataList.map(
                  (data) => DataCell(
                    Center(
                      child: TextBodySmall(
                        text: "${data.value}",
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
