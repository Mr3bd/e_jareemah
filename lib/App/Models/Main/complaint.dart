class Complaint {
  int? id;
  String? nId;
  int? type;
  int? location;
  int? locationType;
  int? status;
  String? defendant;
  String? description;
  List<String>? files = [];
  String? date;
  Complaint(
      {this.id,
      this.type,
      this.location,
      this.locationType,
      this.status,
      this.defendant,
      this.description,
      this.files,
      this.nId,
      this.date});

  Complaint.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    location = json['location'];
    locationType = json['location_type'];
    defendant = json['defendant'];
    description = json['description'];
    status = json['status'];
    nId = json['nId'];
    if (json['files'] == null) {
      files = [];
    } else {
      files = json['files'].cast<String>();
    }
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['location'] = location;
    data['location_type'] = locationType;
    data['status'] = status;
    data['defendant'] = defendant;
    data['description'] = description;
    data['nId'] = nId;
    data['files'] = files;
    data['date'] = date;
    return data;
  }
}
