// class User {
//   String? status;
//   String? token;
//   EmployeeDetails? employeeDetails;
//   String? imageUrl;
//   String? defaultImagePath;
//   String? message;
//
//   User(
//       {this.status,
//         this.token,
//         this.employeeDetails,
//         this.imageUrl,
//         this.defaultImagePath,
//         this.message});
//
//   User.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     token = json['token'];
//     employeeDetails = json['Employee Details'] != null
//         ? new EmployeeDetails.fromJson(json['Employee Details'])
//         : null;
//     imageUrl = json['image_url'];
//     defaultImagePath = json['default_image_path'];
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['token'] = this.token;
//     if (this.employeeDetails != null) {
//       data['Employee Details'] = this.employeeDetails!.toJson();
//     }
//     data['image_url'] = this.imageUrl;
//     data['default_image_path'] = this.defaultImagePath;
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class EmployeeDetails {
//   int? id;
//   String? name;
//   String? dob;
//   String? gender;
//   String? phone;
//   String? address;
//   String? email;
//   String? password;
//   String? vp;
//   String? profilePic;
//   String? accountHolderName;
//   bool? isActive;
//   String? apiToken;
//   int? fkStateId;
//   int? fkDistrictId;
//   int? fkCityId;
//   int? fkZipcodeId;
//   int? createdBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   EmployeeDetails(
//       {this.id,
//         this.name,
//         this.dob,
//         this.gender,
//         this.phone,
//         this.address,
//         this.email,
//         this.password,
//         this.vp,
//         this.profilePic,
//         this.accountHolderName,
//         this.isActive,
//         this.apiToken,
//         this.fkStateId,
//         this.fkDistrictId,
//         this.fkCityId,
//         this.fkZipcodeId,
//         this.createdBy,
//         this.createdAt,
//         this.updatedAt});
//
//   EmployeeDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     dob = json['dob'];
//     gender = json['gender'];
//     phone = json['phone'];
//     address = json['address'];
//     email = json['email'];
//     password = json['password'];
//     vp = json['vp'];
//     profilePic = json['profile_pic'];
//     accountHolderName = json['account_holder_name']?.toString();
//     isActive = json['is_active'] == 1; // Assuming `is_active` is 1 for true and 0 for false
//     apiToken = json['api_token'];
//     fkStateId = json['fk_state_id'];
//     fkDistrictId = json['fk_district_id'];
//     fkCityId = json['fk_city_id'];
//     fkZipcodeId = json['fk_zipcode_id'];
//     createdBy = json['created_by'];
//     createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
//     updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['dob'] = this.dob;
//     data['gender'] = this.gender;
//     data['phone'] = this.phone;
//     data['address'] = this.address;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['vp'] = this.vp;
//     data['profile_pic'] = this.profilePic;
//     data['account_holder_name'] = this.accountHolderName;
//     data['is_active'] = this.isActive == true ? 1 : 0; // Convert bool back to int
//     data['api_token'] = this.apiToken;
//     data['fk_state_id'] = this.fkStateId;
//     data['fk_district_id'] = this.fkDistrictId;
//     data['fk_city_id'] = this.fkCityId;
//     data['fk_zipcode_id'] = this.fkZipcodeId;
//     data['created_by'] = this.createdBy;
//     data['created_at'] = this.createdAt?.toIso8601String();
//     data['updated_at'] = this.updatedAt?.toIso8601String();
//     return data;
//   }
// }




// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? status;
  String? token;
  EmployeeDetails? employeeDetails;
  String? imageUrl;
  String? defaultImagePath;
  String? message;

  User({
    this.status,
    this.token,
    this.employeeDetails,
    this.imageUrl,
    this.defaultImagePath,
    this.message,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    status: json["status"],
    token: json["token"],
    employeeDetails: EmployeeDetails.fromJson(json["Employee Details"]),
    imageUrl: json["image_url"],
    defaultImagePath: json["default_image_path"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "Employee Details": employeeDetails!.toJson(),
    "image_url": imageUrl,
    "default_image_path": defaultImagePath,
    "message": message,
  };
}

class EmployeeDetails {
  int? id;
  String? name;
  DateTime? dob;
  String? gender;
  String? phone;
  String? address;
  String? email;
  String? password;
  String? vp;
  String? profilePic;
  dynamic accountHolderName;
  String? isActive;
  String? apiToken;
  String? fkStateId;
  String? fkDistrictId;
  String? fkCityId;
  String? fkZipcodeId;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  EmployeeDetails({
    this.id,
    this.name,
    this.dob,
    this.gender,
    this.phone,
    this.address,
    this.email,
    this.password,
    this.vp,
    this.profilePic,
    this.accountHolderName,
    this.isActive,
    this.apiToken,
    this.fkStateId,
    this.fkDistrictId,
    this.fkCityId,
    this.fkZipcodeId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) => EmployeeDetails(
    id: json["id"],
    name: json["name"],
    dob: DateTime.parse(json["dob"]),
    gender: json["gender"],
    phone: json["phone"],
    address: json["address"],
    email: json["email"],
    password: json["password"],
    vp: json["vp"],
    profilePic: json["profile_pic"],
    accountHolderName: json["account_holder_name"],
    isActive: json["is_active"],
    apiToken: json["api_token"],
    fkStateId: json["fk_state_id"],
    fkDistrictId: json["fk_district_id"],
    fkCityId: json["fk_city_id"],
    fkZipcodeId: json["fk_zipcode_id"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "phone": phone,
    "address": address,
    "email": email,
    "password": password,
    "vp": vp,
    "profile_pic": profilePic,
    "account_holder_name": accountHolderName,
    "is_active": isActive,
    "api_token": apiToken,
    "fk_state_id": fkStateId,
    "fk_district_id": fkDistrictId,
    "fk_city_id": fkCityId,
    "fk_zipcode_id": fkZipcodeId,
    "created_by": createdBy,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
