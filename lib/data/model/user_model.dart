class UserModel {
  String? sId;
  String? role;
  String? fullName;
  String? email;
  String? password;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? pinCode;
  int? profileProgress;
  String? id;
  String? updatedOn;
  String? createdOn;

  UserModel({
    this.sId,
    this.role,
    this.fullName,
    this.email,
    this.password,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.pinCode,
    this.profileProgress,
    this.id,
    this.updatedOn,
    this.createdOn,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pinCode = json['pinCode'];
    profileProgress = json['profileProgress'];
    id = json['id'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['role'] = role;
    data['fullName'] = fullName;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['pinCode'] = pinCode;
    data['profileProgress'] = profileProgress;
    data['id'] = id;
    data['updatedOn'] = updatedOn;
    data['createdOn'] = createdOn;
    return data;
  }
}
