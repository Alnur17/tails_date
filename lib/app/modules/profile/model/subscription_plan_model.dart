class SubscriptionPlanModel {
  SubscriptionPlanModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<SubscriptionPlanData> data;

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json){
    return SubscriptionPlanModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<SubscriptionPlanData>.from(json["data"]!.map((x) => SubscriptionPlanData.fromJson(x))),
    );
  }

}

class SubscriptionPlanData {
  SubscriptionPlanData({
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

  factory SubscriptionPlanData.fromJson(Map<String, dynamic> json){
    return SubscriptionPlanData(
      id: json["_id"],
      name: json["name"],
      price: json["price"],
      duration: json["duration"],
      description: json["description"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
