import 'dart:convert';

List<Users> userFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

class Users {
  Users({
    required this.userId,
    required this.userPseudo,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.userPhone,
    required this.userProfilePic,
    required this.userPackageId,
    required this.userPackagePaidDate,
    required this.userPackageExpiryDate,
    required this.userToken,
    required this.createdDate,
  });

  String userId;
  String userPseudo;
  String userName;
  String userEmail;
  String userPassword;
  String userPhone;
  String userProfilePic;
  String userPackageId;
  String userPackagePaidDate;
  DateTime userPackageExpiryDate;
  dynamic userToken;
  DateTime createdDate;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    userId: json["user_id"],
    userPseudo:json["user_pseudo"],
    userName: json["user_name"] ?? '',
    userEmail: json["user_email"] ?? '',
    userPassword: json["user_password"] ?? '',
    userPhone: json["user_phone"] ?? '',
    userProfilePic: json["user_profile_pic"] ?? '',
    userPackageId: json["user_package_id"] ?? '',
    userPackagePaidDate: json["user_package_paid_date"] ?? '',
    userPackageExpiryDate:
    DateTime.parse(json["user_package_expiry_date"] ?? ''),
    userToken: json["user_token"] ?? '',
    createdDate: DateTime.parse(json["created_date"] ?? ''),
  );
}

SignupUser signupUserFromJson(String str) =>
    SignupUser.fromJson(json.decode(str));

class SignupUser {
  SignupUser({
    required this.message,
    required this.result,
  });

  String message;
  List<Result> result;

  factory SignupUser.fromJson(Map<String, dynamic> json) => SignupUser(
    message: json["message"],
    result:
    List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );
}

class Result {
  Result({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.userPhone,
    required this.userProfilePic,
    required this.userPackageId,
    required this.userPackagePaidDate,
    required this.userPackageExpiryDate,
    required this.userToken,
    required this.createdDate,
  });

  String userId;
  String userName;
  String userEmail;
  String userPassword;
  String userPhone;
  String userProfilePic;
  String userPackageId;
  String userPackagePaidDate;
  DateTime userPackageExpiryDate;
  dynamic userToken;
  DateTime createdDate;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    userId: json["user_id"],
    userName: json["user_name"] ?? '',
    userEmail: json["user_email"] ?? '',
    userPassword: json["user_password"] ?? '',
    userPhone: json["user_phone"] ?? '',
    userProfilePic: json["user_profile_pic"] ?? '',
    userPackageId: json["user_package_id"] ?? '',
    userPackagePaidDate: json["user_package_paid_date"] ?? '',
    userPackageExpiryDate:
    DateTime.parse(json["user_package_expiry_date"] ?? ''),
    userToken: json["user_token"] ?? '',
    createdDate: DateTime.parse(json["created_date"] ?? ''),
  );
}
