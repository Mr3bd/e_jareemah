class ComplaintCat {
  int? id;
  String? name;
  String? color;
  ComplaintCat({this.id, this.name, this.color});

  ComplaintCat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    return data;
  }
}
