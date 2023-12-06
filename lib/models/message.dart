import 'dart:typed_data';

import 'package:home_work/data/data_storage_impl.dart';

class Message {
  int? id;
  String? text;
  Uint8List? image;
  String time;
  String? messageCategory;
  int chatId;
  String date;

  Message({
    required this.chatId,
    required this.time,
    required this.date,
    this.id,
    this.text,
    this.image,
    this.messageCategory,
  });

  Message copyWith({
    int? id,
    int? chatId,
    String? text,
    String? time,
    String? date,
    String? messageCategory,
    Uint8List? image,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      text: text ?? this.text,
      time: time ?? this.time,
      image: image ?? this.image,
      date: date ?? this.date,
      messageCategory: messageCategory ?? this.messageCategory,
    );
  }

  static Message fromJson(Map<String, Object?> json) {
    return Message(
      id: json[MessageFields.id] as int,
      chatId: json[MessageFields.chatId] as int,
      text: json[MessageFields.text] as String?,
      time: json[MessageFields.time] as String,
      date: json[MessageFields.date] as String,
      messageCategory: json[MessageFields.messageCategory] as String?,
      image: json[MessageFields.image] as Uint8List?,
    );
  }

  Map<String, Object?> toJson() => {
        MessageFields.id: id,
        MessageFields.text: text,
        MessageFields.image: image,
        MessageFields.time: time,
        MessageFields.messageCategory: messageCategory,
        MessageFields.chatId: chatId,
        MessageFields.date: date,
      };
}
