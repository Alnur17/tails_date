class MyCollectionsModel {
  MyCollectionsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory MyCollectionsModel.fromJson(Map<String, dynamic> json){
    return MyCollectionsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.user,
    required this.post,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? user;
  final Post? post;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      user: json["user"],
      post: json["post"] == null ? null : Post.fromJson(json["post"]),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class Post {
  Post({
    required this.reactions,
    required this.stars,
    required this.id,
    required this.location,
    required this.category,
    required this.images,
    required this.caption,
    required this.author,
    required this.isDeleted,
    required this.isBlocked,
    required this.notInterests,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final List<dynamic> reactions;
  final List<dynamic> stars;
  final String? id;
  final String? location;
  final String? category;
  final List<String> images;
  final String? caption;
  final Author? author;
  final bool? isDeleted;
  final bool? isBlocked;
  final List<dynamic> notInterests;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      reactions: json["reactions"] == null ? [] : List<dynamic>.from(json["reactions"]!.map((x) => x)),
      stars: json["stars"] == null ? [] : List<dynamic>.from(json["stars"]!.map((x) => x)),
      id: json["_id"],
      location: json["location"],
      category: json["category"],
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      caption: json["caption"],
      author: json["author"] == null ? null : Author.fromJson(json["author"]),
      isDeleted: json["is_deleted"],
      isBlocked: json["is_blocked"],
      notInterests: json["not_interests"] == null ? [] : List<dynamic>.from(json["not_interests"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class Author {
  Author({
    required this.id,
    required this.image,
    required this.location,
    required this.name,
  });

  final String? id;
  final String? image;
  final String? location;
  final String? name;

  factory Author.fromJson(Map<String, dynamic> json){
    return Author(
      id: json["_id"],
      image: json["image"],
      location: json["location"],
      name: json["name"],
    );
  }

}
