class UserModel {
  String? userId;
  String? name;
  String? nId;
  String? phone;
  String? password;

  UserModel({this.userId, this.name, this.nId, this.phone, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    nId = json['nId'];
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['nId'] = nId;
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}
