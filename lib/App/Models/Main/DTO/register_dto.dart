class RegisterDTO {
  String? name;
  String? nId;
  String? phone;
  String? password;
  String? role;
  String? date;
  RegisterDTO(
      {this.name,
      this.nId,
      this.phone,
      this.password,
      this.date,
      this.role = 'user'});

  RegisterDTO.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nId = json['nId'];
    phone = json['phone'];
    password = json['password'];
    role = json['role'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['nId'] = nId;
    data['phone'] = phone;
    data['password'] = password;
    data['role'] = role;
    data['date'] = date;
    return data;
  }
}
