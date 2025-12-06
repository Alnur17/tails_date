class MessageBodyModel {
  MessageBodyModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory MessageBodyModel.fromJson(Map<String, dynamic> json){
    return MessageBodyModel(
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

  final List<MessageBodyDatum> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<MessageBodyDatum>.from(json["data"]!.map((x) => MessageBodyDatum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

}

class MessageBodyDatum {
  MessageBodyDatum({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.chat,
    required this.text,
    required this.seen,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? sender;
  final String? receiver;
  final String? chat;
  final String? text;
  final bool? seen;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory MessageBodyDatum.fromJson(Map<String, dynamic> json){
    return MessageBodyDatum(
      id: json["_id"],
      sender: json["sender"],
      receiver: json["receiver"],
      chat: json["chat"],
      text: json["text"],
      seen: json["seen"],
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
