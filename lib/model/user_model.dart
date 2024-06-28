class User {
  String? status;
  String? token;
  EmployeeDetails? employeeDetails;
  String? imageUrl;
  String? defaultImagePath;
  String? message;

  User(
      {this.status,
        this.token,
        this.employeeDetails,
        this.imageUrl,
        this.defaultImagePath,
        this.message});

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    employeeDetails = json['Employee Details'] != null
        ? new EmployeeDetails.fromJson(json['Employee Details'])
        : null;
    imageUrl = json['image_url'];
    defaultImagePath = json['default_image_path'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.employeeDetails != null) {
      data['Employee Details'] = this.employeeDetails!.toJson();
    }
    data['image_url'] = this.imageUrl;
    data['default_image_path'] = this.defaultImagePath;
    data['message'] = this.message;
    return data;
  }
}

class EmployeeDetails {
  int? id;
  String? name;
  String? dob;
  String? gender;
  String? phone;
  String? address;
  String? email;
  String? password;
  String? vp;
  String? profilePic;
 // Null? accountHolderName;
  String? isActive;
  String? apiToken;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  EmployeeDetails(
      {this.id,
        this.name,
        this.dob,
        this.gender,
        this.phone,
        this.address,
        this.email,
        this.password,
        this.vp,
        this.profilePic,
      //  this.accountHolderName,
        this.isActive,
        this.apiToken,
        this.createdBy,
        this.createdAt,
        this.updatedAt});

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dob = json['dob'];
    gender = json['gender'];
    phone = json['phone'];
    address = json['address'];
    email = json['email'];
    password = json['password'];
    vp = json['vp'];
    profilePic = json['profile_pic'];
  //  accountHolderName = json['account_holder_name'];
    isActive = json['is_active'];
    apiToken = json['api_token'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['email'] = this.email;
    data['password'] = this.password;
    data['vp'] = this.vp;
    data['profile_pic'] = this.profilePic;
 //   data['account_holder_name'] = this.accountHolderName;
    data['is_active'] = this.isActive;
    data['api_token'] = this.apiToken;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
