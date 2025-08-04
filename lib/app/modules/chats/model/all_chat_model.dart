class AllChatModel {
  AllChatModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<AllChatDatum> data;

  factory AllChatModel.fromJson(Map<String, dynamic> json){
    return AllChatModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<AllChatDatum>.from(json["data"]!.map((x) => AllChatDatum.fromJson(x))),
    );
  }

}

class AllChatDatum {
  AllChatDatum({
    required this.id,
    required this.participants,
    required this.lastMessage,
  });

  final String? id;
  final List<Participant> participants;
  final List<LastMessage> lastMessage;

  factory AllChatDatum.fromJson(Map<String, dynamic> json){
    return AllChatDatum(
      id: json["_id"],
      participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
      lastMessage: json["last_message"] == null ? [] : List<LastMessage>.from(json["last_message"]!.map((x) => LastMessage.fromJson(x))),
    );
  }

}

class LastMessage {
  LastMessage({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.chat,
    required this.text,
    required this.seen,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? sender;
  final String? receiver;
  final String? chat;
  final String? text;
  final bool? seen;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory LastMessage.fromJson(Map<String, dynamic> json){
    return LastMessage(
      id: json["_id"],
      sender: json["sender"],
      receiver: json["receiver"],
      chat: json["chat"],
      text: json["text"],
      seen: json["seen"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class Participant {
  Participant({
    required this.id,
    required this.image,
    required this.name,
  });

  final String? id;
  final String? image;
  final String? name;

  factory Participant.fromJson(Map<String, dynamic> json){
    return Participant(
      id: json["_id"],
      image: json["image"],
      name: json["name"],
    );
  }

}
