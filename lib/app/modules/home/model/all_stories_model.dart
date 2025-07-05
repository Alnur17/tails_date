class AllStoriesModel {
  AllStoriesModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory AllStoriesModel.fromJson(Map<String, dynamic> json){
    return AllStoriesModel(
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

  final List<Datum> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.image,
    required this.caption,
    required this.author,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? image;
  final String? caption;
  final Author? author;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      image: json["image"],
      caption: json["caption"],
      author: json["author"] == null ? null : Author.fromJson(json["author"]),
      isDeleted: json["is_deleted"],
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
