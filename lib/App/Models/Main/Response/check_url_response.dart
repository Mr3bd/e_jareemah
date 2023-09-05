class CheckURLResponse {
  List<Matches>? matches;

  CheckURLResponse({this.matches});

  CheckURLResponse.fromJson(Map<String, dynamic> json) {
    if (json['matches'] != null) {
      matches = <Matches>[];
      json['matches'].forEach((v) {
        matches!.add(Matches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (matches != null) {
      data['matches'] = matches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Matches {
  String? threatType;
  String? platformType;
  Threat? threat;
  String? cacheDuration;
  String? threatEntryType;

  Matches(
      {this.threatType,
      this.platformType,
      this.threat,
      this.cacheDuration,
      this.threatEntryType});

  Matches.fromJson(Map<String, dynamic> json) {
    threatType = json['threatType'];
    platformType = json['platformType'];
    threat =
        json['threat'] != null ? Threat.fromJson(json['threat']) : null;
    cacheDuration = json['cacheDuration'];
    threatEntryType = json['threatEntryType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['threatType'] = threatType;
    data['platformType'] = platformType;
    if (threat != null) {
      data['threat'] = threat!.toJson();
    }
    data['cacheDuration'] = cacheDuration;
    data['threatEntryType'] = threatEntryType;
    return data;
  }
}

class Threat {
  String? url;

  Threat({this.url});

  Threat.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}
