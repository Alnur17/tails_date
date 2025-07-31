class FriendSuggestionsModel {
  FriendSuggestionsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<FSuggestionsDatum> data;

  factory FriendSuggestionsModel.fromJson(Map<String, dynamic> json){
    return FriendSuggestionsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<FSuggestionsDatum>.from(json["data"]!.map((x) => FSuggestionsDatum.fromJson(x))),
    );
  }

}

class FSuggestionsDatum {
  FSuggestionsDatum({
    required this.pointsPurchase,
    required this.pointsSpent,
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
  });

  final int? pointsPurchase;
  final int? pointsSpent;
  final String? id;
  final String? email;
  final int? v;
  final dynamic age;
  final String? category;
  final String? coverImage;
  final DateTime? createdAt;
  final dynamic gallery;
  final dynamic gender;
  final String? image;
  final bool? isBlocked;
  final bool? isDeleted;
  final dynamic location;
  final String? name;
  final dynamic ownerGallery;
  final dynamic ownerGender;
  final String? ownerImage;
  final dynamic ownerName;
  final dynamic ownerRelationshipStatus;
  final dynamic petInfo;
  final int? starBalance;
  final String? type;
  final DateTime? updatedAt;

  factory FSuggestionsDatum.fromJson(Map<String, dynamic> json){
    return FSuggestionsDatum(
      pointsPurchase: json["points_purchase"],
      pointsSpent: json["points_spent"],
      id: json["_id"],
      email: json["email"],
      v: json["__v"],
      age: json["age"],
      category: json["category"],
      coverImage: json["cover_image"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      gallery: json["gallery"],
      gender: json["gender"],
      image: json["image"],
      isBlocked: json["is_blocked"],
      isDeleted: json["is_deleted"],
      location: json["location"],
      name: json["name"],
      ownerGallery: json["owner_gallery"],
      ownerGender: json["owner_gender"],
      ownerImage: json["owner_image"],
      ownerName: json["owner_name"],
      ownerRelationshipStatus: json["owner_relationship_status"],
      petInfo: json["pet_info"],
      starBalance: json["star_balance"],
      type: json["type"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
