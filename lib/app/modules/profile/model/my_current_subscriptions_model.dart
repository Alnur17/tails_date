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
  final String? endDate;
  final Plan? plan;
  final DateTime? startDate;
  final String? status;
  final DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      user: json["user"],
      v: json["__v"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      endDate: json["end_date"],
      plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      status: json["status"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}

class Plan {
  Plan({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? name;
  final double? price;
  final int? duration;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Plan.fromJson(Map<String, dynamic> json){
    return Plan(
      id: json["_id"],
      name: json["name"],
      price: json["price"] != null ? (json["price"] as num).toDouble() : null,
      duration: json["duration"],
      description: json["description"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
