class CheckSubscriptionAccessModel {
  CheckSubscriptionAccessModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory CheckSubscriptionAccessModel.fromJson(Map<String, dynamic> json) {
    return CheckSubscriptionAccessModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.hasAccess,
  });

  final bool? hasAccess;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      hasAccess: json["has_access"],
    );
  }
}
