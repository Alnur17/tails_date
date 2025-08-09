class CashOutStatusModel {
  CashOutStatusModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<CashOutStatusDatum> data;

  factory CashOutStatusModel.fromJson(Map<String, dynamic> json){
    return CashOutStatusModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<CashOutStatusDatum>.from(json["data"]!.map((x) => CashOutStatusDatum.fromJson(x))),
    );
  }

}

class CashOutStatusDatum {
  CashOutStatusDatum({
    required this.id,
    required this.user,
    required this.amount,
    required this.stars,
    required this.status,
    required this.rejectionReason,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final User? user;
  final int? amount;
  final int? stars;
  final String? status;
  final dynamic rejectionReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory CashOutStatusDatum.fromJson(Map<String, dynamic> json){
    return CashOutStatusDatum(
      id: json["_id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      amount: json["amount"],
      stars: json["stars"],
      status: json["status"],
      rejectionReason: json["rejection_reason"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class User {
  User({
    required this.id,
    required this.image,
    required this.name,
    required this.starBalance,
  });

  final String? id;
  final String? image;
  final String? name;
  final int? starBalance;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["_id"],
      image: json["image"],
      name: json["name"],
      starBalance: json["star_balance"],
    );
  }

}
