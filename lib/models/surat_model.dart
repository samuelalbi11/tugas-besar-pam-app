// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

SuratModel postModelFromJson(String str) => SuratModel.fromJson(json.decode(str));

String postModelToJson(SuratModel data) => json.encode(data.toJson());

class SuratModel {
  SuratModel({
    this.id,
    this.userId,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? userId;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory SuratModel.fromJson(Map<String, dynamic> json) => SuratModel(
        id: json["id"],
        userId: json["user_id"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "content": content,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? username;
  String? email;
  dynamic? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
