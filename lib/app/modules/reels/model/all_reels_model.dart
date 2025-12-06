// class AllReelsModel {
//   AllReelsModel({
//     required this.success,
//     required this.message,
//     required this.data,
//   });
//
//   final bool? success;
//   final String? message;
//   final Data? data;
//
//   factory AllReelsModel.fromJson(Map<String, dynamic> json){
//     return AllReelsModel(
//       success: json["success"],
//       message: json["message"],
//       data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     );
//   }
//
// }
//
// class Data {
//   Data({
//     required this.data,
//     required this.meta,
//   });
//
//   final List<Datum> data;
//   final Meta? meta;
//
//   factory Data.fromJson(Map<String, dynamic> json){
//     return Data(
//       data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//       meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
//     );
//   }
//
// }
//
// class Datum {
//   Datum({
//     required this.id,
//     required this.video,
//     required this.caption,
//     required this.author,
//     required this.isDeleted,
//     required this.createdAt,
//     required this.reactions,
//     required this.isReacted,
//   });
//
//   final String? id;
//   final String? video;
//   final String? caption;
//   final Author? author;
//   final bool? isDeleted;
//   final DateTime? createdAt;
//   final List<dynamic> reactions;
//   final bool? isReacted;
//
//   factory Datum.fromJson(Map<String, dynamic> json){
//     return Datum(
//       id: json["_id"],
//       video: json["video"],
//       caption: json["caption"],
//       author: json["author"] == null ? null : Author.fromJson(json["author"]),
//       isDeleted: json["is_deleted"],
//       createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//       reactions: json["reactions"] == null ? [] : List<dynamic>.from(json["reactions"]!.map((x) => x)),
//       isReacted: json["isReacted"],
//     );
//   }
//
// }
//
// class Author {
//   Author({
//     required this.id,
//     required this.image,
//     required this.location,
//     required this.name,
//   });
//
//   final String? id;
//   final String? image;
//   final String? location;
//   final String? name;
//
//   factory Author.fromJson(Map<String, dynamic> json){
//     return Author(
//       id: json["_id"],
//       image: json["image"],
//       location: json["location"],
//       name: json["name"],
//     );
//   }
//
// }
//
// class Meta {
//   Meta({
//     required this.total,
//   });
//
//   final int? total;
//
//   factory Meta.fromJson(Map<String, dynamic> json){
//     return Meta(
//       total: json["total"],
//     );
//   }
//
// }

class AllReelsModel {
  AllReelsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory AllReelsModel.fromJson(Map<String, dynamic> json) {
    return AllReelsModel(
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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.video,
    required this.caption,
    required this.author,
    required this.isDeleted,
    required this.createdAt,
    required this.reactions,
    required this.isReacted,
  });

  final String? id;
  final String? video;
  final String? caption;
  final Author? author;
  final bool? isDeleted;
  final DateTime? createdAt;
  final List<dynamic> reactions;
  final bool? isReacted;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["_id"],
      video: json["video"],
      caption: json["caption"],
      author:
      json["author"] == null ? null : Author.fromJson(json["author"]),
      isDeleted: json["is_deleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      reactions: json["reactions"] == null
          ? []
          : List<dynamic>.from(json["reactions"]!.map((x) => x)),
      isReacted: json["isReacted"],
    );
  }

  /// Add copyWith for safe updates
  Datum copyWith({
    String? id,
    String? video,
    String? caption,
    Author? author,
    bool? isDeleted,
    DateTime? createdAt,
    List<dynamic>? reactions,
    bool? isReacted,
  }) {
    return Datum(
      id: id ?? this.id,
      video: video ?? this.video,
      caption: caption ?? this.caption,
      author: author ?? this.author,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      reactions: reactions ?? this.reactions,
      isReacted: isReacted ?? this.isReacted,
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

  factory Author.fromJson(Map<String, dynamic> json) {
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

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json["total"],
    );
  }
}
