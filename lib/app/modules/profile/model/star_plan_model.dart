class StarPlanModel {
  StarPlanModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<StarPlanData> data;

  factory StarPlanModel.fromJson(Map<String, dynamic> json){
    return StarPlanModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<StarPlanData>.from(json["data"]!.map((x) => StarPlanData.fromJson(x))),
    );
  }

}

class StarPlanData {
  StarPlanData({
    required this.id,
    required this.price,
    required this.stars,
    required this.status,
    required this.discountRate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final double? price;
  final int? stars;
  final String? status;
  final int? discountRate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory StarPlanData.fromJson(Map<String, dynamic> json){
    return StarPlanData(
      id: json["_id"],
      price: json["price"],
      stars: json["stars"],
      status: json["status"],
      discountRate: json["discount_rate"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
