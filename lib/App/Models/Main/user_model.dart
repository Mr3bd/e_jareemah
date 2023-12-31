class UserModel {
  String? userId;
  String? name;
  String? nId;
  String? phone;
  String? email;
  String? password;
  String? role;
  String? date;
  UserModel(
      {this.userId,
      this.name,
      this.nId,
      this.email,
      this.phone,
      this.password,
      this.role,
      this.date});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    nId = json['nId'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    role = json['role'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['nId'] = nId;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['role'] = role;
    data['date'] = date;
    return data;
  }
}
