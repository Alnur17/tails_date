class ConditionsModel {
  ConditionsModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory ConditionsModel.fromJson(Map<String, dynamic> json){
    return ConditionsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.termsConditions,
    required this.aboutUs,
    required this.privacyPolicy,
    required this.updatedAt,
  });

  final String? id;
  final String? termsConditions;
  final String? aboutUs;
  final String? privacyPolicy;
  final DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      termsConditions: json["terms_conditions"],
      aboutUs: json["about_us"],
      privacyPolicy: json["privacy_policy"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
