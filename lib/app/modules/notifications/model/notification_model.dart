class NotificationModel {
  NotificationModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json){
    return NotificationModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.data,
    required this.meta,
  });

  final List<NotificationDatum> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<NotificationDatum>.from(json["data"]!.map((x) => NotificationDatum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

}

class NotificationDatum {
  NotificationDatum({
    required this.id,
    required this.receiver,
    required this.title,
    required this.type,
    required this.body,
    required this.image,
    required this.hasRead,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? receiver;
  final String? title;
  final String? type;
  final String? body;
  final dynamic image;
  final bool? hasRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory NotificationDatum.fromJson(Map<String, dynamic> json){
    return NotificationDatum(
      id: json["_id"],
      receiver: json["receiver"],
      title: json["title"],
      type: json["type"],
      body: json["body"],
      image: json["image"],
      hasRead: json["has_read"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class Meta {
  Meta({
    required this.total,
  });

  final int? total;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      total: json["total"],
    );
  }

}
