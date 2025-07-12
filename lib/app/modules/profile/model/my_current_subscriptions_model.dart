class MyCurrentSubscriptionModel {
  MyCurrentSubscriptionModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory MyCurrentSubscriptionModel.fromJson(Map<String, dynamic> json){
    return MyCurrentSubscriptionModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.user,
    required this.v,
    required this.createdAt,
    required this.endDate,
    required this.plan,
    required this.startDate,
    required this.status,
    required this.updatedAt,
  });

  final String? id;
  final String? user;
  final int? v;
  final DateTime? createdAt;
  final DateTime? endDate;
  final String? plan;
  final DateTime? startDate;
  final String? status;
  final DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      user: json["user"],
      v: json["__v"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      plan: json["plan"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      status: json["status"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
