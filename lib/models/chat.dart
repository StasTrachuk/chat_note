import 'package:home_work/data/data_storage_impl.dart';

class Chat {
  int? id;
  String icon;
  String title;

  Chat({
    this.id,
    required this.icon,
    required this.title,
  });

  Chat copyWith({
    int? id,
    String? icon,
    String? title,
  }) {
    return Chat(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
    );
  }

  Map<String, Object?> toJson() => {
        ChatFields.id: id,
        ChatFields.title: title,
        ChatFields.icon: icon,
      };

  static Chat fromJson(Map<String, Object?> json) {
    return Chat(
      id: json[ChatFields.id] as int,
      icon: json[ChatFields.icon] as String,
      title: json[ChatFields.title] as String,
    );
  }
}
