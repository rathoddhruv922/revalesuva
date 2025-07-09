import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:revalesuva/model/trainer_chat/send_message.dart';

class TrainerChatViewModel extends GetxController {
  final firebaseApp = FirebaseDatabase.instanceFor(
      app: Firebase.app(), databaseURL: 'https://revalesuva-35295-default-rtdb.firebaseio.com/');
  final txtMessage = TextEditingController();
  DatabaseReference dbRef = FirebaseDatabase.instance.ref("chats");
  var isShowLoading = false.obs;
  final ScrollController scrollController = ScrollController();
  var trainerId = "".obs;
  var customerId = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  onChatInit({required String trainerId, required String customerId}) async {
    this.trainerId.value = trainerId;
    this.customerId.value = customerId;

    dbRef = FirebaseDatabase.instance.ref("chats");
    DataSnapshot snapshot = await dbRef.child('${customerId}_$trainerId').get();
    if (snapshot.value != null) {
      dbRef = dbRef.child('${customerId}_$trainerId').ref;
    } else {
      dbRef.child('${customerId}_$trainerId').set(
        {
          'participants': [customerId, trainerId],
        },
      );
      dbRef = dbRef.child('${customerId}_$trainerId').ref;
    }
  }

  sendMessage({required String receiverId, required String senderId}) async {
    String messageId = FirebaseDatabase.instance.ref().push().key!;
    SendMessage sendMessage = SendMessage(
      messageId: messageId,
      message: txtMessage.text,
      senderId: senderId,
      receiverId: receiverId,
      timestamp: DateTime.now().toIso8601String(),
    );
    dbRef.child('/message/$messageId').set(
          sendMessage.toJson(),
        );
    txtMessage.clear();
    scrollToBottom();
    refresh();
  }
}
