// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:myapp/src/network/data/notification/notification_repository_mock.dart';

class NotificationModel {
  TypeNotify type;
  dynamic data;
  NotificationModel({
    required this.type,
    required this.data,
  });

  NotificationModel copyWith({
    TypeNotify? type,
    dynamic data,
  }) {
    return NotificationModel(
      type: type ?? this.type,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name.toString(),
      'data': data,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      type: _getTypeNotifyFromString(map['status']),
      data: map['data'] as dynamic,
    );
  }

  static TypeNotify _getTypeNotifyFromString(String typeNotifyString) {
    switch (typeNotifyString) {
      case 'changeEvent':
        return TypeNotify.changeEvent;
      case 'followEvent':
        return TypeNotify.followEvent;
      case 'followUser':
        return TypeNotify.followUser;
      case 'upcomingEvent':
        return TypeNotify.upcomingEvent;
      default:
        throw ArgumentError('Unknown status: $typeNotifyString');
    }
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.type == type && other.data == data;
  }

  @override
  int get hashCode => type.hashCode ^ data.hashCode;
}
