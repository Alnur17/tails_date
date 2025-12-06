class OtherPetDetailsModel {
  OtherPetDetailsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory OtherPetDetailsModel.fromJson(Map<String, dynamic> json){
    return OtherPetDetailsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.parent,
    required this.name,
    required this.image,
    required this.gender,
    required this.age,
    required this.category,
    required this.info,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? parent;
  final String? name;
  final String? image;
  final String? gender;
  final int? age;
  final Category? category;
  final String? info;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      parent: json["parent"],
      name: json["name"],
      image: json["image"],
      gender: json["gender"],
      age: json["age"],
      category: json["category"] == null ? null : Category.fromJson(json["category"]),
      info: json["info"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json["_id"],
      name: json["name"],
    );
  }

}
