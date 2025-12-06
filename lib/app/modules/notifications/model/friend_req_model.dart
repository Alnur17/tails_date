class FriendsReqModel {
  FriendsReqModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory FriendsReqModel.fromJson(Map<String, dynamic> json){
    return FriendsReqModel(
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

  final List<FriendReqDatum> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<FriendReqDatum>.from(json["data"]!.map((x) => FriendReqDatum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

}

class FriendReqDatum {
  FriendReqDatum({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final Receiver? sender;
  final Receiver? receiver;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory FriendReqDatum.fromJson(Map<String, dynamic> json){
    return FriendReqDatum(
      id: json["_id"],
      sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
      receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class Receiver {
  Receiver({
    required this.id,
    required this.email,
    required this.image,
    required this.name,
  });

  final String? id;
  final String? email;
  final String? image;
  final String? name;

  factory Receiver.fromJson(Map<String, dynamic> json){
    return Receiver(
      id: json["_id"],
      email: json["email"],
      image: json["image"],
      name: json["name"],
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
