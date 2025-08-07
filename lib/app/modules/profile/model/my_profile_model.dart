class MyProfileModel {
  MyProfileModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final ProfileData? data;

  factory MyProfileModel.fromJson(Map<String, dynamic> json){
    return MyProfileModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
    );
  }

}

class ProfileData {
  ProfileData({
    required this.id,
    required this.email,
    required this.v,
    required this.age,
    required this.category,
    required this.coverImage,
    required this.createdAt,
    required this.gallery,
    required this.gender,
    required this.image,
    required this.isBlocked,
    required this.isDeleted,
    required this.location,
    required this.name,
    required this.ownerGallery,
    required this.ownerGender,
    required this.ownerImage,
    required this.ownerName,
    required this.ownerRelationshipStatus,
    required this.petInfo,
    required this.starBalance,
    required this.type,
    required this.updatedAt,
    required this.pointsPurchase,
    required this.pointsSpent,
    required this.ownerAge,
    required this.totalFriends,
  });

  final String? id;
  final String? email;
  final int? v;
  final int? age;
  final String? category;
  final String? coverImage;
  final DateTime? createdAt;
  final List<String> gallery;
  final String? gender;
  final String? image;
  final bool? isBlocked;
  final bool? isDeleted;
  final String? location;
  final String? name;
  final List<String> ownerGallery;
  final String? ownerGender;
  final String? ownerImage;
  final String? ownerName;
  final String? ownerRelationshipStatus;
  final String? petInfo;
  final int? starBalance;
  final String? type;
  final DateTime? updatedAt;
  final int? pointsPurchase;
  final int? pointsSpent;
  final int? ownerAge;
  final int? totalFriends;

  factory ProfileData.fromJson(Map<String, dynamic> json){
    return ProfileData(
      id: json["_id"],
      email: json["email"],
      v: json["__v"],
      age: json["age"],
      category: json["category"],
      coverImage: json["cover_image"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      gallery: json["gallery"] == null ? [] : List<String>.from(json["gallery"]!.map((x) => x)),
      gender: json["gender"],
      image: json["image"],
      isBlocked: json["is_blocked"],
      isDeleted: json["is_deleted"],
      location: json["location"],
      name: json["name"],
      ownerGallery: json["owner_gallery"] == null ? [] : List<String>.from(json["owner_gallery"]!.map((x) => x)),
      ownerGender: json["owner_gender"],
      ownerImage: json["owner_image"],
      ownerName: json["owner_name"],
      ownerRelationshipStatus: json["owner_relationship_status"],
      petInfo: json["pet_info"],
      starBalance: json["star_balance"],
      type: json["type"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      pointsPurchase: json["points_purchase"],
      pointsSpent: json["points_spent"],
      ownerAge: json["owner_age"],
      totalFriends: json["total_friends"],
    );
  }

}
