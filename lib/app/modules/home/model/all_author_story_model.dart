class AllAuthorStoryModel {
  AllAuthorStoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<AllAuthDatum> data;

  factory AllAuthorStoryModel.fromJson(Map<String, dynamic> json){
    return AllAuthorStoryModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<AllAuthDatum>.from(json["data"]!.map((x) => AllAuthDatum.fromJson(x))),
    );
  }

}

class AllAuthDatum {
  AllAuthDatum({
    required this.id,
    required this.name,
    required this.image,
  });

  final String? id;
  final String? name;
  final String? image;

  factory AllAuthDatum.fromJson(Map<String, dynamic> json){
    return AllAuthDatum(
      id: json["_id"],
      name: json["name"],
      image: json["image"],
    );
  }

}
