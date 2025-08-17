class GetAuthorStoryByIdModel {
  GetAuthorStoryByIdModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<AuthSBIdDatum> data;

  factory GetAuthorStoryByIdModel.fromJson(Map<String, dynamic> json){
    return GetAuthorStoryByIdModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<AuthSBIdDatum>.from(json["data"]!.map((x) => AuthSBIdDatum.fromJson(x))),
    );
  }

}

class AuthSBIdDatum {
  AuthSBIdDatum({
    required this.id,
    required this.image,
    required this.caption,
    required this.author,
    required this.reactions,
    required this.stars,
    required this.isDeleted,
    required this.expireAt,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? image;
  final String? caption;
  final String? author;
  final List<dynamic> reactions;
  final List<dynamic> stars;
  final bool? isDeleted;
  final DateTime? expireAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory AuthSBIdDatum.fromJson(Map<String, dynamic> json){
    return AuthSBIdDatum(
      id: json["_id"],
      image: json["image"],
      caption: json["caption"],
      author: json["author"],
      reactions: json["reactions"] == null ? [] : List<dynamic>.from(json["reactions"]!.map((x) => x)),
      stars: json["stars"] == null ? [] : List<dynamic>.from(json["stars"]!.map((x) => x)),
      isDeleted: json["is_deleted"],
      expireAt: DateTime.tryParse(json["expireAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
