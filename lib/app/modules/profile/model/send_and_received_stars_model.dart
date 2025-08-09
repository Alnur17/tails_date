class SendAndReceivedStarsModel {
  SendAndReceivedStarsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<SARStarsDatum> data;

  factory SendAndReceivedStarsModel.fromJson(Map<String, dynamic> json){
    return SendAndReceivedStarsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<SARStarsDatum>.from(json["data"]!.map((x) => SARStarsDatum.fromJson(x))),
    );
  }

}

class SARStarsDatum {
  SARStarsDatum({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.post,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.postType,
  });

  final String? id;
  final Receiver? sender;
  final Receiver? receiver;
  final int? amount;
  final dynamic? post;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? postType;

  factory SARStarsDatum.fromJson(Map<String, dynamic> json){
    return SARStarsDatum(
      id: json["_id"],
      sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
      receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
      amount: json["amount"],
      post: json["post"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      postType: json["post_type"],
    );
  }

}

class PostClass {
  PostClass({
    required this.id,
    required this.image,
    required this.caption,
    required this.author,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.stars,
    required this.reactions,
  });

  final String? id;
  final String? image;
  final String? caption;
  final Author? author;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<String> stars;
  final List<String> reactions;

  factory PostClass.fromJson(Map<String, dynamic> json){
    return PostClass(
      id: json["_id"],
      image: json["image"],
      caption: json["caption"],
      author: json["author"] == null ? null : Author.fromJson(json["author"]),
      isDeleted: json["is_deleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      stars: json["stars"] == null ? [] : List<String>.from(json["stars"]!.map((x) => x)),
      reactions: json["reactions"] == null ? [] : List<String>.from(json["reactions"]!.map((x) => x)),
    );
  }

}

class Author {
  Author({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Author.fromJson(Map<String, dynamic> json){
    return Author(
      id: json["_id"],
      name: json["name"],
    );
  }

}

class Receiver {
  Receiver({
    required this.id,
    required this.image,
    required this.name,
  });

  final String? id;
  final String? image;
  final String? name;

  factory Receiver.fromJson(Map<String, dynamic> json){
    return Receiver(
      id: json["_id"],
      image: json["image"],
      name: json["name"],
    );
  }

}
