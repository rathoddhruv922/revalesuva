// To parse this JSON data, do
//
//     final sendMessage = sendMessageFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'send_message.g.dart';

SendMessage sendMessageFromJson(String str) => SendMessage.fromJson(json.decode(str));

String sendMessageToJson(SendMessage data) => json.encode(data.toJson());

@JsonSerializable()
class SendMessage {
  @JsonKey(name: "messageId")
  String? messageId;
  @JsonKey(name: "senderId")
  String? senderId;
  @JsonKey(name: "receiverId")
  String? receiverId;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "timestamp")
  String? timestamp;

  SendMessage({
    this.messageId,
    this.senderId,
    this.receiverId,
    this.message,
    this.timestamp,
  });

  factory SendMessage.fromJson(Map<String, dynamic> json) => _$SendMessageFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageToJson(this);
}
