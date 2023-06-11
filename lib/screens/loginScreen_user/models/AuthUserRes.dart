class AuthUserRes {
  String? message;
  bool? isSuccess;
  Data? data;

  AuthUserRes({this.message, this.isSuccess, this.data});

  AuthUserRes.fromJson(Map<String, dynamic> json) {
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
  Patient? patient;

  Data({this.patient});

  Data.fromJson(Map<String, dynamic> json) {
    patient =
    json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    return data;
  }
}

class Patient {
  String? sId;
  String? username;
  String? gender;
  String? phoneNumber;
  int? age;
  Device? device;
  List<AdminsRequests>? adminsRequests;

  Patient(
      {this.sId,
        this.username,
        this.gender,
        this.phoneNumber,
        this.age,
        this.device,
        this.adminsRequests});

  Patient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    age = json['age'];
    device =
    json['device'] != null ? new Device.fromJson(json['device']) : null;
    if (json['adminsRequests'] != null) {
      adminsRequests = <AdminsRequests>[];
      json['adminsRequests'].forEach((v) {
        adminsRequests!.add(new AdminsRequests.fromJson(v));
      });
    }
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
    if (this.adminsRequests != null) {
      data['adminsRequests'] =
          this.adminsRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Device {
  String? deviceId;
  bool? fall;
  int? heartRate;
  int? spo2;
  String? temperature;

  Device(
      {this.deviceId, this.fall, this.heartRate, this.spo2, this.temperature});

  Device.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    fall = json['fall'];
    heartRate = json['heartRate'];
    spo2 = json['spo2'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceId'] = this.deviceId;
    data['fall'] = this.fall;
    data['heartRate'] = this.heartRate;
    data['spo2'] = this.spo2;
    data['temperature'] = this.temperature;
    return data;
  }
}

class AdminsRequests {
  String? username;
  String? role;
  String? gender;
  String? phoneNumber;
  int? age;
  String? email;

  AdminsRequests(
      {this.username,
        this.role,
        this.gender,
        this.phoneNumber,
        this.age,
        this.email});

  AdminsRequests.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    role = json['role'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    age = json['age'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['role'] = this.role;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['age'] = this.age;
    data['email'] = this.email;
    return data;
  }
}