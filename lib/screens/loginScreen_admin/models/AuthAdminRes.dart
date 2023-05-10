class AuthAdminRes {
  String? message;
  bool? isSuccess;
  Data? data;

  AuthAdminRes({this.message, this.isSuccess, this.data});

  AuthAdminRes.fromJson(Map<String, dynamic> json) {
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
  List<Patients>? patients;
  List<String>? emergencies;

  Admin(
      {this.sId,
        this.username,
        this.role,
        this.gender,
        this.phoneNumber,
        this.age,
        this.email,
        this.patients,
        this.emergencies});

  Admin.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    role = json['role'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    age = json['age'];
    email = json['email'];
    if (json['patients'] != null) {
      patients = <Patients>[];
      json['patients'].forEach((v) {
        patients!.add(new Patients.fromJson(v));
      });
    }
    emergencies = json['emergencies'].cast<String>();
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
    if (this.patients != null) {
      data['patients'] = this.patients!.map((v) => v.toJson()).toList();
    }
    data['emergencies'] = this.emergencies;
    return data;
  }
}

class Patients {
  String? username;
  String? gender;
  String? phoneNumber;
  int? age;
  List<Reports>? reports;

  Patients(
      {this.username, this.gender, this.phoneNumber, this.age, this.reports});

  Patients.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    age = json['age'];
    if (json['reports'] != null) {
      reports = <Reports>[];
      json['reports'].forEach((v) {
        reports!.add(new Reports.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['age'] = this.age;
    if (this.reports != null) {
      data['reports'] = this.reports!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reports {
  int? spo2;
  int? heartRate;
  double? temperature;
  String? createdAt;
  String? sId;

  Reports(
      {this.spo2, this.heartRate, this.temperature, this.createdAt, this.sId});

  Reports.fromJson(Map<String, dynamic> json) {
    spo2 = json['spo2'];
    heartRate = json['heartRate'];
    temperature = json['temperature'];
    createdAt = json['createdAt'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spo2'] = this.spo2;
    data['heartRate'] = this.heartRate;
    data['temperature'] = this.temperature;
    data['createdAt'] = this.createdAt;
    data['_id'] = this.sId;
    return data;
  }
}
