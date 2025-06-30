class AllCategoryModel {
  AllCategoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory AllCategoryModel.fromJson(Map<String, dynamic> json){
    return AllCategoryModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.image,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? image;
  final String? name;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      image: json["image"],
      name: json["name"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
