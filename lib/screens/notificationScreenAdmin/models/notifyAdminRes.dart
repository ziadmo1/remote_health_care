class NotifyAdminRes {
  String? message;
  bool? isSuccess;
  Data? data;

  NotifyAdminRes({this.message, this.isSuccess, this.data});

  NotifyAdminRes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isSuccess = json['isSuccess'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['isSuccess'] = this.isSuccess;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Admin? admin;

  Data({this.admin});

  Data.fromJson(Map<String, dynamic> json) {
    admin = json['admin'] != null ? new Admin.fromJson(json['admin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.admin != null) {
      data['admin'] = this.admin!.toJson();
    }
    return data;
  }
}

class Admin {
  String? sId;
  String? username;
  String? role;
  String? gender;
  String? phoneNumber;
  int? age;
  String? email;
  List<Emergencies>? emergencies;

  Admin(
      {this.sId,
        this.username,
        this.role,
        this.gender,
        this.phoneNumber,
        this.age,
        this.email,
        this.emergencies});

  Admin.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    role = json['role'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    age = json['age'];
    email = json['email'];
    if (json['emergencies'] != null) {
      emergencies = <Emergencies>[];
      json['emergencies'].forEach((v) {
        emergencies!.add(new Emergencies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['role'] = this.role;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['age'] = this.age;
    data['email'] = this.email;
    if (this.emergencies != null) {
      data['emergencies'] = this.emergencies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Emergencies {
  String? sId;
  String? username;
  String? gender;
  String? phoneNumber;
  int? age;
  Device? device;

  Emergencies(
      {this.sId,
        this.username,
        this.gender,
        this.phoneNumber,
        this.age,
        this.device});

  Emergencies.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    age = json['age'];
    device =
    json['device'] != null ? new Device.fromJson(json['device']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['age'] = this.age;
    if (this.device != null) {
      data['device'] = this.device!.toJson();
    }
    return data;
  }
}

class Device {
  String? sId;
  String? deviceId;
  bool? fall;
  int? heartRate;
  int? spo2;
  String? temperature;
  String? updatedAt;
  double? lat;
  double? lng;

  Device(
      {this.sId,
        this.deviceId,
        this.fall,
        this.heartRate,
        this.spo2,
        this.temperature,
        this.updatedAt,
        this.lat,
        this.lng});

  Device.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    deviceId = json['deviceId'];
    fall = json['fall'];
    heartRate = json['heartRate'];
    spo2 = json['spo2'];
    temperature = json['temperature'];
    updatedAt = json['updatedAt'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['deviceId'] = this.deviceId;
    data['fall'] = this.fall;
    data['heartRate'] = this.heartRate;
    data['spo2'] = this.spo2;
    data['temperature'] = this.temperature;
    data['updatedAt'] = this.updatedAt;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
