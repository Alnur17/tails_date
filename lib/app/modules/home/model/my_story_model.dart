class MyStoryModel {
  MyStoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory MyStoryModel.fromJson(Map<String, dynamic> json){
    return MyStoryModel(
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

  final List<MyStoryDatum> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<MyStoryDatum>.from(json["data"]!.map((x) => MyStoryDatum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

}

class MyStoryDatum {
  MyStoryDatum({
    required this.id,
    required this.image,
    required this.caption,
    required this.author,
    required this.reactions,
    required this.stars,
    required this.isDeleted,
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory MyStoryDatum.fromJson(Map<String, dynamic> json){
    return MyStoryDatum(
      id: json["_id"],
      image: json["image"],
      caption: json["caption"],
      author: json["author"],
      reactions: json["reactions"] == null ? [] : List<dynamic>.from(json["reactions"]!.map((x) => x)),
      stars: json["stars"] == null ? [] : List<dynamic>.from(json["stars"]!.map((x) => x)),
      isDeleted: json["is_deleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
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
