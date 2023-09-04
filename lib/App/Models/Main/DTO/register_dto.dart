class RegisterDTO {
  String? name;
  String? nId;
  String? phone;
  String? password;

  RegisterDTO({this.name, this.nId, this.phone, this.password});

  RegisterDTO.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nId = json['nId'];
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['nId'] = nId;
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}
