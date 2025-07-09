import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/components/custom_appbar.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text_field.dart';
import 'package:revalesuva/model/trainer/home/customer_model.dart' as customer_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/view_models/making_contact/trainer_chat_view_model.dart';
import 'package:revalesuva/view_models/user_view_model.dart';
import 'package:revalesuva/views/making_contact/trainer_chat/widget/receiver_widget.dart';
import 'package:revalesuva/views/making_contact/trainer_chat/widget/sender_widget.dart';
import 'package:revalesuva/views/trainer/widget/drawer_widget.dart';

class CustomerChatView extends StatefulWidget {
  const CustomerChatView({super.key, required this.data});

  final customer_model.Datum data;

  @override
  State<CustomerChatView> createState() => _CustomerChatViewState();
}

class _CustomerChatViewState extends State<CustomerChatView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TrainerChatViewModel trainerChatViewModel = Get.put(TrainerChatViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        trainerChatViewModel.isShowLoading.value = true;
        await trainerChatViewModel.onChatInit(
          trainerId: "${Get.find<UserViewModel>().userData.value.id ?? ""}",
          customerId: "${widget.data.id ?? ""}",
        );
        trainerChatViewModel.isShowLoading.value = false;
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(color: AppColors.surfaceGreen),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: CustomTextField(
                hint: "Message",
                controller: trainerChatViewModel.txtMessage,
                maxLine: 5,
                minLine: 1,
              ),
            ),
            const Gap(10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.iconTertiary,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 3),
                child: CustomClick(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (trainerChatViewModel.txtMessage.text.isNotEmpty) {
                      trainerChatViewModel.sendMessage(
                        receiverId: "${widget.data.id ?? ""}",
                        senderId: "${Get.find<UserViewModel>().userData.value.id ?? ""}",
                      );
                    }
                  },
                  child: Icon(
                    Icons.send,
                    size: 18,
                    textDirection:
                        Get.locale?.languageCode == "he" ? TextDirection.rtl : TextDirection.ltr,
                    color: AppColors.iconGreen,
                  ),
                ),
              ),
            ),
            // const Gap(10),
            // const ImageIcon(
            //   AssetImage(
            //     Assets.iconsIcMic,
            //   ),
            //   color: AppColors.iconTertiary,
            // ),
            // const Gap(10),
            // const ImageIcon(
            //   AssetImage(
            //     Assets.iconsIcCamera,
            //   ),
            //   color: AppColors.iconTertiary,
            // ),
          ],
        ),
      ),
      body: Obx(
        () => trainerChatViewModel.isShowLoading.value
            ? Center(
                child: SizedBox(
                  width: 100.w,
                  height: 40.h,
                  child: const CupertinoActivityIndicator(radius: 20),
                ),
              )
            : StreamBuilder(
                stream: trainerChatViewModel.dbRef.child('message').orderByChild('timestamp').onValue,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 100.w,
                        height: 40.h,
                        child: const CupertinoActivityIndicator(radius: 20),
                      ),
                    );
                  } else {
                    if (snapshot.data!.snapshot.value != null) {
                      var messages =
                          (snapshot.data!.snapshot.value as Map<dynamic, dynamic>).values.toList();
                      jsonEncode(messages);
                      messages.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        await Future.delayed(const Duration(seconds: 1));
                        trainerChatViewModel.scrollToBottom();
                      });
                      return ListView.separated(
                        controller: trainerChatViewModel.scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                        reverse: false,
                        itemBuilder: (context, index) {
                          var message = messages[index];
                          bool isSender = message['senderId'] ==
                              Get.find<UserViewModel>().userData.value.id.toString();
                          if (isSender) {
                            return SenderWidget(
                              message: message,
                            );
                          } else {
                            return ReceiverWidget(
                              message: message,
                              receiverName: widget.data.name ?? "",
                            );
                          }
                        },
                        separatorBuilder: (context, index) {
                          return const Gap(20);
                        },
                        itemCount: messages.length,
                      );
                    } else {
                      return const SizedBox();
                    }
                  }
                },
              ),
      ),
    );
  }
}
