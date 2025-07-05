class AllPostModel {
  AllPostModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory AllPostModel.fromJson(Map<String, dynamic> json){
    return AllPostModel(
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

  final List<AllPostData> data;
  final int? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<AllPostData>.from(json["data"]!.map((x) => AllPostData.fromJson(x))),
      meta: json["meta"],
    );
  }

}

class AllPostData {
  AllPostData({
    required this.id,
    required this.location,
    required this.images,
    required this.caption,
    required this.author,
    required this.createdAt,
  });

  final String? id;
  final String? location;
  final List<String> images;
  final String? caption;
  final Author? author;
  final DateTime? createdAt;

  factory AllPostData.fromJson(Map<String, dynamic> json){
    return AllPostData(
      id: json["_id"],
      location: json["location"],
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      caption: json["caption"],
      author: json["author"] == null ? null : Author.fromJson(json["author"]),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

}

class Author {
  Author({
    required this.image,
    required this.name,
  });

  final String? image;
  final String? name;

  factory Author.fromJson(Map<String, dynamic> json){
    return Author(
      image: json["image"],
      name: json["name"],
    );
  }

}
