class MyReelsModel {
  MyReelsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<MyReelsData> data;

  factory MyReelsModel.fromJson(Map<String, dynamic> json){
    return MyReelsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<MyReelsData>.from(json["data"]!.map((x) => MyReelsData.fromJson(x))),
    );
  }

}

class MyReelsData {
  MyReelsData({
    required this.id,
    required this.video,
    required this.caption,
    required this.author,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? video;
  final String? caption;
  final String? author;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory MyReelsData.fromJson(Map<String, dynamic> json){
    return MyReelsData(
      id: json["_id"],
      video: json["video"],
      caption: json["caption"],
      author: json["author"],
      isDeleted: json["is_deleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
