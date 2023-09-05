class CheckURLDTO {
  Client? client;
  ThreatInfo? threatInfo;

  CheckURLDTO({this.client, this.threatInfo});

  CheckURLDTO.fromJson(Map<String, dynamic> json) {
    client =
        json['client'] != null ? Client.fromJson(json['client']) : null;
    threatInfo = json['threatInfo'] != null
        ? ThreatInfo.fromJson(json['threatInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (threatInfo != null) {
      data['threatInfo'] = threatInfo!.toJson();
    }
    return data;
  }
}

class Client {
  String? clientId;
  String? clientVersion;

  Client({this.clientId, this.clientVersion});

  Client.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'];
    clientVersion = json['clientVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clientId'] = clientId;
    data['clientVersion'] = clientVersion;
    return data;
  }
}

class ThreatInfo {
  List<String>? threatTypes;
  List<String>? platformTypes;
  List<String>? threatEntryTypes;
  List<ThreatEntries>? threatEntries;

  ThreatInfo(
      {this.threatTypes,
      this.platformTypes,
      this.threatEntryTypes,
      this.threatEntries});

  ThreatInfo.fromJson(Map<String, dynamic> json) {
    threatTypes = json['threatTypes'].cast<String>();
    platformTypes = json['platformTypes'].cast<String>();
    threatEntryTypes = json['threatEntryTypes'].cast<String>();
    if (json['threatEntries'] != null) {
      threatEntries = <ThreatEntries>[];
      json['threatEntries'].forEach((v) {
        threatEntries!.add(ThreatEntries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['threatTypes'] = threatTypes;
    data['platformTypes'] = platformTypes;
    data['threatEntryTypes'] = threatEntryTypes;
    if (threatEntries != null) {
      data['threatEntries'] =
          threatEntries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ThreatEntries {
  String? url;

  ThreatEntries({this.url});

  ThreatEntries.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}
