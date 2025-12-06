class MyPostModel {
  MyPostModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory MyPostModel.fromJson(Map<String, dynamic> json){
    return MyPostModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.data,
    required this.meta,
  });

  final List<MyPostDatum> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<MyPostDatum>.from(json["data"]!.map((x) => MyPostDatum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

}

class MyPostDatum {
  MyPostDatum({
    required this.id,
    required this.location,
    required this.category,
    required this.images,
    required this.caption,
    required this.author,
    required this.isDeleted,
    required this.isBlocked,
    required this.notInterests,
    required this.reactions,
    required this.stars,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? location;
  final String? category;
  final List<String> images;
  final String? caption;
  final Author? author;
  final bool? isDeleted;
  final bool? isBlocked;
  final List<String> notInterests;
  final List<dynamic> reactions;
  final List<dynamic> stars;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory MyPostDatum.fromJson(Map<String, dynamic> json){
    return MyPostDatum(
      id: json["_id"],
      location: json["location"],
      category: json["category"],
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      caption: json["caption"],
      author: json["author"] == null ? null : Author.fromJson(json["author"]),
      isDeleted: json["is_deleted"],
      isBlocked: json["is_blocked"],
      notInterests: json["not_interests"] == null ? [] : List<String>.from(json["not_interests"]!.map((x) => x)),
      reactions: json["reactions"] == null ? [] : List<dynamic>.from(json["reactions"]!.map((x) => x)),
      stars: json["stars"] == null ? [] : List<dynamic>.from(json["stars"]!.map((x) => x)),
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

class Meta {
  Meta({
    required this.total,
  });

  final int? total;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      total: json["total"],
    );
  }

}
