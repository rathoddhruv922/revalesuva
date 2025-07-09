import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/trainer/home/customer_model.dart' as customer_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/strings_constant.dart';
import 'package:revalesuva/view_models/trainer/trainer_fasting_calculator_view_model.dart';
import 'package:revalesuva/views/trainer/fasting/widget/customer_fasting_history_item_widget.dart';
import 'package:revalesuva/views/trainer/fasting/widget/customer_fasting_history_table_title.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';

class CustomerFastingHistoryList extends StatefulWidget {
  const CustomerFastingHistoryList({super.key, required this.data});

  final customer_model.Datum data;

  @override
  State<CustomerFastingHistoryList> createState() => _CustomerFastingHistoryListState();
}

class _CustomerFastingHistoryListState extends State<CustomerFastingHistoryList> {
  final TrainerFastingCalculatorViewModel trainerFastingCalculatorViewModel =
      Get.put(TrainerFastingCalculatorViewModel());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        trainerFastingCalculatorViewModel.currentPage.value = 1;
        trainerFastingCalculatorViewModel.total.value = 1;
        await trainerFastingCalculatorViewModel.getHistoryFastingData(
          customerId: "${widget.data.id ?? ""}",
        );
        trainerFastingCalculatorViewModel.setupScrollController(
          customerId: "${widget.data.id ?? ""}",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBarTrainer(
        key: scaffoldKey,
      ),
      drawer: DrawerWidget(
        drawerKey: scaffoldKey,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomClick(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: TextBodySmall(
                text: "< ${StringConstants.backTo} ${StringConstants.customer}",
                color: AppColors.textPrimary,
                letterSpacing: 0,
              ),
            ),
            const Gap(10),
            TextHeadlineMedium(
              text: StringConstants.customerOptions,
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            const Gap(10),
            const CustomerFastingHistoryTableTitle(),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  controller: trainerFastingCalculatorViewModel.scrollController,
                  itemBuilder: (context, index) {
                    return CustomerFastingHistoryItemWidget(
                      data: trainerFastingCalculatorViewModel.listFasting[index],
                    );
                  },
                  itemCount: trainerFastingCalculatorViewModel.listFasting.length,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
